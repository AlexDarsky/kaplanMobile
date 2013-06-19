//
//  kaplanViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kaplanViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property (strong, nonatomic) IBOutlet UIView *MainView;
@property (strong, nonatomic) IBOutlet UITableView *NavBackTableView;
@property (strong, nonatomic) IBOutlet UIScrollView *NewsScrollView;

@end
