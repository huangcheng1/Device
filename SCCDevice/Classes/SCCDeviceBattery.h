//
//  SCCDeviceBattery.h
//  Pods
//
//  Created by huang cheng on 2017/4/11.
//
//

#import <Foundation/Foundation.h>

/**
 *  电池状态
 *  1.正在充电 0.没有充电
 *  电池电量
 *  int
 */

@interface SCCDeviceBattery : NSObject

+ (int)batteryStatus;

+ (int)batteryLevel;

@end
