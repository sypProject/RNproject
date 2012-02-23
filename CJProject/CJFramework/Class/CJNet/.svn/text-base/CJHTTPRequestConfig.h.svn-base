//
//  CJHTTPRequestConfig.h
//  CJProject
//
//  Created by shiyi yu on 11-11-8.
//  Copyright (c) 2011年 datuu. All rights reserved.
//

// ======
// Debug output configuration options
// ======

// If defined will use the specified function for debug logging
// Otherwise use NSLog
#ifndef CJ_DEBUG_LOG
    #define CJ_DEBUG_LOG NSLog
#endif

// When set to 1 CJHTTPRequests will print information about what a request is doing
//打印总体请求的生命周期信息 -- 开始，结束上传，结束下载 等等
#ifndef DEBUG_REQUEST_STATUS
    #define DEBUG_REQUEST_STATUS 1
#endif

// When set to 1, CJFormDataRequests will print information about the request body to the console
//印ASIFormDataRequest将发送的请求body的概要。仅在使用ASIFormDataRequest有用
#ifndef DEBUG_FORM_DATA_REQUEST
    #define DEBUG_FORM_DATA_REQUEST 1
#endif

// When set to 1, CJHTTPRequests will print information about bandwidth throttling to the console
//打印（粗略的）有多少带宽被使用的信息，如果请求被限流，还包括这如何发生的信息
#ifndef DEBUG_THROTTLING
    #define DEBUG_THROTTLING 1
#endif

// When set to 1, CJHTTPRequests will print information about persistent connections to the console
//打印请求如何重用持续连接的信息，如果你看到输出下面的信息：
#ifndef DEBUG_PERSISTENT_CONNECTIONS
    #define DEBUG_PERSISTENT_CONNECTIONS 1
#endif

// When set to 1, CJHTTPRequests will print information about HTTP authentication (Basic, Digest or NTLM) to the console
//从v1.8.1后添加，这会打印出关于请求如何处理http验证(基本/摘要/ntml)的信息
#ifndef DEBUG_HTTP_AUTHENTICATION
    #define DEBUG_HTTP_AUTHENTICATION 1
#endif