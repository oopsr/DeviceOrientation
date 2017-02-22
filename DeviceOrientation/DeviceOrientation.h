//
//  DeviceOrientation.h
//  DeviceOrientation
//
//  Created by Tg W on 17/2/22.
//  Copyright © 2017年 oopsr. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,TgDirection) {
    TgDirectionUnkown,
    TgDirectionPortrait,
    TgDirectionDown,
    TgDirectionRight,
    TgDirectionleft,
};

@protocol DeviceOrientationDelegate <NSObject>

- (void)directionChange:(TgDirection)direction;

@end
@interface DeviceOrientation : NSObject

@property(nonatomic,strong)id<DeviceOrientationDelegate>delegate;

- (instancetype)initWithDelegate:(id<DeviceOrientationDelegate>)delegate;
/**
 开启监听
 */
- (void)startMonitor;
/**
 结束监听，请stop
 */
- (void)stop;

@end
