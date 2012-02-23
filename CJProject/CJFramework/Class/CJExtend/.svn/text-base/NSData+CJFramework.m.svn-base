//
//  NSData+CJFramework.m
//  CJFramework
//
//  Created by liu ys on 11-11-14.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import "NSData+CJFramework.h"
#import "zlib.h"
#import "CJLog.h"

@implementation NSData (CJFramework)
-(NSData*) cj_compressFromZlib {
    NSUInteger len = [self length];
    Bytef* byteData = (Bytef*)[self bytes];
    CJLOG_RETNULL(byteData != NULL, "self bytes return NULL = %u",len);
    uLongf destLen = (len+12)*1.01+1;
    NSMutableData* dest = [[[NSMutableData alloc]initWithLength:destLen]autorelease];
    CJLOG_RETNULL(dest != NULL, "init error destLen = %d",destLen);
    int error = compress((Bytef*)[dest bytes], &destLen, byteData, len);
    CJLOG_RETNULL(dest != NULL, "compress error error = %d",error);
    [dest setLength:destLen];
    return dest; 
}
-(NSData*) cj_decompressFromZlib {
#define OUTSIZE 128
    z_stream inflateStream ;
    inflateStream.next_in = (Bytef*)[self bytes];
    inflateStream.avail_in= [self length];
    inflateStream.zalloc  = 0;
    inflateStream.zfree   = 0;
    inflateStream.opaque  = 0;    
    
    int ret = inflateInit(&inflateStream);
    CJLOG_RETNULL(ret == Z_OK, "inflateInit error = %d",ret);
    
    NSMutableData* targetData = [[[NSMutableData alloc] initWithLength:OUTSIZE]autorelease];
    CJLOG_RETNULL(targetData != NULL, "init error OUTSIZE = %d",OUTSIZE);
    int outlength = 0;
    while (1==1) {
        inflateStream.next_out  =[targetData mutableBytes]+outlength;
        inflateStream.avail_out = OUTSIZE;
        int err =inflate(&inflateStream,Z_NO_FLUSH);
        if ( (err == Z_STREAM_END) || (inflateStream.avail_in <= 0) ) {
            [targetData setLength:inflateStream.total_out];
            CJLOGI("data Lengteh = %d",[targetData length]);
            break ;
        }
        else if(err != Z_OK){
            CJLOGE("inflate error = %d", err);
            return nil;
        }
        outlength += OUTSIZE ;
        [targetData increaseLengthBy:OUTSIZE];
    }
    ret = inflateEnd(&inflateStream);
    CJLOG_RETNULL(ret == Z_OK, "inflateEnd error = %d",ret);
    return targetData;
}
@end

