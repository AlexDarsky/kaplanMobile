//
//  kaplanEvalutionChildViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "kaplanEvalutionGrandChildViewController.h"
@class kaplanEvalutionGrandChildViewController;
@interface kaplanEvalutionChildViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *nameArray;
    NSMutableArray *IDArray;
    int selectMode;
}
@property (strong) id evalutionChildDelegate;
@property (strong, nonatomic) IBOutlet UIView *childCustomNavBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *modeLabel;


-(void)reloadListForMode:(int)targetMode;
-(void)setSubCity:(NSString*)cityName :(NSString*)grandChildID;
@end
