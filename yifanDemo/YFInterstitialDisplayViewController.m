//
//  ViewController.m
//  yifanDemo
//
//  Created by liuyaqiang on 2017/2/22.
//  Copyright © 2017年 yifan. All rights reserved.
//

#import "YFInterstitialDisplayViewController.h"
#import "PluginSDK/PluginHelperOC.h"
#import "MBProgressHUD+EV.h"
#import "Masonry.h"
#define PAGE @"main"

@interface YFInterstitialDisplayViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSString *interstitial,*posIntAhead, *posIntAfter;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation YFInterstitialDisplayViewController
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [IMSdk initWithAccountID:@"4028cb8b2c3a0b45012c406824e800ba"];
    
    //    [IMSdk setLogLevel:kIMSDKLogLevelDebug];
    
    //    self.interstitialaa = [[IMInterstitial alloc] initWithPlacementId:[@"1446377525790" integerValue]];
    //    self. interstitialaa.delegate = self;
    //    [self.interstitialaa load];
    
    
    switch (self.displayType) {
        case YFAdsDisplayTypeDefault:
            self.title = @"default interstitial";
            break;
        case YFAdsDisplayTypeAds:
            self.title = @"ads interstitial";
            break;
        case YFAdsDisplayTypeSelf:
            self.title = @"self interstital";
            break;
        default:
            break;
    }
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    UIButton *rightBu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
    [rightBu setTitle:@"hidden" forState:UIControlStateNormal];
    [rightBu addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBu];
    self.navigationItem.rightBarButtonItem = rightItem;
}
#pragma mark -
#pragma mark UITableViewDataSource/UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001f;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *rowArr = self.dataArr[section];
    return rowArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray *rowArr = self.dataArr[indexPath.section];
    NSString *text = rowArr[indexPath.row];
    cell.textLabel.text = text;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *rowArr = self.dataArr[indexPath.section];
    NSString *text = rowArr[indexPath.row];
    if([text isEqualToString:interstitial]){
        [PluginHelperOC showInterstialWithDisplayType:self.displayType withPage:@"" shownHandler:^{
            NSLog(@"interstitial show");
        } completionHandler:^(BOOL isCompletion) {
            NSLog(@"%@ --- %@ isCompletion",self.title,text);
        }];
    }else if ([text isEqualToString:posIntAhead]){
        [PluginHelperOC showInterstitialWithDisplayType:self.displayType withPos:1 withGapEnable:NO withPage:PAGE shownHandler:^{
            NSLog(@"interstitial show");
        } completionHandler:^(BOOL completion) {
            NSLog(@"%@ --- %@ isCompletion",self.title,text);
            
        }];
    }else if ([text isEqualToString:posIntAfter]){
        [PluginHelperOC showInterstitialWithDisplayType:self.displayType withPos:2 withGapEnable:NO withPage:PAGE shownHandler:^{
            NSLog(@"interstitial show");
        } completionHandler:^(BOOL completion) {
            NSLog(@"%@ --- %@ isCompletion",self.title,text);
        }];
    }


}
#pragma mark - response Event
- (void)hidden
{
    [PluginHelperOC hideBanner];
    [PluginHelperOC hideIcon];
    [PluginHelperOC hideNative];    
}

#pragma mark - Get
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}
- (NSArray *)dataArr
{
    if (!_dataArr) {
         interstitial = @"正常出",posIntAhead = @"前出",posIntAfter = @"后出";
        _dataArr = @[@[ interstitial,posIntAhead,posIntAfter]];
    }
    return _dataArr;
}

@end
