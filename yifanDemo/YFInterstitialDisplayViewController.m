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
#import "YFCommonHeader.h"


@interface YFInterstitialDisplayViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSString *interstitial,*posIntAhead_noGap, *posIntAhead_gap;
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
        [PluginHelperOC showInterstialWithDisplayType:self.displayType withPage:PAGE shownHandler:^{
            NSLog(@"interstitial show");
        } completionHandler:^(BOOL isCompletion) {
            NSLog(@"%@ --- %@ isCompletion",self.title,text);
        }];
    }else if ([text isEqualToString:posIntAhead_noGap]){
        [PluginHelperOC showInterstitialWithDisplayType:self.displayType withPos:1 withGapEnable:NO withPage:PAGE shownHandler:^{
            NSLog(@"interstitial show");
        } completionHandler:^(BOOL completion) {
            NSLog(@"%@ --- %@ isCompletion",self.title,text);
            
        }];
        UIAlertView *AlertView = [[UIAlertView alloc]initWithTitle:@"后出(不受gap控制)" message:@"" delegate:self cancelButtonTitle:@"展示" otherButtonTitles: nil];
        AlertView.tag = 0;
        [AlertView show];
    }else if ([text isEqualToString:posIntAhead_gap]){
        [PluginHelperOC showInterstitialWithDisplayType:self.displayType withPos:1 withGapEnable:YES withPage:PAGE shownHandler:^{
            NSLog(@"interstitial show");
        } completionHandler:^(BOOL completion) {
            NSLog(@"%@ --- %@ isCompletion",self.title,text);
            
        }];
        UIAlertView *AlertView = [[UIAlertView alloc]initWithTitle:@"后出(受gap控制)" message:@"" delegate:self cancelButtonTitle:@"展示" otherButtonTitles: nil];
        AlertView.tag = 1;
        [AlertView show];
    }


}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 0) {
        [PluginHelperOC showInterstitialWithDisplayType:self.displayType withPos:2 withGapEnable:NO withPage:PAGE shownHandler:^{
            NSLog(@"interstitial show");
        } completionHandler:^(BOOL completion) {
            
        }];
    }else{
        [PluginHelperOC showInterstitialWithDisplayType:self.displayType withPos:2 withGapEnable:YES withPage:PAGE shownHandler:^{
            NSLog(@"interstitial show");
        } completionHandler:^(BOOL completion) {
            
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
         interstitial = @"正常出",posIntAhead_noGap = @"前出(不受gap控制)", posIntAhead_gap = @"前出(受gap控制)";
        _dataArr = @[@[ interstitial,posIntAhead_noGap, posIntAhead_gap]];
    }
    return _dataArr;
}

@end
