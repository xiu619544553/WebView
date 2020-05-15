//
//  AppDelegate.m
//  WebView
//
//  Created by hanxiuhui on 2020/5/12.
//  Copyright © 2020 hanxiuhui. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <FLEX/FLEX.h>
#import <Masonry.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];
    
    [[FLEXManager sharedManager] showExplorer];
    [self addTimeLabel];
    
    return YES;
}

#pragma mark - UI

- (void)addTimeLabel {
    [self.window addSubview:self.timeLabel];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(74.f);
        make.left.mas_equalTo(10.f);
    }];
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.5];
        _timeLabel.textColor = UIColor.whiteColor;
        _timeLabel.font = [UIFont systemFontOfSize:16.f];
        _timeLabel.text = @"耗时：0 s";
        _timeLabel.layer.cornerRadius = 4.f;
    }
    return _timeLabel;
}
@end
