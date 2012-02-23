//
//  CJDataBase.h
//  CJFramework
//
//  Created by wang on 11-11-9.
//  Copyright (c) 2011年 datou. All rights reserved.
//
/* example
1.  create datebase
    
    CJDataBase* database = [CJDataBase defaultCreateDataBase]; //autorelease
    NSString* document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES)objectAtIndex:0];
    NSString* dbpath = [document stringByAppendingPathComponent:@"MyTest.db"];
    [database openDataBase:dbpath];
2.  create table
 
    NSString* createSQL =  @"CREATE TABLE MyTest (a int,b VARCHAR(20), c BOOL)";
    bool sucess =[database excuteSQL:createSQL]; 
3.  insert table
 
    NSString* insertSQL1 = [NSString stringWithFormat:@"INSERT INTO MyTest (a,b) VALUES (?,?)", [NSNumber numberWithInt: 43],@"内容gggggggdfgf"];
    sucess = [database excuteSQL:insertSQL1];
4.  where
 
    NSString* where = @"SELECT * FROM MyTest WHERE a = 42";
    CJSQLTable* wheretable = [database queryCreate:where];
5.  get datecount
 
    int tocount  = [wheretable dataCount];
6.  find all data
 
    while ([totaltable nextRow]) {
        int a =   [totaltable columnInt:0];
        NSString* b = [totaltable columnString:1];
    }
7.  delete 
    NSString* delete = [NSString stringWithFormat:@"DELETE FROM MyTest WHERE a = ?",[NSNumber numberWithInt: 43]];
    sucess = [database excuteSQL:delete];
 
8.  update
    自己实验
 
9.  NSString* where = @"SELECT * FROM MyTest WHERE a = 43";
    CJSQLTable* wheretable = [database queryCreate:where];
*/
#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class CJSQLTable;

@interface CJDataBase : NSObject{
    sqlite3*    _sqLite3;
}
@property (nonatomic,assign,readonly) sqlite3* sqLite3;

//autorealse
+(CJDataBase*)dataBase;

-(BOOL) openDataBase:(NSString*) aPath;
-(void) closeDataBase;

-(BOOL) isTableExists:(NSString*) aTableName;
-(BOOL) excuteSQL:(NSString*)aSQL,... NS_FORMAT_FUNCTION(1,2);
//returnobject need yourself release
-(CJSQLTable*)queryCreate:(NSString*)aSQL;
@end


@interface CJSQLTable : NSObject {
	CJDataBase*     _dataBase;
	sqlite3_stmt*   _statement;
}
//cursor point to table header
-(BOOL)first;
-(BOOL)nextRow;
-(int)columnCount;
-(int)columnType:(int)colIndex;
-(const char*)columnName:(int)colIndex;
//get row count 
-(int)dataCount;

-(void*)columnBlob:(int)colIndex;
-(int)columnInt:(int)colIndex;
-(char)columnInt8:(int)colIndex;
-(short)columnInt16:(int)colIndex;
-(int64_t)columnInt64:(int)colIndex;
-(double)columnDouble:(int)colIndex;
-(const unsigned char*)columnText:(int)colIndex;
-(NSString*)columnString:(int)colIndex;
@end



