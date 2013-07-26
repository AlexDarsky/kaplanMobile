//
//  kaplanAppDelegate.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanAppDelegate.h"
#import "SinaWeibo.h"
#import "kaplanServerHelper.h"
#import "kaplanViewController.h"
#import "kaplanSinaWeiBodelgate.h"
#define kAppKey             @"617965168"
#define kAppSecret          @"5ada0566dcd11a1ff3223e19091ec841"
#define kAppRedirectURI     @"https://api.weibo.com/oauth2/default.html"

@implementation kaplanAppDelegate
@synthesize kaplanViewCon;
@synthesize sinaweibo;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //新浪617965168
   //微信wx1c4c6e7d7a2b99a6
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"dbVerID"]==nil||![[[NSUserDefaults standardUserDefaults] objectForKey:@"dbVerID"]isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"dbVerID"];
    };
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"appVersion"]==nil||![[[NSUserDefaults standardUserDefaults] objectForKey:@"appVersion"]isEqualToString:@"1.1"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1.1" forKey:@"appVersion"];
    };
        if ([[UIScreen mainScreen] bounds].size.height>480.00) {
        NSLog(@"the Device size is 这是四寸屏");
       kaplanViewCon = [[kaplanViewController alloc] initWithNibName:@"kaplanViewController_4" bundle:nil];
        
    }
    else{
        NSLog(@"the Device size is 这是3.5寸屏");
        kaplanViewCon = [[kaplanViewController alloc] initWithNibName:@"kaplanViewController" bundle:nil];

    }
    self.window.rootViewController = self.kaplanViewCon;
    [self.window makeKeyAndVisible];
    [WXApi registerApp:@"wx1c4c6e7d7a2b99a6"];
    kaplanSinaWeiBodelgate *sinaWeiBodelgate=[kaplanSinaWeiBodelgate sharekaplanSinaWeiBodelgate];
    sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:sinaWeiBodelgate];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] &&
        [sinaweiboInfo objectForKey:@"UserIDKey"]) {
        sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"]; sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"]; sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([sourceApplication isEqualToString:@"com.sina.weibo"]) {
        NSLog(@"sina!!!");
    return [self.sinaweibo handleOpenURL:url];
    }else
    return  [WXApi handleOpenURL:url delegate:self];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self.sinaweibo applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    NSLog(@"My token is:%@", token);
    kaplanServerHelper *serverHelper=[kaplanServerHelper sharekaplanServerHelper];
    [serverHelper sendDeviceTokenToServer:token];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"Failed to get token, error:%@", error_str);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"didReceiveRemoteNotification");
    //NSLog(@"%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
   [self.kaplanViewCon dealWithRemoteNotification:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]];
    
}
@end
