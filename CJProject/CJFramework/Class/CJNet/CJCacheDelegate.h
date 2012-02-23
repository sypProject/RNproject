//
//  CJCacheDelegate.h
//  CJProject
//
//  Created by shiyi yu on 11-11-8.
//  Copyright (c) 2011年 datuu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CJHTTPRequest;

// Cache policies control the behaviour of a cache and how requests use the cache
// When setting a cache policy, you can use a combination of these values as a bitmask
// For example: [request setCachePolicy:CJAskServerIfModifiedCachePolicy|CJFallbackToCacheIfLoadFailsCachePolicy|CJDoNotWriteToCacheCachePolicy];
// Note that some of the behaviours below are mutally exclusive - you cannot combine CJAskServerIfModifiedWhenStaleCachePolicy and CJAskServerIfModifiedCachePolicy, for example.
typedef enum _CJCachePolicy {
    
	// The default cache policy. When you set a request to use this, it will use the cache's defaultCachePolicy
	// CJDownloadCache's default cache policy is 'CJAskServerIfModifiedWhenStaleCachePolicy'
	CJUseDefaultCachePolicy = 0,
    
	// Tell the request not to read from the cache
	CJDoNotReadFromCacheCachePolicy = 1,
    
	// The the request not to write to the cache
	CJDoNotWriteToCacheCachePolicy = 2,
    
	// Ask the server if there is an updated version of this resource (using a conditional GET) ONLY when the cached data is stale
	CJAskServerIfModifiedWhenStaleCachePolicy = 4,
    
	// Always ask the server if there is an updated version of this resource (using a conditional GET)
	CJAskServerIfModifiedCachePolicy = 8,
    
	// If cached data exists, use it even if it is stale. This means requests will not talk to the server unless the resource they are requesting is not in the cache
	CJOnlyLoadIfNotCachedCachePolicy = 16,
    
	// If cached data exists, use it even if it is stale. If cached data does not exist, stop (will not set an error on the request)
	CJDontLoadCachePolicy = 32,
    
	// Specifies that cached data may be used if the request fails. If cached data is used, the request will succeed without error. Usually used in combination with other options above.
	CJFallbackToCacheIfLoadFailsCachePolicy = 64
} CJCachePolicy;

// Cache storage policies control whether cached data persists between application launches (CJCachePermanentlyCacheStoragePolicy) or not (CJCacheForSessionDurationCacheStoragePolicy)
// Calling [CJHTTPRequest clearSession] will remove any data stored using CJCacheForSessionDurationCacheStoragePolicy
typedef enum _CJCacheStoragePolicy {
	CJCacheForSessionDurationCacheStoragePolicy = 0,
	CJCachePermanentlyCacheStoragePolicy = 1
} CJCacheStoragePolicy;

@protocol CJCacheDelegate <NSObject>

@required

// Should return the cache policy that will be used when requests have their cache policy set to CJUseDefaultCachePolicy
- (CJCachePolicy)defaultCachePolicy;

// Returns the date a cached response should expire on. Pass a non-zero max age to specify a custom date.
- (NSDate *)expiryDateForRequest:(CJHTTPRequest *)request maxAge:(NSTimeInterval)maxAge;

// Updates cached response headers with a new expiry date. Pass a non-zero max age to specify a custom date.
- (void)updateExpiryForRequest:(CJHTTPRequest *)request maxAge:(NSTimeInterval)maxAge;

// Looks at the request's cache policy and any cached headers to determine if the cache data is still valid
- (BOOL)canUseCachedDataForRequest:(CJHTTPRequest *)request;

// Removes cached data for a particular request
- (void)removeCachedDataForRequest:(CJHTTPRequest *)request;

// Should return YES if the cache considers its cached response current for the request
// Should return NO is the data is not cached, or (for example) if the cached headers state the request should have expired
- (BOOL)isCachedDataCurrentForRequest:(CJHTTPRequest *)request;

// Should store the response for the passed request in the cache
// When a non-zero maxAge is passed, it should be used as the expiry time for the cached response
- (void)storeResponseForRequest:(CJHTTPRequest *)request maxAge:(NSTimeInterval)maxAge;

// Removes cached data for a particular url
- (void)removeCachedDataForURL:(NSURL *)url;

// Should return an NSDictionary of cached headers for the passed URL, if it is stored in the cache
- (NSDictionary *)cachedResponseHeadersForURL:(NSURL *)url;

// Should return the cached body of a response for the passed URL, if it is stored in the cache
- (NSData *)cachedResponseDataForURL:(NSURL *)url;

// Returns a path to the cached response data, if it exists
- (NSString *)pathToCachedResponseDataForURL:(NSURL *)url;

// Returns a path to the cached response headers, if they url
- (NSString *)pathToCachedResponseHeadersForURL:(NSURL *)url;

// Returns the location to use to store cached response headers for a particular request
- (NSString *)pathToStoreCachedResponseHeadersForRequest:(CJHTTPRequest *)request;

// Returns the location to use to store a cached response body for a particular request
- (NSString *)pathToStoreCachedResponseDataForRequest:(CJHTTPRequest *)request;

// Clear cached data stored for the passed storage policy
- (void)clearCachedResponsesForStoragePolicy:(CJCacheStoragePolicy)cachePolicy;

@end