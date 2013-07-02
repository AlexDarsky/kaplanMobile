//
//  kaplanSettingViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-25.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kaplanSettingViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *CustomNavBar;
@property (strong)id settingDelegate;
@property (weak, nonatomic) IBOutlet UIButton *checkDataBase;

-(IBAction)pushToAboutUS:(id)sender;
- (IBAction)updateDataBase:(id)sender;
@end
