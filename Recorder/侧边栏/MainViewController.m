//
//  MainViewController.m
//  Recorder
//
//  Created by tarena on 16/7/25.
//  Copyright © 2016年 yingxin. All rights reserved.
//

#import "MainViewController.h"

@import AVFoundation;

@interface MainViewController ()<AVAudioRecorderDelegate>
@property (nonatomic) AVAudioRecorder *recorder;
//录制音频的相关配置(需要一点专业知识)
@property (nonatomic) NSDictionary *audioSetting;
//用于存储音频的临时路径
@property (nonatomic) NSURL *tmpURL;
//添加一个颜色视图  视图宽度随声音大小改变
@property (nonatomic)UIView *colorV;

@property (nonatomic) NSTimer *timer;
@end

@implementation MainViewController
- (NSURL *)tmpURL{
    if (!_tmpURL) {
        //~/tmp/0000
        NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"0000.caf"];
        //把path转成URL, 转化本地文件路径的.
        _tmpURL = [NSURL fileURLWithPath:path];
    }
    return _tmpURL;
}

- (NSDictionary *)audioSetting{
    if (!_audioSetting) {
        //音频的录制属性
        NSMutableDictionary *dicM = [NSMutableDictionary new];
        //设置录制的格式, PCM是最高品质的caf格式
        [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
        //采样频率, 8000是电话采样频率, 一般录音足够
        [dicM setObject:@(8000) forKey:AVSampleRateKey];
        //设置麦克风声道数量, iOS就一个麦克风
        [dicM setObject:@1 forKey:AVNumberOfChannelsKey];
        //每个采样点位数, 可选数值8,16,24,32
        [dicM setObject:@8 forKey:AVLinearPCMBitDepthKey];
        //是否采用浮点数采样
        [dicM setObject:@YES forKey:AVLinearPCMIsFloatKey];
        _audioSetting = dicM.copy;
    }
    return _audioSetting;
}



+ (instancetype)shareInstance{
    static MainViewController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [MainViewController new];
    });
    return vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置本项目对于音频处理是: 能录又能播
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    //让设置生效
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    
    self.title = @"录音";
    self.view.backgroundColor = [UIColor randomColor];
    //blocksKit提供的初始化
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"Menu" style:UIBarButtonItemStyleDone handler:^(id sender) {
        //弹出左侧菜单
        [self.sideMenuViewController presentLeftMenuViewController];
    }];
    self.navigationItem.leftBarButtonItem = menuItem;
    
    UIBarButtonItem *recordItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"Record" style:UIBarButtonItemStyleDone handler:^(UIBarButtonItem *sender) {
        if (_recorder.isRecording) {
            [_recorder stop];
            _recorder = nil;
            [_timer invalidate];
            NSLog(@"停止录制");
        }else{
            //参数1:录制的音频存储的位置
            //参数2:录制的声音配置
            NSError *error = nil;
            _recorder = [[AVAudioRecorder alloc] initWithURL:self.tmpURL settings:self.audioSetting error:&error];
            _recorder.delegate = self;
            if (error) {
                NSLog(@"%@", error);
            }else{
                [_recorder record]; //开始录
                NSLog(@"正在录制...");
            }
            //允许读取声音的大小
            _recorder.meteringEnabled = YES;
            //每隔0.1s读取一次
            [_timer invalidate];
            _timer=[NSTimer bk_scheduledTimerWithTimeInterval:1/60.0 block:^(NSTimer *timer) {
                //更新
                [_recorder updateMeters];
                float p1 = [_recorder peakPowerForChannel:0];
                NSLog(@"p1->%f",p1);
                //分贝是-160-0大小    转换为  0-160
                float p2 = [_recorder averagePowerForChannel:0]+160;
                NSLog(@"p2->%f",p2);
                CGRect rect = self.colorV.frame;
                rect.size.height = p2 ;
                self.colorV.frame = rect;
            } repeats:YES];
        }
        sender.title = _recorder.isRecording?@"Stop":@"Record";
    }];
    self.navigationItem.rightBarButtonItem = recordItem;
}
- (UIView *)colorV{
    if (!_colorV) {
        _colorV = [[UIView alloc]initWithFrame:CGRectMake(100                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        , 20, 10, 10)];
        _colorV.backgroundColor = [UIColor randomColor];
        [self.view addSubview:_colorV];
    }
    return _colorV;
}
//代理: 当录音结束时触发
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    NSLog(@"%@", flag ? @"录制成功": @"录制失败");
    NSLog(@"%@", self.tmpURL.absoluteString);
    //把文件转移到Documents下
    UIAlertView *alertView = [[UIAlertView alloc] bk_initWithTitle:@"新录音" message:@"请输入新录音的名称"];
    //设置弹出视图 是 带有输入框的风格
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView bk_setCancelButtonWithTitle:@"取消" handler:^{
        [[NSFileManager defaultManager] removeItemAtURL:self.tmpURL error:nil];
    }];
    [alertView bk_addButtonWithTitle:@"确定" handler:^{
        NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        //获取弹出的输入框的内容
        NSString *str = [alertView textFieldAtIndex:0].text;
        //~/Documents/***
        NSString *path = [docPath stringByAppendingPathComponent:str];
        //~/Documents/***.caf
        path = [path stringByAppendingPathExtension:@"caf"];
        NSURL *toURL = [NSURL fileURLWithPath:path];
        [[NSFileManager defaultManager] moveItemAtURL:self.tmpURL toURL:toURL error:nil];
        NSLog(@"%@", toURL.absoluteString);
    }];
    [alertView show];
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
