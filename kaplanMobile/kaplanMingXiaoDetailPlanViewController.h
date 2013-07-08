//
//  kaplanMingXiaoDetailPlanViewController.h
//  kaplanMobile
//
//  Created by linchuan on 6/21/13.
//  Copyright (c) 2013 AlexZhu. All rights reserved.
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
@interface kaplanMingXiaoDetailPlanViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIMenuBarDelegate,WXApiDelegate,sendMsgToWeChatViewDelegate>
{
    UIMenuBar *menuBar;
    enum WXScene _scene;

}
@property (strong, nonatomic) IBOutlet UIView *CustomNavBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *ShareView;
@property (strong, nonatomic) NSString *schoolNameCN;
@property (strong, nonatomic) NSString *schoolNameEN;
@property (strong, nonatomic) NSString *areaName;
@property (strong, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSString *createYear;
@property (strong, nonatomic) NSString *timeRankNo;
@property (strong, nonatomic) NSString *rankInfo;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *poseCode;
@property (strong, nonatomic) NSString *employmentRate;
@property (strong, nonatomic) NSString *webSite;
@property (strong, nonatomic) NSString *schoolTextView;
@property (nonatomic, assign) id<sendMsgToWeChatViewDelegate> delegate;
-(void)reloadSchoolDetail:(NSString*)schoolCN withEN:(NSString*)schoolEN withDes:(NSString*)description withIcon:(UIImage*)schoolIcon;
-(void)reloadSchoolDetail:(NSString*)schoolID;
@end
