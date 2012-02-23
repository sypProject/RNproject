//
//  CJNetOperate.m
//  CJProject
//
//  Created by shiyi yu on 11-11-10.
//  Copyright (c) 2011年 datuu. All rights reserved.
//
#import "CJHTTPRequest.h"
#import "CJNetOperate.h"

#define TIMEOUT 30.0f

@implementation CJNetOperate

@synthesize url = _url;
@synthesize timeOutSeconds = _timeOutSeconds;

- (void)setURL:(NSURL *)newURL
{
	if ([newURL isEqual:[self url]]) {
		return;
	}
	[_url release];
    _url = [newURL retain];
}

+ (id)requestBaseWithURL:(NSURL *)newURL{
    return [[[self alloc] initWithURL:newURL] autorelease];
}

-(id)initWithURL:(NSURL*)newURL{
	self =[self init];
	if (self!=nil) {
        [self setURL:newURL];
        self.timeOutSeconds = TIMEOUT;
    }
	return self ;
}

-(void)dealloc{
    [_url release];
    [self stop];
    [super dealloc];
}

- (void)start {
    [self stop];
	_responseData =[[NSMutableData alloc] initWithCapacity:2048];
    
    _request =[CJHTTPRequest requestWithURL:_url];
	_request.timeOutSeconds=_timeOutSeconds;
    _request.delegate = self;
    //[_request setShouldWaitToInflateCompressedResponses:NO];
    //[_request setDefaultResponseEncoding:NSUTF8StringEncoding];
	//DTProtocolReqBase* protocolReq = [self createRequest];
	//DT_ASSERT(protocolReq!=nil);
	//[self getProtocolData:protocolReq];
	//NSData* postdata =[protocolReq XMLData];
	//DT_ASSERT(postdata!=nil);
	//NSData* encodeData =eastDataEncode(postdata);
	//TRACED(encodeData);
	//[httpSocket setHeaderFieldValue:KDTHTTPHeader_UserAgent value:ClientInfo.userAgent];
	//[httpSocket setHeaderFieldValue:KDTHTTPHeader_Accept value:KDTHTTPValue_Accept];
	//[httpSocket setHeaderFieldValue:KDTHTTPHeader_ContentLength value:[NSString stringWithFormat:@"%d",[encodeData length]]];
	//[httpSocket setHeaderFieldValue:KDTHTTPHeader_ContentType value:KDTHTTPValue_ContentType];
	//[httpSocket setHeaderFieldValue:KDTHTTPHeader_Connection value:KDTHTTPValue_Connection];
	//[httpSocket internetPost:encodeData];
	//DTRelease(protocolReq);
	//[protocol netStart:self];
    [_request addRequestHeader:@"User-Agent" value:@"ASIHTTPRequest"];
    //[request.postBody setData:encodeData];
    [_request startAsynchronous];
}

- (void)stop {
    [_request clearDelegatesAndCancel];
    [_request release];
}

- (void)request:(CJHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders{
    NSLog(@"%@",request.responseStatusMessage);
    NSLog(@"%d",request.responseStatusCode);
    NSLog(@"%@",[responseHeaders description]);
}
- (void)request:(CJHTTPRequest *)request willRedirectToURL:(NSURL *)newURL{
    
}

- (void)requestFinished:(CJHTTPRequest *)request{
    NSLog(@"%@",request.responseString);
}
- (void)requestFailed:(CJHTTPRequest *)request{
    NSError* err = request.error;
    NSLog(@"%d",[err code]);
}

- (void)requestRedirected:(CJHTTPRequest *)request{
    
}
/*
- (void)request:(CJHTTPRequest *)request didReceiveData:(NSData *)data{
   // NSLog(@"%@",[data description]);
    NSString*datastring =  [[[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:[_request responseEncoding]] autorelease];
     NSLog(@"%@",datastring);
    [_responseData appendData:data];
}
 */
@end
