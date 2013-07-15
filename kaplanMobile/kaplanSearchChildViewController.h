//
//  kaplanSearchChildViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-7-4.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kaplanSearchChildViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
  NSMutableArray *specialitiesList;
  NSMutableArray *degreeList;
   NSMutableArray *schoolList;
    int loadResource;
}
+(kaplanSearchChildViewController*)sharekaplanSearchChildViewController;
-(void)loadResource:(int)resourceID;
@property (strong)id SearchChildDelegate;
@property (strong, nonatomic) IBOutlet UIView *CustonNavBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
