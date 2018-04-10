//
//  SCCDeviceState.m
//  Pods
//
//  Created by huang cheng on 2017/4/11.
//
//

#import "SCCDeviceState.h"
#include <sys/sysctl.h>

static int64_t us_since_boot() {
    struct timeval boottime;
    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
    size_t size = sizeof(boottime);
    int rc = sysctl(mib, 2, &boottime, &size, NULL, 0);
    if (rc != 0) {
        return 0;
    }
    return boottime.tv_sec * 1000000 + boottime.tv_usec;
}

@implementation SCCDeviceState

+ (int)getScreenBrightness{
    return (int)([UIScreen mainScreen].brightness * 100);
}

+ (NSTimeInterval)deviceBootTime{
    /*
    NSProcessInfo *processInfo = [NSProcessInfo processInfo];
    return processInfo.systemUptime;
     */
    
    return [self us_uptime]/1000000;
}

+ (NSTimeInterval)deviceCPUTime{
    return 0;
}

+ (int64_t)us_uptime
{
    int64_t before_now;
    int64_t after_now;
    struct timeval now;
    
    after_now = us_since_boot();
    do {
        before_now = after_now;
        gettimeofday(&now, NULL);
        after_now = us_since_boot();
    } while (after_now != before_now);
    
    return now.tv_sec * 1000000 + now.tv_usec - before_now;
}

+ (time_t)uptime
{
    struct timeval boottime;
    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
    size_t size = sizeof(boottime);
    time_t now;
    time_t uptime = -1;
    (void)time(&now);
    if (sysctl(mib, 2, &boottime, &size, NULL, 0) != -1 && boottime.tv_sec != 0) {
        uptime = now - boottime.tv_sec;
    }
    return uptime;
}

@end
