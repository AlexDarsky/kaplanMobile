//
//  kaplanSettingViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-25.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "kaplanAboutViewController.h"

@interface kaplanSettingViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *CustomNavBar;
@property (strong)id settingDelegate;
@property (weak, nonatomic) IBOutlet UIButton *checkDataBase;
@property (weak, nonatomic) IBOutlet UIButton *updateAppBtn;
@property (strong, nonatomic) IBOutlet UIButton *testButton;

@property (strong,nonatomic) kaplanAboutViewController *aboutViewController;
@property (strong, nonatomic) IBOutlet UILabel *appVersion;
@property (strong, nonatomic) IBOutlet UILabel *dbVerID;

-(IBAction)pushToAboutUS:(id)sender;
- (IBAction)updateDataBase:(id)sender;
@end
