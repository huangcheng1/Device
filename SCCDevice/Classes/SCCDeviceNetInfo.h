//
//  SCCDeviceNetInfo.h
//  Pods
//
//  Created by huang cheng on 2017/4/12.
//
//

#import <Foundation/Foundation.h>

@interface SCCDeviceNetInfo : NSObject

/**
 *  wifi ssid
 *
 *  @return string
 */
+ (NSString*)getDeviceWIFISSID;


/**
 *  wifi bssid
 *
 *  @return string
 */
+ (NSString*)getDeviceWIFIBSSID;

/**
 *  wifi ip
 *
 *  @return string
 */
+ (NSString*)getDeviceWIFIIP;

/**
 *  wifi netmask 子网掩码
 *
 *  @return string
 */
+ (NSString*)getDeviceWIFINetMask;

/**
 *  移动网络ip
 *
 *  @return string
 */
+ (NSString *)getDevicePDPIP;

/**
 *  移动网络子网掩码
 *
 *  @return string
 */
+ (NSString *)getDevicePDPNetMask;

/**
 *  vpn ip
 *
 *  @return string
 */
+ (NSString *)getDeviceUTUNIP;

/**
 *  vpn 子网掩码
 *
 *  @return string
 */
+ (NSString *)getDevicePDPUTUNMask;

/**
 *  运营商名字
 *
 *  @return string 中国移动
 */
+ (NSString*)getCellularProviderName;

/**
 *  运营商国家编码
 *
 *  @return string
 */
+ (NSString*)getCellularProviderMCC;

/**
 *  运营商网络编码
 *
 *  @return string
 */
+ (NSString*)getCellularProviderMNC;

@end
