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
@property (strong, nonatomic) UITextView *newsTextView;
@property (strong, nonatomic) UIImage *newsImageView;
+(kaplanNewsListChildViewController*)sharekaplanNewsListChildViewController;
-(void)reloadNewInfomation:(NSString*)title text:(NSString*)newText andImage:(UIImage*)newsImage;

@end
