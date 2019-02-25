//
//  ViewController.m
//  FlutterGo
//
//  Created by Bin Sun 孙斌 on 2019/2/21.
//  Copyright © 2019 NIO. All rights reserved.
//

#import "ViewController.h"
#import "ArticleCell.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "ArticleModel.h"
#import "ArticleEntryModel.h"
#import "YYModel.h"
#import "UIImageView+WebCache.h"
#import "ArticleViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"首页";
    self.pageIndex = 1;
    [self initView];
    [self initMJRefresh];
    [self loadData];
}

- (void)initView {
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.hud = [[MBProgressHUD alloc] initWithView:self.tableView];
    self.hud.mode = MBProgressHUDModeText;
}

- (void)initMJRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageIndex = 1;
        [self loadData];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.pageIndex ++;
        [self loadData];
    }];
}

- (void)loadData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *param = @{@"src":@"web",@"tagId":@"5a96291f6fb9a0535b535438",@"page":[NSString stringWithFormat:@"%ld" , self.pageIndex],@"pageSize":@"20",@"sort":@"rankIndex"};
    NSString  *url = @"https://timeline-merger-ms.juejin.im/v1/get_tag_entry";
    self.hud.label.text = @"加载中...";
    [self.hud showAnimated:YES];
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ArticleModel *model = [ArticleModel yy_modelWithJSON:responseObject];
        if (self.pageIndex == 1) {
            self.dataArr = [NSMutableArray array];
            self.dataArr = [NSMutableArray arrayWithArray:model.d.entrylist];
        } else {
            [self.dataArr addObjectsFromArray:model.d.entrylist];
        }
        [self.hud hideAnimated:YES];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ArticleCellId = @"ArticleCellId";
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:ArticleCellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ArticleCell" owner:self options:nil] lastObject];
    }
    ArticleEntryModel *model = self.dataArr[indexPath.row];
    cell.titleLabel.text = model.title;
    NSURL *url = [NSURL URLWithString:model.user.avatarLarge];
    [cell.userHeader sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"User_header"]];
    cell.authorLabel.text = model.user.username;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ArticleEntryModel *model = self.dataArr[indexPath.row];
    ArticleViewController *vc = [[ArticleViewController alloc] init];
    vc.url = model.originalUrl;
    vc.titleText = model.title;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

@end
