//
//  TKWeakWebViewScriptMessageDelegate.h
//  WebView
//
//  Created by hanxiuhui on 2020/5/12.
//  Copyright © 2020 hanxiuhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

// WKWebView 内存不释放的问题解决
@interface TKWeakWebViewScriptMessageDelegate : NSObject <WKScriptMessageHandler>

// WKScriptMessageHandler 这个协议类专门用来处理JavaScript调用原生OC的方法
@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

NS_ASSUME_NONNULL_END
