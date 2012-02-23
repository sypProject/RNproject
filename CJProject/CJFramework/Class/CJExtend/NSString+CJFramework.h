//
//  NSString+CJFramework.h
//  CJFramework
//
//  Created by liu ys on 11-11-14.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CJFramework)
+(NSString*) cj_stringWithCString:(const char *)bytes;
+(NSString*) cj_stringWithCString:(const char *)bytes length:(NSUInteger)length;
-(NSString*) cj_stringFromMD5;
@end
