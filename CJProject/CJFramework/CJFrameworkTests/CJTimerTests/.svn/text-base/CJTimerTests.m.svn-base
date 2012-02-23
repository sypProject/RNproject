//
//  CJTimerTests.m
//  CJFramework
//
//  Created by liu ys on 11-11-10.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import "CJTimerTests.h"

#import <UIKit/UIKit.h>
#import "CJSingleton.h"

@implementation CJTimerTests
@synthesize timer = _timer;

-(void)TimerFire:(CJTimer*)timer userInfo:(id)userInfo  {
    NSLog(@"TimerFire Call");
    self->_isComplete = YES;
}

-(void)TimerFireBySelector:(CJTimer *)timer userInfo:(id)userInfo {
    NSLog(@"TimerFireBySelector Call");
}

- (void)setUp {
    [super setUp];
    self.timer = [CJTimer timerWithTimeInterval:10 protocol:self userInfo:nil repeats:YES];
}

- (void)tearDown {
    [self.timer release];
    [super tearDown];
}


// All code under test is in the iOS Application
- (void)testTimeProtocol
{
  //  CJSingleton* singleton = [CJSingleton defaultSingleton];
    
   // [singleton releaseSingleton];
   /* 
    
    NSLog(@"retainCount =%d",[self retainCount]);
    self.timer.userInfo = self;
    NSLog(@"retainCount =%d",[self retainCount]);

    self.timer.repeats = YES ;
    NSLog(@"isrepeat =%d",self.timer.repeats);
    self.timer.timeInterval =0.4;
    [self.timer start] ;
    while (self->_isComplete==NO) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    }
    STAssertFalse(!self->_isComplete,@"Time failed");*/
}

@end
