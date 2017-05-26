//
//  MBProgressHUD+EV.m
//  EVClub
//
//  Created by LiJieming on 15/1/29.
//  Copyright (c) 2015年 BitRice. All rights reserved.
//

#import <objc/runtime.h>

#import "MBProgressHUD+EV.h"

@implementation MBProgressHUD (EV)

+ (instancetype)showHUDAddedTo:(UIView *)view duration:(NSTimeInterval)showTime animated:(BOOL)animated {
    BOOL existHUD = [MBProgressHUD HUDForView:view] != nil;
    if (existHUD) {
        // 如果有HUD先隐藏掉，保证始终只有一个HUD
        [MBProgressHUD hideAllHUDsForView:view animated:NO];
        
        // 如果有HUD，则不做animation
        animated = NO;
    }
    
    id showView = [self showHUDAddedTo:view animated:animated];
    
    if (showTime != HUD_Duration_Infinite) {
        __weak __typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(showTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __weak __typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf hideHUDForView:view animated:animated];
        });
    }
    return showView;
}

+ (instancetype)showHUDAddedTo:(UIView *)view duration:(NSTimeInterval)showTime withText:(NSString *)text animated:(BOOL)animated {
    id showView = [self showHUDAddedTo:view duration:showTime animated:animated];
    [MBProgressHUD HUDForView:view].userInteractionEnabled = NO;
    [MBProgressHUD HUDForView:view].mode = MBProgressHUDModeText;
    [MBProgressHUD HUDForView:view].labelText = text;
    return showView;
}


+ (instancetype)showHUDAddedTo:(UIView *)view icon:(UIImage *)image duration:(NSTimeInterval)showTime withText:(NSString *)text animated:(BOOL)animated {
    id showView = [self showHUDAddedTo:view duration:showTime animated:animated];
    [MBProgressHUD HUDForView:view].userInteractionEnabled = NO;
    [MBProgressHUD HUDForView:view].mode = MBProgressHUDModeCustomView;
    
    return showView;
}
@end

static const CGFloat minHUDWidth = 0.0;
@implementation UIViewController (HUD)

#pragma mark MBProgressHUD快捷方法
- (MBProgressHUD *)showWaitHUD
{
    return [self showWaitHUDWithTitle:@"@"""];
}
- (MBProgressHUD *)showWaitHUDWithTitle:(NSString*)title
{
    MBProgressHUD *HUD = [self showHUDWithTitle:title duration:HUD_Duration_Infinite];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.userInteractionEnabled = YES;
    return HUD;
}
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title
{
    return [self showHUDWithTitle:title duration:HUD_Duration_Normal];
}
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title detail:(NSString *)detail
{
    return [self showHUDWithTitle:title detail:detail duration:HUD_Duration_Normal];
}
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    return [self showHUDWithTitle:@"" detail:title duration:duration];
}
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title detail:(NSString *)detail duration:(NSTimeInterval)duration
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[self HUDContainerView] duration:duration withText:title animated:YES];
    HUD.detailsLabelText = detail;
    [self setHUDBelowNavigationBar];
    
    // 设置 minWidth
    HUD.minSize = CGSizeMake(minHUDWidth, 0.0);
    
    return HUD;
}
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title detail:(NSString *)detail topIcon:(UIImage*)iconImage duration:(NSTimeInterval)duration
{
    MBProgressHUD *HUD = [self showHUDWithTitle:title detail:detail duration:duration];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[UIImageView alloc] initWithImage:iconImage];
    return HUD;
}


- (void)hideHUD
{
    [MBProgressHUD hideAllHUDsForView:[self HUDContainerView] animated:YES];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (MBProgressHUD *)currentHUD {
    return [MBProgressHUD HUDForView:[self HUDContainerView]];
}

- (NSArray *)currentHUDs {
    return [MBProgressHUD allHUDsForView:[self HUDContainerView]];
}

- (void)setHUDContainerView:(UIView *)HUDContainerView {
    objc_setAssociatedObject(self, @selector(HUDContainerView), HUDContainerView, OBJC_ASSOCIATION_ASSIGN);
}

- (UIView *)HUDContainerView {
    if (self.isViewLoaded) {
        UIView *containerView = objc_getAssociatedObject(self, _cmd);
        
        if (containerView != nil) {
            return containerView;
        }
        else {
            if (self.parentViewController != nil &&
                self.parentViewController != self.navigationController) {
                return self.parentViewController.HUDContainerView;
            }
            else if (self.navigationController.parentViewController != nil &&
                     self.navigationController.parentViewController != self.tabBarController) {
                return self.navigationController.parentViewController.HUDContainerView;
            }
            else {
                return self.view;
            }
        }
    }
    else {
        return nil;
    }
}

/**
 *  将HUD置于NavigationBar之下
 */
- (void)setHUDBelowNavigationBar {
    if (self.navigationController.view == [self HUDContainerView]) {
        [self.navigationController.view insertSubview:[MBProgressHUD HUDForView:self.navigationController.view] belowSubview:self.navigationController.navigationBar];
    }
}


@end

@implementation UIView (HUD)

- (MBProgressHUD *)showWaitHUD
{
    return [self showWaitHUDWithTitle:@"@"""];
}

- (MBProgressHUD *)showWaitHUDWithTitle:(NSString*)title
{
    MBProgressHUD *HUD = [self showHUDWithTitle:title duration:HUD_Duration_Infinite];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.userInteractionEnabled = YES;
    return HUD;
}

- (MBProgressHUD *)showHUDWithTitle:(NSString *)title
{
    return [self showHUDWithTitle:title duration:HUD_Duration_Normal];
}

- (MBProgressHUD *)showHUDWithTitle:(NSString *)title detail:(NSString *)detail
{
    return [self showHUDWithTitle:title detail:detail duration:HUD_Duration_Normal];
}

- (MBProgressHUD *)showHUDWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    return [self showHUDWithTitle:title detail:@"" duration:duration];
}

- (MBProgressHUD*)showHUDWithTitle:(NSString *)title detail:(NSString *)detail duration:(NSTimeInterval)duration {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self duration:duration withText:title animated:YES];
    HUD.detailsLabelText = detail;
    return HUD;
}
//
//- (MBProgressHUD *)showHUDWithTitle:(NSString *)title error:(NSError *)error {
//    if (![error isKindOfClass:[NSError class]]) {
//        return [self showHUDWithTitle:@"网络异常" detail:@"请检查网络连接或重试"];
//    }
//    else if ([error isNetworkError]) {
//        return [self showHUDWithTitle:@"网络异常" detail:@"请检查网络连接或重试"];
//    }
//    else {
//        if (error.revCode == EVRevCodeAccoutExpired ||
//            error.code == kCFURLErrorCancelled) {
//            return nil;
//        }
//        else {
//            NSString *errorDetail = [error errorMessage];
//            return [self showHUDWithTitle:title detail:errorDetail];
//        }
//    }
//}

- (MBProgressHUD*)showHUDWithTitle:(NSString *)title detail:(NSString *)detail icon:(UIImage *)iconImage duration:(NSTimeInterval)duration {
    MBProgressHUD *HUD = [self showHUDWithTitle:title detail:detail duration:duration];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[UIImageView alloc] initWithImage:iconImage];
    return HUD;
}

- (void)hideHUD {
    [MBProgressHUD hideAllHUDsForView:self animated:YES];

}

- (MBProgressHUD *)currentHUD {
    return [MBProgressHUD HUDForView:self];
}

@end
