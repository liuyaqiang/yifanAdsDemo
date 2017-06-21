//
//  AppDelegate.m
//  yifanDemo
//
//  Created by liuyaqiang on 2017/2/22.
//  Copyright © 2017年 yifan. All rights reserved.
//

#import "AppDelegate.h"
#import "PluginSDK/PluginHelperOC.h"
#import "YFCommonHeader.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSString *pubId = @"a7fpmwda";

    //[application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    [self configPlugin];
    
    [PluginHelperOC InitPluginWithAppKey:AppKey withPubId:pubId bannerLocation:Bottom isPortrait:YES isDebug:YES];
    [PluginHelperOC setPushEnable:YES];
    [PluginHelperOC showBanner];

//    }];
    [PluginHelperOC setPostionOfLandscapeInPortraitMode:Bottom];
    [PluginHelperOC setIcon:CGRectMake(100, 70, 96, 96)];

    [PluginHelperOC showInterstitialWithPage:@"home" withEntry:@"" shownHandler:^(){
        
    } completionHandler:^(BOOL isClosed) {
        
    }];
//    [PluginHelperOC setPostionOfLandscapeInPortraitMode:Left];
    
    [PluginHelperOC exeActiveTaskReward:^(NSString *reward) {
        NSLog(@"123<>>><<><<><>><<><><>><<>><%@",reward);
    }];
    return YES;
}
- (void)configPlugin
{    
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
    [PluginHelperOC setupViewDebug:YES];
    NSString *level = LEVEL;
    [PluginHelperOC setLevel:level];
    
    [PluginHelperOC setAdmobTestId:admobTestIds];
    [PluginHelperOC setFacebookTestId:facebookTestIds];
    [PluginHelperOC setScaleEnable:YES];
    [PluginHelperOC setIconScaleEnable:YES];
    [PluginHelperOC enableNativeColor:YES];
    //[PluginHelperOC setIcon:CGRectMake(100, 70, 96, 96)];
    //[PluginHelperOC setAutoRotate:YES];

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [PluginHelperOC showInterstitialWithPage:@"switchin" withEntry:@"" shownHandler:^(){
        
    } completionHandler:^(BOOL isClosed) {
        
    }];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
