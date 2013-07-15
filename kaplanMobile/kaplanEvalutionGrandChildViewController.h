//
//  kaplanEvalutionGrandChildViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-7-3.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "kaplanEvalutionChildViewController.h"

@interface kaplanEvalutionGrandChildViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *nameArray;
    NSMutableArray *IDArray;
}
+(kaplanEvalutionGrandChildViewController*)sharekaplanEvalutionGrandChildViewController;
@property (strong) id evalutionGrandChildDelegate;
@property (strong, nonatomic) IBOutlet UIView *grabdChildCustomNavBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(void)reloadListBySubId:(NSString*)targetID;

@end
