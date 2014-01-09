//
//  kaplanSinaWeiBodelgate.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-7-9.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanSinaWeiBodelgate.h"
#import "kaplanAppDelegate.h"

@implementation kaplanSinaWeiBodelgate
@synthesize SinaWeiBoActionDelagete;
static kaplanSinaWeiBodelgate *sharekaplanSinaWeiBodelgate = nil;
+(kaplanSinaWeiBodelgate*)sharekaplanSinaWeiBodelgate
{
    if (sharekaplanSinaWeiBodelgate == nil) {
        sharekaplanSinaWeiBodelgate = [[super allocWithZone:NULL] init];
    }
    return sharekaplanSinaWeiBodelgate;
}
- (SinaWeibo *)sinaweibo
{
    kaplanAppDelegate *delegate = (kaplanAppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}
-(BOOL)connectToSinaWeiBoWith:(NSDictionary*)dictionary
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    BOOL authValid = sinaweibo.isAuthValid;
    if(authValid)
    {
        [sinaweibo requestWithURL:@"statuses/update.json" params:[NSMutableDictionary dictionaryWithObjectsAndKeys:[dictionary objectForKey:@"title"],@"status", nil] httpMethod:@"POST" delegate:self];
        return YES;
    }else
    {
        [sinaweibo logIn];
        return NO;
    }
}
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"发送失败");
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"发送成功" message:@"提示" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    NSLog(@"%@",result);
    NSLog(@"发送成功");
}
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate);    
}
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo {
    NSLog(@"sinaweiboDidLogOut");
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sinaUser"]!=nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sinaUser"];
    }
}
@end
