//
//  UIDevice+SCCDevice.h
//  Pods
//
//  Created by huang cheng on 2017/4/7.
//
//

#import <UIKit/UIKit.h>

@interface UIDevice (SCCDevice)

- (NSString *)UUID;

- (NSString *)macAddress;

- (NSString *)ostype;

@end
