/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <Foundation/Foundation.h>

@class ABI14_0_0RCTUIManager;

@interface ABI14_0_0RCTViewPropertyMapper : NSObject

@property (nonatomic, readonly) NSNumber *viewTag;

- (instancetype)initWithViewTag:(NSNumber *)viewTag
                      uiManager:(ABI14_0_0RCTUIManager *)uiManager NS_DESIGNATED_INITIALIZER;

- (void)updateViewWithDictionary:(NSDictionary<NSString *, NSObject *> *)updates;

@end
