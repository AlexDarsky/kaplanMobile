//
//  kaplanSettingViewController.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-25.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanSettingViewController.h"
#import "kaplanViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "kaplanAboutViewController.h"
#import "kaplanServerHelper.h"
@interface kaplanSettingViewController ()

@end

@implementation kaplanSettingViewController
@synthesize settingDelegate;
@synthesize checkDataBase;
@synthesize testButton;
@synthesize aboutViewController;
@synthesize appVersion,dbVerID;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_inside.png"]];
        self.CustomNavBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
         [self.CustomNavBar layer].shadowPath =[UIBezierPath bezierPathWithRect:self.CustomNavBar.bounds].CGPath;
        self.CustomNavBar.layer.shadowColor=[[UIColor blackColor] CGColor];
        self.CustomNavBar.layer.shadowOffset=CGSizeMake(0,0);
        self.CustomNavBar.layer.shadowRadius=10.0;
        self.CustomNavBar.layer.shadowOpacity=1.0;
        testButton.hidden=YES;
        

    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES];
    if ([[UIScreen mainScreen] bounds].size.height>480.00)
    {
        aboutViewController=[[kaplanAboutViewController alloc] initWithNibName:@"kaplanAboutViewController_4" bundle:nil];
    }else
    {
        aboutViewController=[[kaplanAboutViewController alloc] initWithNibName:@"kaplanAboutViewController" bundle:nil];
    }
    
    self.dbVerID.text=[NSString stringWithFormat:@"当前数据库版本为：%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"dbVerID"]];
    self.appVersion.text=[NSString stringWithFormat:@"当前客户端版本为：%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appVersion"]];
    

}
- (IBAction)updateDataBase:(id)sender
{
    kaplanServerHelper *serverHelper=[kaplanServerHelper sharekaplanServerHelper];
    [serverHelper updateSQLite];
}
- (IBAction)backToMainView:(id)sender
{
    [settingDelegate showBackView:nil];
}
-(IBAction)pushToAboutUS:(id)sender
{
    [self.navigationController pushViewController:aboutViewController animated:YES];
}
- (IBAction)testDemo:(id)sender
{
    NSString *urlString =[NSString stringWithFormat:@"http://cd.douho.net/ajax/school.aspx?action=Detail&id=49&app=0"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSDictionary *tmpDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    if (tmpDic==nil) {
        NSLog(@"!!!!!!!");
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCustomNavBar:nil];
    [self setCheckDataBase:nil];
    [self setAppVersion:nil];
    [self setAppVersion:nil];
    [self setDbVerID:nil];
    [super viewDidUnload];
}
@end
