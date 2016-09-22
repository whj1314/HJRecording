//
//  ViewController.m
//  Recorder
//
//  Created by yingxin on 16/7/25.
//  Copyright © 2016年 yingxin. All rights reserved.
//

#import "ViewController.h"
#import "SearchViewController.h"
@import AVKit;
@import AVFoundation;
@interface ViewController ()<UISearchResultsUpdating>
@property (nonatomic)NSArray *arr;
@property (nonatomic)NSString *docPath;
@property (nonatomic)UISearchController *searchC;
@end

@implementation ViewController

+ (instancetype)shareInstance{
    //线程安全的单例
    static ViewController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //此处方法每次程序运行期间 只会进行一次. 就算多个线程访问也没问题.
        vc = [ViewController new];
    });
    return vc;
}
//监听变化的代理方法
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *text = searchController.searchBar.text;
    NSMutableArray *tmpArr = [NSMutableArray new];
    [_arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //containsString判断一个字符串中是否包含零一个字符串
        if ([obj containsString:text]) {
            [tmpArr addObject:obj];
        }
    }];
    SearchViewController *vc = (SearchViewController *)searchController.searchResultsController;
    vc.results = tmpArr;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _arr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AVPlayerViewController *vc = [AVPlayerViewController new];
    NSString *path = [_docPath stringByAppendingPathComponent:_arr[indexPath.row]];
    vc.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:path]];
    [vc.player play];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置是否能在本控制器中切换别的控制器】
    self.definesPresentationContext = YES;
    
    self.title = @"音频列表";
    self.tableView.tableHeaderView = self.searchC.searchBar;
    self.view.backgroundColor = [UIColor randomColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            _arr = [[NSFileManager defaultManager] subpathsAtPath:self.docPath];
            NSLog(@"%@",_arr);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
            });
        });
    }];
    [self.tableView.mj_header beginRefreshing];
}
- (UISearchController *)searchC{
    if (!_searchC) {
        _searchC = [[UISearchController alloc] initWithSearchResultsController:[SearchViewController new]];
        //搜索栏发生变化时的代理
        _searchC.searchResultsUpdater = self;
       
    }
    return _searchC;
}
- (NSArray *)arr {
    if(_arr == nil) {
        _arr = [NSArray new];
    }
    return _arr;
}
- (NSString *)docPath{
    if (!_docPath) {
        _docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    }
    return _docPath;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
