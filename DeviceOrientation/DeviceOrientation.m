//
//  DeviceOrientation.m
//  DeviceOrientation
//
//  Created by Tg W on 17/2/22.
//  Copyright © 2017年 oopsr. All rights reserved.
//

#import "DeviceOrientation.h"
#import <CoreMotion/CoreMotion.h>

@interface DeviceOrientation () {
    
    CMMotionManager *_motionManager;
    TgDirection _direction;

}
@end
//sensitive 灵敏度
static const float sensitive = 0.77;

@implementation DeviceOrientation

- (instancetype)initWithDelegate:(id<DeviceOrientationDelegate>)delegate {
    self = [super init];
    if (self) {
        
        _delegate = delegate;
    }
    return self;
}
- (void)startMonitor {
    
    [self start];
}

- (void)stop {
    
    [_motionManager stopDeviceMotionUpdates];
}


//陀螺仪 每隔一个间隔做轮询
- (void)start{
    
    if (_motionManager == nil) {
        
        _motionManager = [[CMMotionManager alloc] init];
    }
    _motionManager.deviceMotionUpdateInterval = 1/40.f;
    if (_motionManager.deviceMotionAvailable) {
        
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue]
                                            withHandler: ^(CMDeviceMotion *motion, NSError *error){
                                                [self performSelectorOnMainThread:@selector(deviceMotion:) withObject:motion waitUntilDone:YES];
                                            }];
    }
}
- (void)deviceMotion:(CMDeviceMotion *)motion{
    
    double x = motion.gravity.x;
    double y = motion.gravity.y;
    if (y < 0 ) {
        if (fabs(y) > sensitive) {
            if (_direction != TgDirectionPortrait) {
                _direction = TgDirectionPortrait;
                if ([self.delegate respondsToSelector:@selector(directionChange:)]) {
                    [self.delegate directionChange:_direction];
                }
            }
        }
    }else {
        if (y > sensitive) {
            if (_direction != TgDirectionDown) {
                _direction = TgDirectionDown;
                if ([self.delegate respondsToSelector:@selector(directionChange:)]) {
                    [self.delegate directionChange:_direction];
                }
            }
        }
    }
    if (x < 0 ) {
        if (fabs(x) > sensitive) {
            if (_direction != TgDirectionleft) {
                _direction = TgDirectionleft;
                if ([self.delegate respondsToSelector:@selector(directionChange:)]) {
                    [self.delegate directionChange:_direction];
                }
            }
        }
    }else {
        if (x > sensitive) {
            if (_direction != TgDirectionRight) {
                _direction = TgDirectionRight;
                if ([self.delegate respondsToSelector:@selector(directionChange:)]) {
                    [self.delegate directionChange:_direction];
                }
            }
        }
    }    
}

@end
