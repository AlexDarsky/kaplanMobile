//
//  kaplanMingXiaoDetailPlanViewController.h
//  kaplanMobile
//
//  Created by linchuan on 6/21/13.
//  Copyright (c) 2013 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kaplanMingXiaoDetailPlanViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *CustomNavBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *ShareView;
@property (strong, nonatomic) NSString *schoolNameCN;
@property (strong, nonatomic) NSString *schoolNameEN;
@property (strong, nonatomic) NSString *schoolTextView;
@property (strong, nonatomic) NSString *schoolIconImage;

-(void)reloadSchoolDetail:(NSString*)schoolCN withEN:(NSString*)schoolEN withDes:(NSString*)description withIcon:(UIImage*)schoolIcon;
@end
