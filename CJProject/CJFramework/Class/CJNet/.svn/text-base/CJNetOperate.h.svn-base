//
//  CJNetOperate.h
//  CJProject
//
//  Created by shiyi yu on 11-11-10.
//  Copyright (c) 2011年 datuu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJHTTPRequestDelegate.h"

@class CJHTTPRequest;

@interface CJNetOperate : NSObject<CJHTTPRequestDelegate>{
    CJHTTPRequest* _request;
    NSURL* _url;
    NSMutableData* _responseData;
    NSTimeInterval _timeOutSeconds;
}

@property (retain,setter=setURL:,nonatomic) NSURL* url;
@property (assign) NSTimeInterval timeOutSeconds;

// Convenience constructor
+ (id)requestBaseWithURL:(NSURL *)newURL;
// Should be an HTTP or HTTPS url, may include username and password if appropriate
- (id)initWithURL:(NSURL *)newURL;
- (void)start;
- (void)stop;
@end
