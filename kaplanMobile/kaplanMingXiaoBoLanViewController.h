//
//  kaplanMingXiaoBoLanViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kaplanMingXiaoBoLanViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *schoolsArray;
}
@property (nonatomic,strong) IBOutlet UITableView *schoolsTableView;
@end
