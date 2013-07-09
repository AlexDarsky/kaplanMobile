//
//  kaplanSearchDetailViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-7-4.
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
@class SinaWeibo;
@interface kaplanSearchDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIMenuBarDelegate,WXApiDelegate,sendMsgToWeChatViewDelegate>
{
    NSMutableArray *listArray;
    UIMenuBar *menuBar;
    enum WXScene _scene;
}
+(kaplanSearchDetailViewController*)sharekaplanSearchDetailViewController;
@property (strong, nonatomic) IBOutlet UIView *CustomNavBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *schoolCN;
@property (strong, nonatomic) IBOutlet UILabel *schoolEN;
@property (strong, nonatomic) IBOutlet UIView *shareView;
@property (nonatomic, assign) id<sendMsgToWeChatViewDelegate> delegate;
-(void)loadSchoolAllClass:(NSString*)schoolName;
@end
