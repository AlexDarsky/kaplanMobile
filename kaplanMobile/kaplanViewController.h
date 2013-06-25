//
//  kaplanViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideBarSelectedDelegate.h"
#import "DownloadManager.h"
#import "kaplanSettingViewController.h"

@interface kaplanViewController : UIViewController<SideBarSelectDelegate,UIScrollViewDelegate,DownloadManagerDelegate>
{
    UIScrollView *sv;
    UIPageControl *page;
    NSMutableArray *demoArray;
    int TimeNum;
    BOOL Tend;
    DownloadManager *download;
}
@property (strong, nonatomic) IBOutlet UIView *MainView;
@property (strong, nonatomic) IBOutlet UIView *NavBackView;
@property (strong,nonatomic) UITabBarController *tabBarController;
@property (strong,nonatomic) UINavigationController *evalutionNavCon;
@property (strong,nonatomic) UINavigationController *SchoolsViewNavCon;
@property (strong,nonatomic) UINavigationController *NewsViewNavCon;
@property (strong,nonatomic) kaplanSettingViewController *kaplanSettingViewCon;
-(IBAction)showBackView:(id)sender;
@end
