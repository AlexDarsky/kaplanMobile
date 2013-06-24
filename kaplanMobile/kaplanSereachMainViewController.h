//
//  kaplanSereachMainViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kaplanSereachMainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *schoolNameCN;
    NSMutableArray *schoolNameEN;
    int searchMode;
}

@property (strong) id SereachDelegate;
@property (strong, nonatomic) IBOutlet UIView *CustomNavBar;
@property (strong, nonatomic) IBOutlet UIView *SearchView;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn2;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn1;
@property (retain, nonatomic) IBOutlet UITableView *DisplayTableView;
@property (strong, nonatomic) IBOutlet UITextField *SearchTextField;

@end
