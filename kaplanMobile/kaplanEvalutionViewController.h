//
//  kaplanEvalutionViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "kaplanEvalutionChildViewController.h"
@interface kaplanEvalutionViewController : UIViewController
{
    kaplanEvalutionChildViewController *evalutionChildViewController;
}

@property(strong) id evalutionDelgate;
@property (strong, nonatomic) IBOutlet UIView *CustomNavBar;
@property (strong, nonatomic) IBOutlet UIButton *ChoiceCityBtn;
@property (strong, nonatomic) IBOutlet UIButton *ChoiceEducationBtn;
@property (strong, nonatomic) IBOutlet UIButton *ChoiceCountryBtn;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *userEmail;
@property (strong, nonatomic) IBOutlet UITextField *userNumber;

- (IBAction)goToChildViewCon:(id)sender;
-(void)setCity:(NSString*)city;
-(void)setEducation:(NSString*)education;
-(void)setDestination:(NSString*)destination;
@end
