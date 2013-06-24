//
//  kaplanEvalutionChildViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kaplanEvalutionChildViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *cityArray;
    NSMutableArray *educationArray;
    NSMutableArray *destinationArray;
    int selectMode;
}
@property (strong) id evalutionChildDelegate;
@property (strong, nonatomic) IBOutlet UIView *childCustomNavBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *modeLabel;

-(void)reloadListForMode:(int)targetMode;
@end
