//
//  MBProgressHUD+EV.h
//  EVClub
//
//  Created by LiJieming on 15/1/29.
//  Copyright (c) 2015年 BitRice. All rights reserved.
//

#import "MBProgressHUD.h"
#define HUD_Duration_Infinite (-1)
#define HUD_Duration_Normal (1.5)
#define HUD_Duration_Short (0.5)

@interface MBProgressHUD (EV)

+ (instancetype)showHUDAddedTo:(UIView *)view duration:(NSTimeInterval)showTime animated:(BOOL)animated;
+ (instancetype)showHUDAddedTo:(UIView *)view duration:(NSTimeInterval)showTime withText:(NSString *)text animated:(BOOL)animated;
+ (instancetype)showHUDAddedTo:(UIView *)view icon:(UIImage *)image duration:(NSTimeInterval)showTime withText:(NSString *)text animated:(BOOL)animated;
@end

@interface UIViewController (HUD)

@property (nonatomic, weak) UIView *HUDContainerView;

#pragma mark MBProgressHUD快捷方法
- (MBProgressHUD *)showWaitHUD;
- (MBProgressHUD *)showWaitHUDWithTitle:(NSString *)title;
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title;
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title detail:(NSString *)detail;
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title duration:(NSTimeInterval)duration;
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title detail:(NSString *)detail duration:(NSTimeInterval)duration;
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title detail:(NSString *)detail topIcon:(UIImage*)iconImage duration:(NSTimeInterval)duration;
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title error:(NSError *)error;
- (void)hideHUD;

- (MBProgressHUD *)currentHUD;
- (NSArray *)currentHUDs;

- (UIView *)HUDContainerView;
- (void)setHUDBelowNavigationBar;

@end

@interface UIView (HUD)

- (MBProgressHUD *)showWaitHUD;
- (MBProgressHUD *)showWaitHUDWithTitle:(NSString *)title;
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title;
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title detail:(NSString *)detail;
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title duration:(NSTimeInterval)duration;
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title detail:(NSString *)detail duration:(NSTimeInterval)duration;
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title detail:(NSString *)detail icon:(UIImage*)iconImage duration:(NSTimeInterval)duration;
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title error:(NSError *)error;
- (void)hideHUD;

- (MBProgressHUD *)currentHUD;

@end
