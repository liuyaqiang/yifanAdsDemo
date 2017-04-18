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
#import <InMobiSDK/InMobiSDK.h>
#import "YFInterstitialDisplayViewController.h"
#import "AppDelegate.h"
#define PAGE @"main"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,IMInterstitialDelegate>
{
    NSString *banner, *interstitial, *adsInterstital,*selfInterstial, *native, *video, *icon, *more, *offer, *gift, *followTask,*videoTask, *clearFollow, *clearInstallAppInfo;
}
@property (weak, nonatomic) IBOutlet UISwitch *vungleMSwitch;
@property (weak, nonatomic) IBOutlet UILabel *vungleModeLa;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) IMInterstitial *interstitialaa;

@end

@implementation ViewController
- (IBAction)switchVungleMode:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:@"vungleMode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.vungleModeLa.text = sender.isOn ? @"isVungelInterstitialMode" : @"isVungleVideoMode";
    [self.view showHUDWithTitle:@"注意" detail:@"请重启app，从新加载数据，似vugle切换有效" duration:3];
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    //vungleSwitch
    [self.vungleMSwitch setOn:[[NSUserDefaults standardUserDefaults]boolForKey:@"vungleMode"]];
    self.vungleModeLa.text = self.vungleMSwitch.isOn ? @"isVungelInterstitialMode" : @"isVungleVideoMode";

    UILabel *titleLa = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    titleLa.adjustsFontSizeToFitWidth = YES;
    titleLa.text = [NSString stringWithFormat:@"appkey:%@",AppKey];
    titleLa.textColor = [UIColor blueColor];
    self.navigationItem.titleView = titleLa;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    UIButton *rightBu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 45)];
    rightBu.backgroundColor = [UIColor blueColor];
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
    if ([text isEqualToString:banner]) {
//        [AdMgr showAdWithType:@"banner" showWithPage:PAGE showWithEntry:@""];
//        [PluginHelperOC setBannerPostion:Bottom];
//        [PluginHelperOC showBannerWithPage:PAGE withEntry:@""];
        [PluginHelperOC showBannerWithPage:PAGE withEntry:@"" postion:Bottom];

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
        if ([PluginHelperOC hasNativeWithPage:PAGE withEntry:@""]) {
//            [PluginHelperOC showNativeAdWithPage:PAGE showWithEntry:@"" showWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width*2.0 - [UIScreen mainScreen].bounds.size.height*2.0)/2.0, ([UIScreen mainScreen].bounds.size.height*2.0 -  [UIScreen mainScreen].bounds.size.width*2.0)/2 ,[UIScreen mainScreen].bounds.size.height*2.0 , [UIScreen mainScreen].bounds.size.width*2.0)];
//        [PluginHelperOC showNativeAdWithPage:PAGE showWithEntry:@"" showWithFrame:CGRectMake(636,186,1037,1056)];
//            [PluginHelperOC isScreenNativeScale:YES];
//        [PluginHelperOC showNativeAdWithPage:PAGE showWithEntry:@"" showWithFrame:CGRectMake(847,248,1383,1408)];
//        [PluginHelperOC showNativeAdWithPage:PAGE showWithEntry:@"" showWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width*2.0 - 769)/2.0,([UIScreen mainScreen].bounds.size.height*2.0 -  522)/2,769,522)];
        [PluginHelperOC showNativeAdWithPage:PAGE showWithEntry:@"" showWithFrame:CGRectMake(0,0,500,500)];

        }else{
            [self.view showHUDWithTitle:@"no native"];
        }
        
    }else if ([text isEqualToString:video]){
        if ([PluginHelperOC hasVideoWithPage:PAGE withEntry:@""]) {
            [PluginHelperOC showVideoWithPage:PAGE withEntry:@"" completionHandler:^(BOOL completrion) {
                
            }];
        }else{
            [self.view showHUDWithTitle:@"no video"];
        }
    }else if ([text isEqualToString:icon]){
        if ([PluginHelperOC hasIconWithPage:PAGE withEntry:@""]) {
            [PluginHelperOC showIconWithPage:PAGE withEntry:@""];
        }else{
            [self.view showHUDWithTitle:@"无Icon"];
        }
    }else if ([text isEqualToString:more]){
        if ([PluginHelperOC hasMoreWithPage:PAGE withEntry:@""]) {
            [PluginHelperOC showMoreWithPage:PAGE withEntry:@""];
        }else{
            [self.view showHUDWithTitle:@"on more"];
        }
    }else if ([text isEqualToString:offer]){
        if ([PluginHelperOC hasOfferWithPage:PAGE withEntry:@"" withTaskType:0]) {
            [PluginHelperOC showOfferWithPage:PAGE withEntry:@"" withTaskType:0 withTemplateType:0 completionHandler:^(NSString * str) {
                NSLog(@"offer completion......%@",str);
            }];
        }else{
            [self.view showHUDWithTitle:@"no offer"];
        }
    }else if ([text isEqualToString:gift]){
        
    }else if ([text isEqualToString:followTask]){
        
    }else if ([text isEqualToString:clearFollow]){
        [PluginHelperOC clearFollow];

    }else if ([text isEqualToString:clearInstallAppInfo]){
        [PluginHelperOC clearInstallAppInfo];
    }else if ([text isEqualToString:videoTask]){
        NSString *vt = [PluginHelperOC hasVideoOrTask:PAGE];
        if ([vt isEqualToString:@"video"]) {
            [PluginHelperOC showVideoWithPage:PAGE withEntry:@"" completionHandler:^(BOOL completrion) {
            }];
        } else if ([vt isEqualToString:@"task"]){
            [PluginHelperOC showTask:PAGE];
        }
        else {
            [self.view showHUDWithTitle:@"no video no task"];
        }
    }
}
#pragma mark - response Event
- (void)hidden
{
    [PluginHelperOC hideBanner];
    [PluginHelperOC hideIcon];
    [PluginHelperOC hideNative];
    if (self.interstitialaa.isReady) {
     
    }
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
        banner = @"banner", interstitial = @"interstitial",adsInterstital = @"adsInterstial",selfInterstial = @"selfInterstial",native = @"native", video = @"video", icon = @"icon", more = @"more", offer = @"offer", gift = @"gift", followTask = @"followTask", clearFollow = @"clearFollow", clearInstallAppInfo = @"clearInstallAppInfo",videoTask = @"videoTask";
        _dataArr = @[@[banner, interstitial, adsInterstital,selfInterstial,native, video, icon, more, offer, gift, followTask, clearFollow, clearInstallAppInfo,videoTask]];
    }
    return _dataArr;
}


@end
