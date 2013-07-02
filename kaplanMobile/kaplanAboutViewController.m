//
//  kaplanAboutViewController.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanAboutViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface kaplanAboutViewController ()

@end

@implementation kaplanAboutViewController
static kaplanAboutViewController *sharekaplanAboutViewController=nil;
@synthesize CustomNavBar;

+(kaplanAboutViewController*)sharekaplanAboutViewController
{

        if (sharekaplanAboutViewController == nil) {
            sharekaplanAboutViewController = [[super allocWithZone:NULL] init];
        }
        return sharekaplanAboutViewController;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.CustomNavBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
    [self.CustomNavBar layer].shadowPath =[UIBezierPath bezierPathWithRect:self.CustomNavBar.bounds].CGPath;
    self.CustomNavBar.layer.shadowColor=[[UIColor blackColor] CGColor];
    self.CustomNavBar.layer.shadowOffset=CGSizeMake(0,0);
    self.CustomNavBar.layer.shadowRadius=10.0;
    self.CustomNavBar.layer.shadowOpacity=1.0;
}
- (IBAction)backToParentView:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCustomNavBar:nil];
    [super viewDidUnload];
}
@end
