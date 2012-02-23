//
//  CJTimerTests.h
//  CJFramework
//
//  Created by liu ys on 11-11-10.
//  Copyright (c) 2011年 datou. All rights reserved.
//

//  Application unit tests contain unit test code that must be injected into an application to run correctly.
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <SenTestingKit/SenTestingKit.h>
#import "CJTimer.h"

@interface CJTimerTests : SenTestCase<CJTimerProtocol> {
    CJTimer* _timer ;
    BOOL _isComplete;
}
@property (nonatomic,retain) CJTimer* timer;

-(void)TimerFire:(CJTimer*)timer userInfo:(id)userInfo ;
-(void)TimerFireBySelector:(CJTimer *)timer userInfo:(id)userInfo ;
@end
