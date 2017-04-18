//
//  YFSettingViewController.m
//  yifanDemo
//
//  Created by liuyaqiang on 2017/4/18.
//  Copyright © 2017年 yifan. All rights reserved.
//

#import "YFSettingViewController.h"
#import "MBProgressHUD+EV.h"

@interface YFSettingViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *vungleMSwitch;
@property (weak, nonatomic) IBOutlet UILabel *vungleModeLa;
@end

@implementation YFSettingViewController
- (IBAction)switchVungleMode:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:@"vungleMode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.vungleModeLa.text = sender.isOn ? @"isVungelInterstitialMode" : @"isVungleVideoMode";
    [self.view showHUDWithTitle:@"注意" detail:@"请重启app，从新加载数据，似vugle切换有效" duration:3];
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
    [self.vungleMSwitch setOn:[[NSUserDefaults standardUserDefaults]boolForKey:@"vungleMode"]];
    self.vungleModeLa.text = self.vungleMSwitch.isOn ? @"isVungelInterstitialMode" : @"isVungleVideoMode";
}



@end
