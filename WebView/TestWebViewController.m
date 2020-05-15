//
//  TestWebViewController.m
//  WebView
//
//  Created by hanxiuhui on 2020/5/15.
//  Copyright © 2020 hanxiuhui. All rights reserved.
//

#import "TestWebViewController.h"
#import "AppDelegate.h"
#import <Masonry.h>
#import <WebKit/WebKit.h>

@interface TestWebViewController () <WKNavigationDelegate> {
    NSTimeInterval _start;
}
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation TestWebViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.webView];
    
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(2);
    }];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.progressView.mas_bottom);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-self.view.safeAreaInsets.bottom);
        } else {
            // Fallback on earlier versions
            make.top.equalTo(self.progressView.mas_bottom);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }
    }];
    
    
    
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:(NSKeyValueObservingOptionNew) context:NULL];
    
    
    
    
    
    NSString *whiteUrl = @"http://people.mozilla.org/~rnewman/fennec/mem.html";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:whiteUrl]];
    [request addValue:@"" forHTTPHeaderField:@""];
    
    
    [self.webView loadRequest:request];
}



- (void)dealloc {
    NSLog(@"%@ - 销毁了", NSStringFromClass(self.class));
    ((AppDelegate *)[UIApplication sharedApplication].delegate).timeLabel.text = @"webView加载耗时：0 s";
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
//        NSNumber *value = change[NSKeyValueChangeNewKey];
//        NSLog(@"value = %@", value);
//        [self.progressView setProgress:value.floatValue animated:YES];
//
//
        double estimatedProgress = _webView.estimatedProgress;
        NSLog(@"网页加载进度 = %f", estimatedProgress);
        self.progressView.progress =
        (estimatedProgress >= 1.0) ? 0.0 : estimatedProgress;
        
    }
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"webView 开始加载");
    _start = [NSDate timeIntervalSinceReferenceDate];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"webView 加载结束");
    NSTimeInterval end = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval dif = end - _start;
    NSLog(@"webView加载耗时：%@ s", @(dif));
    
    
    ((AppDelegate *)[UIApplication sharedApplication].delegate).timeLabel.text = [NSString stringWithFormat:@"webView加载耗时：%.2f s", dif];
    
}

// ios9
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    
}

#pragma mark - getter

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:(UIProgressViewStyleBar)];
        _progressView.tintColor = UIColor.blueColor;
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}
@end
