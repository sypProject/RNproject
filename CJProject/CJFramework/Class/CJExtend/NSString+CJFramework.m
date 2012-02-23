//
//  NSString+CJFramework.m
//  CJFramework
//
//  Created by liu ys on 11-11-14.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import "NSString+CJFramework.h"
#include <CommonCrypto/CommonDigest.h>

@implementation NSString (CJFramework)
+(NSString*) cj_stringWithCString:(const char *)bytes {
    return [NSString stringWithCString:bytes encoding:NSUTF8StringEncoding];
}
+(NSString*) cj_stringWithCString:(const char *)bytes length:(NSUInteger)length {
    NSString* result = [[NSString alloc] initWithBytes:bytes length:length encoding:NSStringEncodingConversionAllowLossy];
    return [result autorelease];
}
-(NSString*) cj_stringFromMD5 {
    if([self length] == 0) {
        return nil;
    }
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++) {
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    return [outputString autorelease];
}
@end
