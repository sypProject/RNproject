//
//  NSFile_CJframeworkTest.m
//  CJFramework
//
//  Created by ma hurrison on 11-11-21.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import "NSFile_CJframeworkTest.h"

@implementation NSFile_CJframeworkTest

// All code under test must be linked into the Unit Test bundle
- (void)testMath
{
    CJFileHandle * File=Nil;
    NSString *path=@"/Users/hurrison/Library/Application Support/iPhone Simulator/5.0/Applications/566750A2-4A34-4A8E-83E4-B1E0B2C1DC76/Documents/123.txt";
    
    if ([[CJFileManager defaultManager] fileExistsAtPath:path] == NO){
        File = [CJFileHandle fileHandleCreateFile:path mode:CJFileReadWriteMode];
    }
    else{
        File = [CJFileHandle fileHandleOpenFile:path mode:CJFileReadWriteMode];
    }
    const char *str="Hi there ,this is an example";
    NSData *data=[NSData dataWithBytes:str length:strlen(str)+1];
    NSLog(@"%d byte str is'%s'",[data length],[data bytes]);
    
    [File writeData:data];
    NSUInteger filesize=[File fileSize];
    NSLog(@"filesize is= %d,offsetInFile=%llu",filesize,[File offsetInFile]);
    
    [File seekToFileOffset:0];
    NSData *outdata =[File readDataOfLength:filesize];
    NSString *outstr=[[NSString alloc]initWithData:outdata encoding:NSUTF8StringEncoding];
    NSLog(@"outdata is= %@",outstr);
    [outstr release];
    
    [File seekToFileOffset:10];
    NSLog(@"offsetInFile=%llu",[File offsetInFile]);
    
    [File truncateFileAtOffset:10];
    NSLog(@"filesize is= %d",[File fileSize]);
    [File closeFile];
}

@end
