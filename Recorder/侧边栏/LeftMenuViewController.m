//
//  LeftMenuViewController.m
//  Recorder
//
//  Created by tarena on 16/7/25.
//  Copyright © 2016年 yingxin. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "MainViewController.h" //录音
#import "ViewController.h" //音频列表

@interface LeftMenuViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor randomColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 100, 100) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    //去掉分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    if (indexPath.row == 0) {
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[ViewController shareInstance]];
        [self.sideMenuViewController setContentViewController:navi animated:NO];
    }else{
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[MainViewController shareInstance]];
        [self.sideMenuViewController setContentViewController:navi animated:NO];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = @[@"音频列表", @"录音"][indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
