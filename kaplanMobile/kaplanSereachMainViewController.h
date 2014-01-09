//
//  kaplanSereachMainViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "kaplanSearchChildViewController.h"
#import "kaplanSearchDetailViewController.h"


@interface kaplanSereachMainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *schoolNameCN;
    NSMutableArray *schoolNameEN;
    NSMutableArray *schoolsArray;
    NSMutableArray *degreeArray;
    int searchMode;
}

@property (strong) id SereachDelegate;
@property (strong, nonatomic) IBOutlet UIView *CustomNavBar;
@property (strong, nonatomic) IBOutlet UIView *SearchView;
@property (strong, nonatomic) IBOutlet UIView *SearchView2;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn2;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn1;
@property (retain, nonatomic) IBOutlet UITableView *DisplayTableView;
@property (strong, nonatomic) IBOutlet UITextField *SearchTextField;
@property (strong, nonatomic) IBOutlet UIButton *degreedBtn;
@property (strong, nonatomic) IBOutlet UIButton *schoolBtn;
@property (strong, nonatomic) IBOutlet UIButton *classBtn;
@property (strong, nonatomic) kaplanSearchChildViewController *searchChildViewController;
@property (strong, nonatomic) kaplanSearchDetailViewController *searchDetailViewController;
-(void)setText:(NSString*)textString For:(int)mode;
@end
