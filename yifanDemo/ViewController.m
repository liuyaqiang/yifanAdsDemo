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
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) IMInterstitial *interstitialaa;

@end

@implementation ViewController
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
    
    UILabel *titleLa = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    titleLa.adjustsFontSizeToFitWidth = YES;
    titleLa.text = [NSString stringWithFormat:@"appkey:%@",AppKey];
    titleLa.textColor = [UIColor blueColor];
    self.navigationItem.titleView = titleLa;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    [self conficlearInstallAppInfopKey];
    
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

- (void)conficlearInstallAppInfopKey
{
    NSString *pubId = @"a7fpmwda";
//    NSString *pubId = @"";
//    [PluginHelperOC initPluginWithAppKey:AppKey withPubId:pubId isPortrait:YES completionHandler:^(BOOL completion) {
//        
//    }];

    NSArray *admobTestIds = [NSArray arrayWithObjects:
                             @"a34b9c2d9dad3de759060a33811e178c",//jia yan ni
                             @"ea6ced524c5db61789e13c25b2f1a817",//iphone4
                             @"970723dd0a9f3ab1be00ad9a907e5fdc",//zhangjun ipod touch
                             @"533cf28ac06869d3f24affa866cbef36",//zexian ipad
                             @"e2256b177570d5a37d80242ad31e9507",//hing
                             @"4da63b340e0836abddca8ec92e8f98a8",//yeahf
                             @"5e9e0aca336b2ecb77fa11768ca49546",//xiaowen ipod touch
                             @"22da11a7a0e0b119469db9052fa6a832",//ipod touch 02
                             @"7d5c08662747fb3cd81662bc71552f8b"//liuyaqiang
                             , nil];
    NSArray *facebookTestIds = [NSArray arrayWithObjects:
                                @"602c3b96c6b03ced3ba4b8fc0a5d76905fc6e029",//jia yan ni
                                @"0f8e7edeac9f030c11d12a2a0f36b7c63172bfc3",//iphone4
                                @"d4510c33f858bee1f70fb59bb8797bfecd74287a",//zhangjun ipod touch
                                @"7e2c9f0c2a94768ee925fd67e82deb829e9dee05",//zexian ipad
                                @"675496282b0cb1d229fbe78b89d0c12f991a4d1d",//hing
                                @"5c9b918525e5e336c2f011d1d0d64a480604eb41",//yeahf
                                @"2be66ebfa88c787a2c9ae66102525914f4897b5d",//xiaowen ipod touch
                                @"e2137a0ba3004ddf5f7dcc70e96311ed75cc066e",//ipod touch 02
                                @"abe220b17203ee2db464efcf6775138a06b9a476"//liuyaqiang
                                , nil];

//    [PluginHelperOC setFacebookTestId:@[@"abe220b17203ee2db464efcf6775138a06b9a476"]];
    [PluginHelperOC setAdmobTestId:admobTestIds];
    [PluginHelperOC setFacebookTestId:facebookTestIds];
    [PluginHelperOC setScaleEnable:YES];
    [PluginHelperOC setIconScaleEnable:YES];
    [PluginHelperOC enableNativeColor:YES];
    [PluginHelperOC setIcon:CGRectMake(100, 70, 96, 96)];
    [PluginHelperOC setAutoRotate:YES];
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
        NSString *vt = [PluginHelperOC hasVideoOrTaskWithPage:PAGE];
        if ([vt isEqualToString:@"video"]) {
            [PluginHelperOC showVideoWithPage:PAGE withEntry:@"" completionHandler:^(BOOL completrion) {
            }];
        } else if ([vt isEqualToString:@"task"]){
            [PluginHelperOC showTaskWithPage:PAGE];
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

/*Indicates that the interstitial is ready to be shown */
- (void)interstitialDidFinishLoading:(IMInterstitial *)interstitial {
    NSLog(@"interstitialDidFinishLoading");
    [self.interstitialaa showFromViewController:self withAnimation:kIMInterstitialAnimationTypeCoverVertical];

}
/* Indicates that the interstitial has failed to receive an ad. */
- (void)interstitial:(IMInterstitial *)interstitial didFailToLoadWithError:(IMRequestStatus *)error {
    NSLog(@"Interstitial failed to load ad");
    NSLog(@"Error : %@",error.description);
}
/* Indicates that the interstitial has failed to present itself. */
- (void)interstitial:(IMInterstitial *)interstitial didFailToPresentWithError:(IMRequestStatus *)error {
    NSLog(@"Interstitial didFailToPresentWithError");
    NSLog(@"Error : %@",error.description);
}
/* indicates that the interstitial is going to present itself. */
- (void)interstitialWillPresent:(IMInterstitial *)interstitial {
    NSLog(@"interstitialWillPresent");
}
/* Indicates that the interstitial has presented itself */
- (void)interstitialDidPresent:(IMInterstitial *)interstitial {
    NSLog(@"interstitialDidPresent");
}
/* Indicates that the interstitial is going to dismiss itself. */
- (void)interstitialWillDismiss:(IMInterstitial *)interstitial {
    NSLog(@"interstitialWillDismiss");
}
/* Indicates that the interstitial has dismissed itself. */
- (void)interstitialDidDismiss:(IMInterstitial *)interstitial {
    NSLog(@"interstitialDidDismiss");
}
/* Indicates that the user will leave the app. */
- (void)userWillLeaveApplicationFromInterstitial:(IMInterstitial *)interstitial {
    NSLog(@"userWillLeaveApplicationFromInterstitial");
}
/* Indicates that a reward action is completed */
- (void)interstitial:(IMInterstitial *)interstitial rewardActionCompletedWithRewards:(NSDictionary *)rewards {
    NSLog(@"rewardActionCompletedWithRewards");
}
/* interstitial:didInteractWithParams: Indicates that the interstitial was interacted with. */
- (void)interstitial:(IMInterstitial *)interstitial didInteractWithParams:(NSDictionary *)params {
    NSLog(@"InterstitialDidInteractWithParams");
}
/*Not used for direct integration. Notifies the delegate that the ad server has returned an ad but assets are not yet available. */
- (void)interstitialDidReceiveAd:(IMInterstitial *)interstitial {
    NSLog(@"interstitialDidReceiveAd");
}

@end
