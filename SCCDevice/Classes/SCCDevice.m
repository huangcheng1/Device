//
//  SCCDevice.m
//  Pods
//
//  Created by huang cheng on 2017/4/7.
//
//

#import "SCCDevice.h"
#import <UIKit/UIKit.h>
#import "SCCDeviceNetInfo.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/utsname.h>
#import "SCCDeviceBattery.h"

#import "UIDevice+SCCDevice.h"

@interface SCCDevice ()

@property (atomic, strong) UIDevice *device;

@property (atomic, copy, readwrite) NSString *uuid;
@property (atomic, copy, readwrite) NSString *userDeviceName;
@property (atomic, copy, readwrite) NSString *systemModel;
@property (atomic, copy, readwrite) NSString *iosModel;
@property (atomic, copy, readwrite) NSString *systemName;
@property (atomic, copy, readwrite) NSString *systemVersion;
@property (atomic, copy, readwrite) NSString *bundleVersion;
@property (atomic, copy, readwrite) NSString *buildVersion;
@property (atomic, copy, readwrite) NSString *bundleIdentifier;
@property (atomic, copy, readwrite) NSString *macAddr;
@property (atomic, copy, readwrite) NSString *ostype;
@property (atomic, copy, readwrite) NSString *net;

@end

@implementation SCCDevice

+ (instancetype)shared{
    static dispatch_once_t onceToken;
    static SCCDevice *shareObj;
    dispatch_once(&onceToken, ^{
        shareObj = [[SCCDevice alloc]init];
    });
    return shareObj;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _device = [UIDevice currentDevice];
        _uuid = [_device UUID];
        _userDeviceName = _device.name;
        _systemVersion = [_device.systemVersion stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _systemName = [_device.systemName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _systemModel = [_device.model stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _iosModel = [SCCDevice currentModelName];
        _bundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        _buildVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        _bundleIdentifier = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
        _ostype = [_device ostype];
        _macAddr = [_device macAddress];
    }
    return self;
}
+ (NSString *)getUUID{
    return [SCCDevice shared].uuid;
}

+ (NSString *)getUserDeviceName{
    return [SCCDevice shared].userDeviceName;
}

+ (NSString *)getModelName{
    return [SCCDevice shared].systemModel;
}

+ (NSString *)getSystemName{
    return [SCCDevice shared].systemName;
}

+ (NSString *)getSystemVersion{
    return [SCCDevice shared].systemVersion;
}

+ (NSString *)getBundleVersion{
    return [SCCDevice shared].bundleVersion;
}
+ (NSString *)getBuildVersion {
    return [SCCDevice shared].buildVersion;
}
+ (NSString *)getBundleIdentifier {
    return [SCCDevice shared].bundleIdentifier;
}

+ (NSString *)getiOSModel{
    return [SCCDevice shared].iosModel;
}

+ (NSString *)getScreenResolution{
    return [NSString stringWithFormat:@"%@*%@",@([UIScreen mainScreen].bounds.size.width * [UIScreen mainScreen].scale),@([UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale)];
}

+ (NSString *)getMacAddr {
    return [SCCDevice shared].macAddr;
}

+ (NSString *)getNetworkOperator {
    CTTelephonyNetworkInfo*netInfo = [[CTTelephonyNetworkInfo alloc]init];
    CTCarrier*carrier = [netInfo subscriberCellularProvider];
    NSString*cellularProviderName = [carrier carrierName];
    return cellularProviderName;
}
+ (NSString *)getNetState{
    NSString *result;
    if ([SCCDeviceNetInfo getDeviceWIFIIP] != nil) {
        result = @"WIFI";
    } else if ([SCCDeviceNetInfo getDevicePDPIP] != nil) {
        result = @"WWAN";
    } else{
        result = @"unknown";
    }
    return result;
}

+ (NSNumber *)getScreenScale{
    return @((int)[UIScreen mainScreen].scale);
}



+ (NSString*)currentModelName {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone 系列
    if ([deviceModel isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceModel isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceModel isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    
    //iPod 系列
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    //iPad 系列
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceModel isEqualToString:@"iPad4,4"]
        ||[deviceModel isEqualToString:@"iPad4,5"]
        ||[deviceModel isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    if ([deviceModel isEqualToString:@"iPad4,7"]
        ||[deviceModel isEqualToString:@"iPad4,8"]
        ||[deviceModel isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    return deviceModel;
}

@end

@implementation SCCDevice (SCCDeviceImp)

+ (UIDevice *)uidevice{
    return [UIDevice currentDevice];
}



@end
