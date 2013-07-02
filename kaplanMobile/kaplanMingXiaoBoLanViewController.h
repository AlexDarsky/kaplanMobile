//
//  kaplanMingXiaoBoLanViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "kaplanMingXiaoDetailPlanViewController.h"

@interface kaplanMingXiaoBoLanViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *schoolsArrayCH;
    NSMutableArray *schoolArrayEN;
    NSMutableArray *schoolIDArray;

}
@property (strong) id MingXiaoBoLanDelegate;
@property (strong, nonatomic) IBOutlet UIView *CustomNavBar;
@property (nonatomic,strong) IBOutlet UITableView *schoolsTableView;
@property (strong, nonatomic) IBOutlet UIView *SearchView;
@property (strong, nonatomic) IBOutlet UITextField *SearchTextField;

+(kaplanMingXiaoBoLanViewController*)sharekaplanMingXiaoBoLanViewController;
@end
