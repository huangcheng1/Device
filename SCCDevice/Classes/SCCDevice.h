//
//  SCCDevice.h
//  Pods
//
//  Created by huang cheng on 2017/4/7.
//
//

#import <Foundation/Foundation.h>

@interface SCCDevice : NSObject

+ (NSString *)getUUID;

+ (NSString *)getUserDeviceName;

+ (NSString *)getModelName;

+ (NSString *)getiOSModel;

+ (NSString *)getSystemName;

+ (NSString *)getSystemVersion;

+ (NSString *)getBundleVersion;

+ (NSString *)getBuildVersion;

+ (NSString *)getBundleIdentifier;

+ (NSString *)getMacAddr;

+ (NSString *)getNetState;

+ (NSString *)getScreenResolution;

+ (NSNumber *)getScreenScale;

+ (NSString *)getNetworkOperator;


@end
