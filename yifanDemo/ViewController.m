//
//  ViewController.m
//  yifanDemo
//
//  Created by liuyaqiang on 2017/2/22.
//  Copyright © 2017年 yifan. All rights reserved.
//

#import "ViewController.h"
#import "PluginSDK/PluginHelperOC.h"
#import "MBProgressHUD+EV.h"
#import "Masonry.h"
#import "YFInterstitialDisplayViewController.h"
#import "AppDelegate.h"
#import "YFSettingViewController.h"

#define PAGE @"main"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSString *showNextControl,*setting,*banner, *hideBanner, *interstitial, *adsInterstital,*selfInterstial, *native, *hideNative, *video, *icon, *hideIcon, *more, *offer, *gift, *followTask,*videoTask, *clearFollow, *clearInstallAppInfo, *refreshGeo;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation ViewController

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];


    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UIButton *rightBu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 45)];
    rightBu.backgroundColor = [UIColor blueColor];
    [rightBu setTitle:@"hidden" forState:UIControlStateNormal];
    [rightBu addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
       UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBu];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UILabel *titleLa = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    titleLa.adjustsFontSizeToFitWidth = YES;
    titleLa.text = [NSString stringWithFormat:@"appkey:%@",AppKey];
    titleLa.textColor = [UIColor blueColor];
    self.navigationItem.titleView = titleLa;

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
    cell.backgroundColor = [UIColor whiteColor];
    if ([text isEqualToString:setting] || [text isEqualToString:showNextControl]) {
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *rowArr = self.dataArr[indexPath.section];
    NSString *text = rowArr[indexPath.row];
    if ([text isEqualToString:showNextControl]) {
        ViewController *ctl = [[ViewController alloc]init];
        [self.navigationController pushViewController:ctl animated:YES];
    }
   else if ([text isEqualToString:setting]) {
        YFSettingViewController *setCtl = [[YFSettingViewController alloc]init];
        [self presentViewController:setCtl animated:YES completion:nil];
    }else if ([text isEqualToString:banner]) {
        //[PluginHelperOC showBannerWithPostion:Bottom];
        [PluginHelperOC showBanner];

    }else if ([text isEqualToString:hideBanner]){
        [PluginHelperOC hideBanner];
    }else if ([text isEqualToString:interstitial]){
        YFInterstitialDisplayViewController *ctl = [[YFInterstitialDisplayViewController alloc]init];
        ctl.displayType = YFAdsDisplayTypeDefault;
        [self.navigationController pushViewController:ctl animated:YES];
    }else if([text isEqualToString:adsInterstital]){
        YFInterstitialDisplayViewController *ctl = [[YFInterstitialDisplayViewController alloc]init];
        ctl.displayType = YFAdsDisplayTypeAds;
        [self.navigationController pushViewController:ctl animated:YES];
    }else if([text isEqualToString:selfInterstial]){
        YFInterstitialDisplayViewController *ctl = [[YFInterstitialDisplayViewController alloc]init];
        ctl.displayType = YFAdsDisplayTypeSelf;
        [self.navigationController pushViewController:ctl animated:YES];
    }else if ([text isEqualToString:native]){
        if ([PluginHelperOC hasNative]) {
            [PluginHelperOC showNativeAdWithFrame:CGRectMake(0,0,500,500)];
        }else{
            [self.view showHUDWithTitle:@"no native"];
        }
    }else if ([text isEqualToString:hideNative]){
        [PluginHelperOC hideNative];
    }else if ([text isEqualToString:video]){
        if ([PluginHelperOC hasVideo]) {
            
            [PluginHelperOC showVideo:^{
                //NSLog(@"video show");
            } withCompletion:^(BOOL completrion) {
                if (completrion) {
                    [self.view showHUDWithTitle:@"kan wan"];
                }else{
                    [self.view showHUDWithTitle:@"mei kan wan"];
                }
            }];
        }else{
            [self.view showHUDWithTitle:@"no video"];
        }
    }else if ([text isEqualToString:icon]){
        if ([PluginHelperOC hasIcon]) {
            [PluginHelperOC showIcon];
        }else{
            [self.view showHUDWithTitle:@"无Icon"];
        }
    }else if ([text isEqualToString:hideIcon]){
        [PluginHelperOC hideIcon];
    }else if ([text isEqualToString:more]){
        if ([PluginHelperOC hasMore]) {
            [PluginHelperOC showMore];
        }else{
            [self.view showHUDWithTitle:@"no more"];
        }
    }else if ([text isEqualToString:offer]){
        __block UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if ([PluginHelperOC hasOfferWithTaskType:0]) {
            [PluginHelperOC showOfferWithTaskType:0 withTemplateType:0 completionHandler:^(NSString * str) {
                NSLog(@"offer completion......%@",str);
                cell.detailTextLabel.text =  [NSString stringWithFormat:@"%ld",([cell.detailTextLabel.text integerValue] + [str integerValue])];
            }];
        }else{
            [self.view showHUDWithTitle:@"no offer"];
        }
    }else if ([text isEqualToString:gift]){
        if ([PluginHelperOC hasInterstitialGift:PAGE]) {
            [PluginHelperOC showInterstitialGift:PAGE shownHandler:^{
                NSLog(@"gift show");
            } completionHandler:^(BOOL isClosed) {
                NSLog(@"gift closed");
            }];
        }else{
            [self.view showHUDWithTitle:@"no gift"];
        }
    }else if ([text isEqualToString:followTask]){
        
    }else if ([text isEqualToString:clearFollow]){
        [PluginHelperOC clearFollow];

    }else if ([text isEqualToString:clearInstallAppInfo]){
        [PluginHelperOC clearInstallAppInfo];
    }else if ([text isEqualToString:videoTask]){
        NSString *vt = [PluginHelperOC hasVideoOrTask];
        if ([vt isEqualToString:@"video"]) {
            [PluginHelperOC showVideo:^{
                //NSLog(@"video show");
            } withCompletion:^(BOOL completrion) {
                if (completrion) {
                    [self.view showHUDWithTitle:@"kan wan"];
                }else{
                    [self.view showHUDWithTitle:@"mei kan wan"];
                }
            }];
        } else if ([vt isEqualToString:@"task"]){
            __block UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [PluginHelperOC showTask:^(NSString * str) {
                NSLog(@"offer completion......%@",str);
                cell.detailTextLabel.text =  [NSString stringWithFormat:@"%ld",([cell.detailTextLabel.text integerValue] + [str integerValue])];
            }];
        }
        else {
            [self.view showHUDWithTitle:@"no video no task"];
        }
    }else if ([text isEqualToString:refreshGeo]){
        [[PluginHelperOC getInstance]getNewReg];
        [self.view showHUDWithTitle:[PluginHelperOC getAreaCode]];
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
        showNextControl = @"多界面test", setting = @"setting" , banner = @"banner", hideBanner = @"hide banner", interstitial = @"interstitial",adsInterstital = @"adsInterstial",selfInterstial = @"selfInterstial",native = @"native", hideNative = @"hide native", video = @"video", icon = @"icon", hideIcon = @"hide icon", more = @"more", offer = @"offer", gift = @"gift", followTask = @"followTask", clearFollow = @"clearFollow", clearInstallAppInfo = @"clearInstallAppInfo",videoTask = @"videoTask", refreshGeo = @"refreshGeo";
        _dataArr = @[@[showNextControl,setting ,banner, hideBanner, interstitial, adsInterstital,selfInterstial,native, hideNative, video, icon, hideIcon, more, offer, gift, followTask, clearFollow, clearInstallAppInfo,videoTask, refreshGeo]];
    }
    return _dataArr;
}


@end
