//
//  kaplanEvalutionViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "kaplanEvalutionChildViewController.h"
#import "kaplanEvalutionGrandChildViewController.h"
@interface kaplanEvalutionViewController : UIViewController
{
    kaplanEvalutionChildViewController *evalutionChildViewController;
    int cityID,degreeID,countryID;
}

@property(strong) id evalutionDelgate;
@property (strong, nonatomic) IBOutlet UIView *CustomNavBar;
@property (strong, nonatomic) IBOutlet UIButton *ChoiceCityBtn;
@property (strong, nonatomic) IBOutlet UIButton *ChoiceEducationBtn;
@property (strong, nonatomic) IBOutlet UIButton *ChoiceCountryBtn;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *userEmail;
@property (strong, nonatomic) IBOutlet UITextField *userNumber;
@property (strong, nonatomic) kaplanEvalutionGrandChildViewController *grandChild;

- (IBAction)goToChildViewCon:(id)sender;
-(void)setCity:(NSString*)city andID:(int)idNumber;
-(void)setEducation:(NSString*)education andID:(int)idNumber;
-(void)setDestination:(NSString*)destination andID:(int)idNumber;
@end
