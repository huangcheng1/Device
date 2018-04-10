//
//  SCCDeviceState.h
//  Pods
//
//  Created by huang cheng on 2017/4/11.
//
//

#import <Foundation/Foundation.h>

@interface SCCDeviceState : NSObject

+ (NSTimeInterval)deviceBootTime;

+ (NSTimeInterval)deviceCPUTime;

+ (int)getScreenBrightness;

@end
