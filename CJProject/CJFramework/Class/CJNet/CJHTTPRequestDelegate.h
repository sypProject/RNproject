//
//  CJHTTPRequestDelegate.h
//  CJProject
//
//  Created by shiyi yu on 11-11-8.
//  Copyright (c) 2011年 datuu. All rights reserved.
//

@class CJHTTPRequest;

@protocol CJHTTPRequestDelegate <NSObject>
@optional

// These are the default delegate methods for request status
// You can use different ones by setting didStartSelector / didFinishSelector / didFailSelector
- (void)requestStarted:(CJHTTPRequest *)request;
- (void)request:(CJHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders;
- (void)request:(CJHTTPRequest *)request willRedirectToURL:(NSURL *)newURL;
- (void)requestFinished:(CJHTTPRequest *)request;
- (void)requestFailed:(CJHTTPRequest *)request;
- (void)requestRedirected:(CJHTTPRequest *)request;

// When a delegate implements this method, it is expected to process all incoming data itself
// This means that responseData / responseString / downloadDestinationPath etc are ignored
// You can have the request call a different method by setting didReceiveDataSelector
- (void)request:(CJHTTPRequest *)request didReceiveData:(NSData *)data;

// If a delegate implements one of these, it will be asked to supply credentials when none are available
// The delegate can then either restart the request ([request retryUsingSuppliedCredentials]) once credentials have been set
// or cancel it ([request cancelAuthentication])
- (void)authenticationNeededForRequest:(CJHTTPRequest *)request;
- (void)proxyAuthenticationNeededForRequest:(CJHTTPRequest *)request;

@end
