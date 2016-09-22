//
//  ViewController.h
//  Recorder
//
//  Created by yingxin on 16/7/25.
//  Copyright © 2016年 yingxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController
//程序中有一些对象 不需要每次使用都创建. 因为创建对象,开辟内存空间, 释放之前对象都需要消耗大量的CPU资源.
//也就是说 我们开发时需要在CPU和内存的使用上做出权衡.
//单例方法创建的对象寿命与应用程序一致, 消耗内存.
+ (instancetype)shareInstance;

//单例就一个特点: 生成的对象的生命周期与程序一致. 缺点:始终占用内存. 优点:不用多次调用CPU
//利用此特点: 所以单例对象的属性的生命周期也都跟程序一样. 可以把一些我们希望能够始终活在内存中的属性放到单例中保存. 这样可以随时读取和修改.

@end








