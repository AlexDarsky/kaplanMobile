//
//  kaplanAppDelegate.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "SinaWeibo.h"

@class kaplanViewController;
@class SinaWeibo;
@interface kaplanAppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate,SinaWeiboDelegate>
{
        SinaWeibo *sinaweibo;
}
@property (readonly, nonatomic) SinaWeibo *sinaweibo;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) kaplanViewController *kaplanViewCon;


@end
