//
//  SCCDeviceMemory.h
//  Pods
//
//  Created by huang cheng on 2017/4/11.
//
//

#import <Foundation/Foundation.h>

@interface SCCDeviceMemory : NSObject

+ (long long)getDeviceTotalMemory;

+ (long long)getDeviceAvailableMemory;

@end
