//
//  SCCDeviceStorage.h
//  Pods
//
//  Created by huang cheng on 2017/4/11.
//
//

#import <Foundation/Foundation.h>

@interface SCCDeviceStorage : NSObject

+ (long long)getTotalDiskSize;

+ (long long)getAvailableDiskSize;

@end
