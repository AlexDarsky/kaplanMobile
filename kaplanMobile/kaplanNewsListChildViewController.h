//
//  kaplanNewsListChildViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-22.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kaplanNewsListChildViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property (strong, nonatomic) IBOutlet UIView *CustomNavBar;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UILabel *newsTitleLabel;
@property (strong, nonatomic) UIWebView *newsWebView;
@property (strong, nonatomic) NSString  *newsImageURL;
+(kaplanNewsListChildViewController*)sharekaplanNewsListChildViewController;
-(void)reloadNewInfomation:(NSString*)title text:(NSString*)newText andImage:(NSString*)newsImage;
-(void)reloadNewInfomationByID:(NSString *)newID;
@end
