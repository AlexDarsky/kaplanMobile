//
//  kaplanEvalutionViewController.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanEvalutionViewController.h"
#import "kaplanViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface kaplanEvalutionViewController ()

@end

@implementation kaplanEvalutionViewController
@synthesize CustomNavBar;
@synthesize evalutionDelgate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_inside"]];
        CustomNavBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
        [self.CustomNavBar layer].shadowPath =[UIBezierPath bezierPathWithRect:self.CustomNavBar.bounds].CGPath;
        self.CustomNavBar.layer.anchorPoint=CGPointMake(0.5, 0.5);
        self.CustomNavBar.layer.shadowColor=[[UIColor blackColor] CGColor];
        self.CustomNavBar.layer.shadowOffset=CGSizeMake(0,0);
        self.CustomNavBar.layer.shadowRadius=10.0;
        self.CustomNavBar.layer.shadowOpacity=1.0;
        
    }
    return self;
}
- (IBAction)backToMainView:(id)sender {
    [evalutionDelgate showBackView:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    evalutionChildViewController=[[kaplanEvalutionChildViewController alloc] initWithNibName:@"kaplanEvalutionChildViewController" bundle:nil];
    evalutionChildViewController.evalutionChildDelegate=self;

}
- (IBAction)goToChildViewCon:(id)sender
{
    switch ([sender tag]) {
        case 0:
        {
            [self.navigationController pushViewController:evalutionChildViewController animated:YES];
            [evalutionChildViewController reloadListForMode:0];
        }
            break;
        case 1:
        {

            [self.navigationController pushViewController:evalutionChildViewController animated:YES];
            [evalutionChildViewController reloadListForMode:1];
        }
            break;
        case 2:
        {
      
            [self.navigationController pushViewController:evalutionChildViewController animated:YES];
            [evalutionChildViewController reloadListForMode:2];

        }
            break;

    }
}
-(void)setCity:(NSString*)city
{
    [self.ChoiceCityBtn.titleLabel setText:city];
}
-(void)setEducation:(NSString*)education
{
    [self.ChoiceEducationBtn.titleLabel setText:education];
}
-(void)setDestination:(NSString*)destination
{
    [self.ChoiceCountryBtn.titleLabel setText:destination];
}
- (IBAction)submitEvalution:(id)sender
{
    NSString *submitString=[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@",self.ChoiceCityBtn.titleLabel.text,self.ChoiceEducationBtn.titleLabel.text,self.ChoiceCountryBtn.titleLabel.text,self.userName.text,self.userEmail.text,self.userNumber.text];
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"submit message" message:submitString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setChoiceCityBtn:nil];
    [self setChoiceEducationBtn:nil];
    [self setChoiceCountryBtn:nil];
    [self setUserName:nil];
    [self setUserEmail:nil];
    [self setUserNumber:nil];
    [super viewDidUnload];
}
@end
