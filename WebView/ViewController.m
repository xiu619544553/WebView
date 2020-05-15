//
//  ViewController.m
//  WebView
//
//  Created by hanxiuhui on 2020/5/12.
//  Copyright © 2020 hanxiuhui. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "TKWebViewController.h"
#import "TestWebViewController.h"

static NSString *cellIdentifier = @"UITableViewCell";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"WKWebView使用";
    [self.view addSubview:self.tableView];
    
    if (@available(iOS 11.0, *)) {
        NSLog(@"Fallback on earlier versions = %@", NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
    } else {
        // Fallback on earlier versions
        NSLog(@"Fallback on earlier versions");
    }
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.equalTo(self.view).insets(self.view.safeAreaInsets);
        } else {
            // Fallback on earlier versions
            make.edges.equalTo(self.view);
        }
    }];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = indexPath.row;
    UIViewController *webVc = nil;
    
    if (row == 0) {
        webVc = [TKWebViewController new];
    } else if (row == 1) {
        webVc = [TestWebViewController new];
    }
    
    [self.navigationController pushViewController:webVc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSUInteger row = indexPath.row;
    if (row == 0) {
        cell.textLabel.text = @"WKWebView 使用";
    } else if (row == 1) {
        cell.textLabel.text = @"TestWebViewController 使用";
    }
    
    return cell;
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellIdentifier];
    }
    return _tableView;
}
@end
