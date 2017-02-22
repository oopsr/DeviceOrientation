//
//  ViewController.m
//  DeviceOrientation
//
//  Created by Tg W on 17/2/22.
//  Copyright © 2017年 oopsr. All rights reserved.
//

#import "ViewController.h"
#import "DeviceOrientation.h"

@interface ViewController ()<DeviceOrientationDelegate>
@end

@implementation ViewController {
    DeviceOrientation *deviceMotion;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    deviceMotion = [[DeviceOrientation alloc]initWithDelegate:self];
}

- (IBAction)startMonitor:(id)sender {
    
    [deviceMotion startMonitor];
}
- (IBAction)stop:(id)sender {
    //不用时请关掉
    [deviceMotion stop];
    
    self.loglabel.text = @"";
}

- (void)directionChange:(TgDirection)direction {
    
    switch (direction) {
        case TgDirectionPortrait:
            
            self.loglabel.text = @"protrait";
            
            break;
        case TgDirectionDown:
            
            self.loglabel.text = @"down";

            break;
        case TgDirectionRight:
            
            self.loglabel.text = @"right";

            break;
        case TgDirectionleft:
            
            self.loglabel.text = @"left";

            break;
    
        default:
            break;
    }
}

@end
