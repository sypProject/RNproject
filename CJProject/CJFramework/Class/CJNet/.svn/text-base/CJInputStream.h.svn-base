//
//  CJInputStream.h
//  CJProject
//
//  Created by shiyi yu on 11-11-8.
//  Copyright (c) 2011年 datuu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CJHTTPRequest;

// This is a wrapper for NSInputStream that pretends to be an NSInputStream itself
// Subclassing NSInputStream seems to be tricky, and may involve overriding undocumented methods, so we'll cheat instead.
// It is used by CJHTTPRequest whenever we have a request body, and handles measuring and throttling the bandwidth used for uploading

@interface CJInputStream : NSObject {
	NSInputStream *stream;
	CJHTTPRequest *request;
}
+ (id)inputStreamWithFileAtPath:(NSString *)path request:(CJHTTPRequest *)request;
+ (id)inputStreamWithData:(NSData *)data request:(CJHTTPRequest *)request;

@property (retain, nonatomic) NSInputStream *stream;
@property (assign, nonatomic) CJHTTPRequest *request;
@end

