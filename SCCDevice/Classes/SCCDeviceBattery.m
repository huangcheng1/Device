//
//  SCCDeviceBattery.m
//  Pods
//
//  Created by huang cheng on 2017/4/11.
//
//

#import "SCCDeviceBattery.h"

@implementation SCCDeviceBattery

+ (int)batteryStatus{
    UIDevice *device = [UIDevice currentDevice];
    if (device.batteryState == UIDeviceBatteryStateCharging){
        return 1;
    } else {
        return 2;
    }
}

+ (int)batteryLevel{
    
    UIDevice *device = [UIDevice currentDevice];
    if (device.batteryLevel == -1.0){
        return 100;
    } else{
        return (int)(device.batteryLevel * 100);
    }
}

@end
