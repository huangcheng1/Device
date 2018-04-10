//
//  SCCKeychainWrapper.h
//  Pods
//
//  Created by huang cheng on 2017/4/19.
//
//

#import <Foundation/Foundation.h>

@interface SCCKeychainWrapper : NSObject

// Designated initializer.
- (id)initWithIdentifier: (NSString *)identifier accessGroup:(NSString *)accessGroup;
- (void)setObject:(id)inObject forKey:(id)key;
- (id)objectForKey:(id)key;

// Initializes and resets the default generic keychain item data.
- (void)resetKeychainItem;


@end
