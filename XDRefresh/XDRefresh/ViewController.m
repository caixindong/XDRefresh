//
//  ViewController.m
//  XDRefresh
//
//  Created by 蔡欣东 on 2016/7/27.
//  Copyright © 2016年 蔡欣东. All rights reserved.
//

#import "ViewController.h"
#import "XDRefresh.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    int _dataCount;
    XDRefreshHeader *_header;
    XDRefreshFooter *_footer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"XDRefreshDemo";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _dataCount = 0;
    
    UITableView *tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64) style:UITableViewStylePlain];
    
    [self.view addSubview:tableView];
    
    tableView.dataSource=self;
    tableView.delegate = self;
    
    _header =  [XDRefreshHeader headerOfScrollView:tableView refreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"hello");
                [_footer resetNoMoreData];
                _dataCount = 20;
                [tableView reloadData];
                [_header endRefreshing];
            });
        });
    }];
    
    [_header beginRefreshing];
    
    _footer = [XDRefreshFooter footerOfScrollView:tableView refreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"hello2");
                _dataCount += 10;
                
                if (_dataCount >= 40) {
                    [_footer endRefreshingWithNoMoreDataWithTitle:@"无数据了"];
                }else {
                    [tableView reloadData];
                    [_footer endRefreshing];
                }
            });
        });
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
    // Configure the cell...
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
