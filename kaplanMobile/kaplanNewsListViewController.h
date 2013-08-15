//
//  kaplanNewsListViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "kaplanEvalutionChildViewController.h"
#import "kaplanNewsListChildViewController.h"


@interface kaplanNewsListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *newsidArray;
    NSMutableArray *newsTitleArray;
    NSMutableArray *newsPreArray;
    NSMutableArray *newsImageArray;
    int currentPage;

}

@property (strong) id NewsListDelegate;
@property (strong, nonatomic) IBOutlet UIView *CustomNavBar;
@property (strong, nonatomic) IBOutlet UITableView *NewsTableView;
@property (strong, nonatomic) kaplanNewsListChildViewController *newsListChildViewController;


@end
