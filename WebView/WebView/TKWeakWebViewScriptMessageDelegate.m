//
//  TKWeakWebViewScriptMessageDelegate.m
//  WebView
//
//  Created by hanxiuhui on 2020/5/12.
//  Copyright © 2020 hanxiuhui. All rights reserved.
//

#import "TKWeakWebViewScriptMessageDelegate.h"

@implementation TKWeakWebViewScriptMessageDelegate

#pragma mark - Init Methods

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}


#pragma mark - WKScriptMessageHandler

// 通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

@end
