//
//  kaplanNewsListChildViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-22.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMenuBar.h"
#import "WXApi.h"
#import "WXApiObject.h"
@protocol sendMsgToWeChatViewDelegate <NSObject>
- (void) sendMusicContent ;
- (void) sendVideoContent ;
- (void) changeScene:(NSInteger)scene;
@end

@interface kaplanNewsListChildViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIMenuBarDelegate,WXApiDelegate,sendMsgToWeChatViewDelegate>
{
    NSMutableArray *listArray;
    UIMenuBar *menuBar;
    enum WXScene _scene;
}
@property (strong, nonatomic) IBOutlet UIView *CustomNavBar;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UILabel *newsTitleLabel;
@property (strong, nonatomic) UIWebView *newsWebView;
@property (strong, nonatomic) NSString  *newsImageURL;
@property (strong, nonatomic) IBOutlet UIView *shareView;
@property (nonatomic, assign) id<sendMsgToWeChatViewDelegate> delegate;
+(kaplanNewsListChildViewController*)sharekaplanNewsListChildViewController;
-(void)reloadNewInfomation:(NSString*)title text:(NSString*)newText andImage:(NSString*)newsImage;
-(void)reloadNewInfomationByID:(NSString *)newID;
@end
