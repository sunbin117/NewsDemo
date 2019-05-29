//
//  BlogViewController.m
//  FlutterGo
//
//  Created by Bin Sun 孙斌 on 2019/2/25.
//  Copyright © 2019 NIO. All rights reserved.
//

#import "BlogViewController.h"
#import "ArticleViewController.h"

@interface BlogViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *urlArray;
@end

@implementation BlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"博客";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.titleArray = [NSArray arrayWithObjects:@"官方中文社区",@"flutter中文网",@"flutter-go",@"咸鱼技术",@"美团技术团队",@"掘金专栏", @"简书专栏",@"资源汇总",nil];
    self.urlArray = [NSArray arrayWithObjects:@"https://flutter-io.cn/",@"https://flutterchina.club/",@"https://github.com/alibaba/flutter-go",@"https://www.yuque.com/xytech/flutter",@"https://tech.meituan.com/tags/flutter.html",@"https://juejin.im/tag/Flutter",@"https://www.jianshu.com/c/ebc9d2e84214",@"https://github.com/crazycodeboy/awesome-flutter-cn" ,nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"blogCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"blogCell"];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ArticleViewController *vc = [[ArticleViewController alloc] init];
    vc.url = self.urlArray[indexPath.row];
    vc.titleText = self.titleArray[indexPath.row];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

@end
