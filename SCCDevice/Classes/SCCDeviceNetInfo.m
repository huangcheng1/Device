//
//  SCCDeviceNetInfo.m
//  Pods
//
//  Created by huang cheng on 2017/4/12.
//
//

#import "SCCDeviceNetInfo.h"
#include <ifaddrs.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#import <ifaddrs.h>
#import <arpa/inet.h>

/*
 *
 *   以下是获取ip和广播地址的代码，不同环境只是接口不一样，比如en0是wifi ,utun1 utun0是vpn , lo0是本机 pdp_ip0是4g
 *
 *获取ip
 *
 *
 NSString *address = nil;
 struct ifaddrs *interfaces = NULL;
 struct ifaddrs *temp_addr = NULL;
 int success = 0;
 success = getifaddrs(&interfaces);
 if (success == 0) { // 0 表示获取成功
 temp_addr = interfaces;
 while (temp_addr != NULL) {
 if( temp_addr->ifa_addr->sa_family == AF_INET) {
 // Check if interface is en0 which is the wifi connection on the iPhone
 //routerIP----192.168.1.255 广播地址
 NSLog(@"broadcast address--%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)]);
 //--192.168.1.106 本机地址
 NSLog(@"local device ip--%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]);
 //--255.255.255.0 子网掩码地址
 NSLog(@"netmask--%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)]);
 //--en0 端口地址
 NSLog(@"interface--%@",[NSString stringWithUTF8String:temp_addr->ifa_name]);
 
 if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
 // Get NSString from C String
 address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
 }
 }
 
 temp_addr = temp_addr->ifa_next;
 }
 }
 
 freeifaddrs(interfaces);
 return address;


 * 获取netmask
 
 
 NSString *address = nil;
 struct ifaddrs *interfaces = NULL;
 struct ifaddrs *temp_addr = NULL;
 int success = 0;
 
 success = getifaddrs(&interfaces);
 
 if (success == 0) { // 0 表示获取成功
 
 temp_addr = interfaces;
 while (temp_addr != NULL) {
 if( temp_addr->ifa_addr->sa_family == AF_INET) {
 // Check if interface is en0 which is the wifi connection on the iPhone
 if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"utun1"]) {
 // Get NSString from C String
 address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)];
 }
 }
 
 temp_addr = temp_addr->ifa_next;
 }
 }
 
 freeifaddrs(interfaces);
 return address;
 
 */

@implementation SCCDeviceNetInfo


+ (NSString*)getDeviceWIFISSID{
    
    NSString *wifiName = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            NSLog(@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}


+ (NSString*)getDeviceWIFIBSSID{
    
    NSString *bssid = nil;
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            NSLog(@"network info -> %@", networkInfo);
            bssid = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeyBSSID];
            
            CFRelease(dictRef);
        }
    }
    CFRelease(wifiInterfaces);
    return bssid;
}

+ (NSString*)getDeviceWIFIIP{
    return [[self getIPAddresses] objectForKey:@"en0/ipv4"];
}

+ (NSString*)getDeviceWIFINetMask{
    return @"";
}

+ (NSString *)getDevicePDPIP{
    return [[self getIPAddresses] objectForKey:@"pdp_ip0/ipv4"];
}

+ (NSString *)getDevicePDPNetMask{
    return @"";
}

+ (NSString *)getDeviceUTUNIP{
    return @"";
}

+ (NSString *)getDevicePDPUTUNMask{
    return @"";
}

+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *netmask = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)interface->ifa_netmask)->sin_addr)];
                NSString *netmaskKey = [NSString stringWithFormat:@"%@/netmask", name];
                addresses[netmaskKey] = netmask;
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = @"ipv4";
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = @"ipv6";
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

+ (NSString*)getCellularProviderName
{
    CTTelephonyNetworkInfo*netInfo = [[CTTelephonyNetworkInfo alloc]init];
    CTCarrier*carrier = [netInfo subscriberCellularProvider];
    NSString*cellularProviderName = [carrier carrierName];
    return cellularProviderName;
}
+ (NSString*)getCellularProviderMCC{
    CTTelephonyNetworkInfo*netInfo = [[CTTelephonyNetworkInfo alloc]init];
    CTCarrier*carrier = [netInfo subscriberCellularProvider];
    NSString *mcc = [carrier mobileCountryCode];
    return mcc;
}

+ (NSString*)getCellularProviderMNC{
    CTTelephonyNetworkInfo*netInfo = [[CTTelephonyNetworkInfo alloc]init];
    CTCarrier*carrier = [netInfo subscriberCellularProvider];
    NSString *mnc = [carrier mobileNetworkCode];
    return mnc;
}
@end
