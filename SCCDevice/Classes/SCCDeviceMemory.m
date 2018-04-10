//
//  SCCDeviceMemory.m
//  Pods
//
//  Created by huang cheng on 2017/4/11.
//
//

#import "SCCDeviceMemory.h"
#include <mach/mach.h>

@implementation SCCDeviceMemory

+ (long long)getDeviceTotalMemory{
    return [NSProcessInfo processInfo].physicalMemory;
}

+ (long long)getDeviceAvailableMemory{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}
@end
