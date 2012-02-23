//
//  CJDataBase.m
//  CJFramework
//
//  Created by wang on 11-11-9.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import "CJDataBase.h"
#import "CJLog.h"
#import "NSString+CJFramework.h"

//CJSQLTable
//////////////////////////////////////////////////////////////////////////////////////
@interface CJSQLTable(PrivateMethod)

-(NSString *)description;
-(id)initWithSQL:(CJDataBase*)aDatabase sql:(NSString*)aSQLStr ;
-(void)dealloc;
@end

@implementation CJSQLTable

-(NSString*)typecode2typestring:(int)atypecode{
	switch (atypecode) {
		case 1:
			return @"INTEGER";
		case 2:
			return @"FLOAT";
		case 3:
			return @"TEXT";
		case 4:
			return @"BLOB";
		case 5:
			return @"NULL";
		default:
			return @"unkonw";
	}
}

-(NSString *)description{
	int i;
	NSMutableString* desc =[[NSMutableString alloc] initWithCapacity:100];
	for (i=0;i<[self columnCount] ;i++){
		[desc appendFormat:@"%s(%@) ",[self columnName:i],[self typecode2typestring:[self columnType:i]]]; 
	}
	return [desc autorelease] ;
}

-(id)initWithSQL:(CJDataBase*)aDatabase sql:(NSString*)aSQLStr {
    CJLOG_NULLPOINT(aSQLStr);
    CJASSERT([aSQLStr length]>0,"");
    CJLOG_NULLPOINT([super init]);
    const char* p;
    _dataBase =aDatabase ;
    CJLOG_NULLPOINT(_dataBase);
    [_dataBase retain];
    int success =sqlite3_prepare_v2(_dataBase.sqLite3, [aSQLStr UTF8String], -1, &_statement, &p);
    if (success!=SQLITE_OK) {
        if (*p != '\0') {
            CJASSERT(0,"CJSQLTable excuteSQL err with message=%s extendMsg =%s",sqlite3_errmsg(_dataBase.sqLite3),p);
        }
        else {
            CJASSERT(0,"CJSQLTable excuteSQL err with message=%s",sqlite3_errmsg(_dataBase.sqLite3));
        }
    }
	return self ;
}

-(void)dealloc{
	if (_statement!=nil){
		sqlite3_reset(_statement);
		sqlite3_finalize(_statement);
	}
	_statement =nil ;	
	[_dataBase release];
	[super dealloc];
}

-(BOOL)first{
    return (SQLITE_OK == sqlite3_reset(_statement));
}

-(BOOL)nextRow{
	return (sqlite3_step(_statement)== SQLITE_ROW);
}

-(int)columnCount{
	return sqlite3_column_count(_statement);
}

-(int)columnType:(int)colIndex{
	return sqlite3_column_type(_statement,colIndex);
}

-(const char*)columnName:(int)colIndex{
	return sqlite3_column_name(_statement,colIndex);
}

-(int)dataCount{
    int count = 0;
    sqlite3_reset(_statement);
    while ([self nextRow]) {
        ++ count;
    }
    sqlite3_reset(_statement);
    return  count;
}

-(void*)columnBlob:(int)colIndex;{
	return (void*)sqlite3_column_blob(_statement,colIndex);
}

-(int)columnInt:(int)colIndex{
	return sqlite3_column_int(_statement,colIndex);
}

-(char)columnInt8:(int)colIndex{
	return sqlite3_column_bytes(_statement,colIndex);
}

-(short)columnInt16:(int)colIndex{
	return sqlite3_column_bytes16(_statement,colIndex);
}

-(int64_t)columnInt64:(int)colIndex{
	return sqlite3_column_int64(_statement,colIndex);
}

-(double)columnDouble:(int)colIndex{
	return sqlite3_column_double(_statement,colIndex);
}

-(const unsigned char*)columnText:(int)colIndex {
	return sqlite3_column_text(_statement,colIndex);
}

-(NSString*)columnString:(int)colIndex {
	char* res =(char*)[self columnText:colIndex] ;
	return [NSString cj_stringWithCString:res];
}
@end




@interface CJDataBase(PrivateMethod)
    
-(id) init;
-(void)dealloc;
-(BOOL)internalexcuteSQL:(NSString *) aSQL args: (va_list) args;
-(id) valueForParameter: (int) parameterIndex fromArray: (NSArray *) array;
-(int) bindValueForParameter: (int) parameterIndex withValue: (id) value withsqlite3stmt: (sqlite3_stmt*) _sqlite_stmt;
-(NSArray *) arrayWithVaList: (va_list) ap count: (int) count;
@end



@implementation CJDataBase

@synthesize sqLite3=_sqLite3;

+(CJDataBase*)dataBase {
    return [[[CJDataBase alloc] init] autorelease] ;
}

-(id)init{
    CJLOG_NULLPOINT([super init]);
    _sqLite3 = nil;
    return self;
}

-(void)dealloc{
    if (_sqLite3!=nil) {
        sqlite3_close(_sqLite3);
    }
    [super dealloc];
}

-(BOOL)openDataBase:(NSString *)aPath{
    [self closeDataBase];
    return (sqlite3_open([aPath UTF8String], &_sqLite3) == SQLITE_OK);
}

-(void)closeDataBase{
    if (_sqLite3) {
        sqlite3_close(_sqLite3);
    }
    _sqLite3 = nil;
}

-(CJSQLTable*)queryCreate:(NSString*)aSQL{
    CJSQLTable* sqliteTable =nil;
    sqliteTable =[[CJSQLTable alloc] initWithSQL:self sql:aSQL];
	return [sqliteTable autorelease];
}

-(BOOL)isTableExists:(NSString *)aTableName{
    BOOL result=NO;
	NSString* sql =[[NSString alloc] initWithFormat:@"select * from sqlite_master where tbl_name='%@'",aTableName];
	CJSQLTable* sqliteTable= [self queryCreate:sql];
    result =[sqliteTable nextRow];
	[sql release];
	return result ;
}

-(BOOL)excuteSQL:(NSString *)aSQL, ...{
    BOOL ret;
    va_list ap;
    va_start(ap, aSQL);
    ret = [self internalexcuteSQL:aSQL args: ap];
    va_end(ap);
    return ret;
}

-(BOOL)internalexcuteSQL:(NSString *) aSQL args: (va_list) args{
    
    sqlite3_stmt*  statement;
    const char *unused;
	int success =sqlite3_prepare_v2(_sqLite3, [aSQL UTF8String], -1, &statement, &unused) ;
    
    int _parameterCount = sqlite3_bind_parameter_count(statement);
    NSArray* parameters = [self arrayWithVaList:args count:_parameterCount];
   
    int ret;
    
    for (int valueIndex = 1; valueIndex <= _parameterCount; valueIndex++) {
        /* (Note that NSArray indexes from 0, so we subtract one to get the current value) */
            
        id value = [self valueForParameter: valueIndex fromArray: parameters];
        if (value == nil) {
            CJLOGW("value valueForParameter == nil");
        }
        
        /* Bind the parameter */
        int ret = [self bindValueForParameter: valueIndex
                                    withValue: value
                                  withsqlite3stmt:  statement];
        
        /* If the bind fails, throw an exception (programmer error). */
        if (ret != SQLITE_OK) {
            CJLOGW("value bindValueForParameter = %d",ret);
        }
    }
    
    if (success==SQLITE_OK)
	    success = sqlite3_step(statement);
    else{
        CJLOGW("excuteSQL err with message=%s", sqlite3_errmsg(_sqLite3));
	}
    
    if (*unused != '\0') {
        CJLOGW("unused != NULL=%s",unused);
        return false;
    }    
    sqlite3_reset(statement);
	sqlite3_finalize(statement);

    return (success!=SQLITE_ERROR && ret != SQLITE_ERROR);
}


- (id) valueForParameter: (int) parameterIndex fromArray: (NSArray *) array {
    /* Arrays are zero-index, sqlite is 1-indexed, so adjust the index
     * for the array */
    return [array objectAtIndex: parameterIndex - 1];
}

- (int) bindValueForParameter: (int) parameterIndex withValue: (id) value withsqlite3stmt: (sqlite3_stmt*) _sqlite_stmt {
    /* NULL */
    if (value == nil || value == [NSNull null]) {
        return sqlite3_bind_null(_sqlite_stmt, parameterIndex);
    }
    
    /* Data */
    else if ([value isKindOfClass: [NSData class]]) {
        return sqlite3_bind_blob(_sqlite_stmt, parameterIndex, [value bytes], [value length], SQLITE_TRANSIENT);
    }
    
    /* Date */
    else if ([value isKindOfClass: [NSDate class]]) {
        return sqlite3_bind_double(_sqlite_stmt, parameterIndex, [value timeIntervalSince1970]);
    }
    
    /* String */
    else if ([value isKindOfClass: [NSString class]]) {
        return sqlite3_bind_text(_sqlite_stmt, parameterIndex, [value UTF8String], -1, SQLITE_TRANSIENT);
    }
    
    /* Number */
    else if ([value isKindOfClass: [NSNumber class]]) {
        const char *objcType = [value objCType];
        int64_t number = [value longLongValue];
        
        /* Handle floats and doubles */
        if (strcmp(objcType, @encode(float)) == 0 || strcmp(objcType, @encode(double)) == 0) {
            return sqlite3_bind_double(_sqlite_stmt, parameterIndex, [value doubleValue]);
        }
        
        /* If the value can fit into a 32-bit value, use that bind type. */
        else if (number <= INT32_MAX) {
            return sqlite3_bind_int(_sqlite_stmt, parameterIndex, number);
            
            /* Otherwise use the 64-bit bind. */
        } else {
            return sqlite3_bind_int64(_sqlite_stmt, parameterIndex, number);
        }
    }
    
    /* Not a known type */
    CJLOGW("SQLite error binding unknown parameter type");
    /* Unreachable */
    abort();
}


- (NSArray *) arrayWithVaList: (va_list) ap count: (int) count {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity: count];
    /* Iterate over count and create our array */
    for (int i = 0; i < count; i++) {
        id obj;
        
        /* Fetch value -- handle nil */
        obj = va_arg(ap, id);
        if (obj == nil)
            obj = [NSNull null];
        
        [result addObject: obj];
    }
    return result;
}


@end

