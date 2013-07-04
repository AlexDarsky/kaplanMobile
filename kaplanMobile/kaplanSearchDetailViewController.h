//
//  kaplanSearchDetailViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-7-4.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kaplanSearchDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *listArray;
}
+(kaplanSearchDetailViewController*)sharekaplanSearchDetailViewController;
@property (strong, nonatomic) IBOutlet UIView *CustomNavBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *schoolCN;
@property (strong, nonatomic) IBOutlet UILabel *schoolEN;
@property (strong, nonatomic) IBOutlet UIView *shareView;
-(void)loadSchoolAllClass:(NSString*)schoolName;
@end
