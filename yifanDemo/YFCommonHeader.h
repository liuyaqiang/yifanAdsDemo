//
//  YFCommonHeader.h
//  yifanDemo
//
//  Created by liuyaqiang on 2017/4/19.
//  Copyright © 2017年 yifan. All rights reserved.
//

#ifndef YFCommonHeader_h
#define YFCommonHeader_h

//#define YF_AppKey @"a6ivlpeyyxvcjamkkdtbwf0z"
//#define YF_AppKey @"a6ivlpeytjduawrkyya4vxh9"
#define YF_AppKey  @"a6ivlpey0w8znoplqsub6stw"

#define AppKey [[NSUserDefaults standardUserDefaults]stringForKey:@"default_appkey"].length ?[[NSUserDefaults standardUserDefaults]stringForKey:@"default_appkey"]  : YF_AppKey

#define YF_PAGE @"main"

#define PAGE [[NSUserDefaults standardUserDefaults]stringForKey:@"default_page"].length ?[[NSUserDefaults standardUserDefaults]stringForKey:@"default_page"]  : YF_PAGE

#define YF_LEVEL @"0"

#define LEVEL [[NSUserDefaults standardUserDefaults]stringForKey:@"default_level"].length ?[[NSUserDefaults standardUserDefaults]stringForKey:@"default_level"]  : YF_LEVEL




#define NS_DEFAULT_VUNGLE_MODE  @"default_vungleMode"
#define NS_DEFAULT_LOG  @"config_log_debug"
#define NS_DEFAULT_APPKEY @"default_appkey"
#define NS_DEFAULT_PAGE @"default_page"
#define NS_DEFAULT_LEVEL @"default_level"

#endif /* YFCommonHeader_h */
