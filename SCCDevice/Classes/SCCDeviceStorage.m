//
//  SCCDeviceStorage.m
//  Pods
//
//  Created by huang cheng on 2017/4/11.
//
//

#import "SCCDeviceStorage.h"
#include <sys/param.h>
#include <sys/mount.h>

@implementation SCCDeviceStorage

+ (long long)getTotalDiskSize{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return freeSpace;
}

+ (long long)getAvailableDiskSize{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    return freeSpace;
}

@end
