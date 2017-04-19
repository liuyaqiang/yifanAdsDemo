//
//  YFSettingViewController.m
//  yifanDemo
//
//  Created by liuyaqiang on 2017/4/18.
//  Copyright © 2017年 yifan. All rights reserved.
//

#import "YFSettingViewController.h"
#import "MBProgressHUD+EV.h"
#import "YFCommonHeader.h"
@interface YFSettingViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *vungleMSwitch;
@property (weak, nonatomic) IBOutlet UILabel *vungleModeLa;
@property (weak, nonatomic) IBOutlet UISwitch *logSwitch;
@end

@implementation YFSettingViewController
- (IBAction)switchVungleMode:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:NS_DEFAULT_VUNGLE_MODE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.vungleModeLa.text = sender.isOn ? @"isVungelInterstitialMode" : @"isVungleVideoMode";
    [self.view showHUDWithTitle:@"注意" detail:@"请重启app，从新加载数据，使vungle切换有效" duration:3];
}
- (IBAction)switchLog:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:NS_DEFAULT_LOG];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self.view showHUDWithTitle:@"注意" detail:@"log状态改变，重启app，切换有效" duration:3];
}
- (IBAction)dismissCtl:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    //vungleSwitch
    [self.vungleMSwitch setOn:[[NSUserDefaults standardUserDefaults]boolForKey:NS_DEFAULT_VUNGLE_MODE]];
    self.vungleModeLa.text = self.vungleMSwitch.isOn ? @"isVungelInterstitialMode" : @"isVungleVideoMode";
    //logSwitch
    [self.logSwitch setOn:[[NSUserDefaults standardUserDefaults]boolForKey:NS_DEFAULT_LOG]];
}



@end
