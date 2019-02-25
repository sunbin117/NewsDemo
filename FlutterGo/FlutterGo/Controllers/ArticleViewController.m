//
//  ArticleViewController.m
//  FlutterGo
//
//  Created by Bin Sun 孙斌 on 2019/2/22.
//  Copyright © 2019 NIO. All rights reserved.
//

#import "ArticleViewController.h"
#import <WebKit/WebKit.h>

#define ScreenHeight              [[UIScreen mainScreen] bounds].size.height     //屏幕高
#define ScreenWidth              [[UIScreen mainScreen] bounds].size.width     //屏幕宽

@interface ArticleViewController ()
@property (nonatomic, strong) WKWebView *articleView;
//网页加载进度视图
@property (nonatomic, strong) UIProgressView * progressView;
@end

@implementation ArticleViewController

#pragma mark -- Getter

- (UIProgressView *)progressView
{
    if (!_progressView){
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + UIApplication.sharedApplication.statusBarFrame.size.height + 1, self.view.frame.size.width, 2)];
        _progressView.tintColor = [UIColor blueColor];
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.titleText;
    [self setupWebView];
    [self setupNavigationItem];
}

- (void)setupWebView {
    self.articleView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.articleView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    self.articleView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.articleView];
    [self.view addSubview:self.progressView];
    //添加监测网页加载进度的观察者
    [self.articleView addObserver:self
                       forKeyPath:@"estimatedProgress"
                          options:0
                          context:nil];
    //添加监测网页标题title的观察者
    [self.articleView addObserver:self
                       forKeyPath:@"title"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
}

- (void)setupNavigationItem {
    // 后退按钮
    UIButton * goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goBackButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [goBackButton addTarget:self action:@selector(goBackAction:) forControlEvents:UIControlEventTouchUpInside];
    goBackButton.frame = CGRectMake(0, 0, 30, self.navigationController.navigationBar.frame.size.height + UIApplication.sharedApplication.statusBarFrame.size.height);
    UIBarButtonItem * goBackButtonItem = [[UIBarButtonItem alloc] initWithCustomView:goBackButton];
    self.navigationItem.leftBarButtonItem = goBackButtonItem;
    
    // 刷新按钮
    UIButton * refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshButton setImage:[UIImage imageNamed:@"webRefreshButton"] forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventTouchUpInside];
    refreshButton.frame = CGRectMake(0, 0, 30, self.navigationController.navigationBar.frame.size.height + UIApplication.sharedApplication.statusBarFrame.size.height);
    UIBarButtonItem * refreshButtonItem = [[UIBarButtonItem alloc] initWithCustomView:refreshButton];
    self.navigationItem.rightBarButtonItem = refreshButtonItem;
}

#pragma mark -- Event Handle

- (void)goBackAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshAction:(id)sender{
    [self.articleView reload];
}

//kvo 监听进度 必须实现此方法
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == _articleView) {
        NSLog(@"网页加载进度 = %f",_articleView.estimatedProgress);
        self.progressView.progress = _articleView.estimatedProgress;
        if (_articleView.estimatedProgress >= 1.0f) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.progress = 0;
            });
        }
    }else if([keyPath isEqualToString:@"title"]
             && object == _articleView){
        self.navigationItem.title = _articleView.title;
    }else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

@end
