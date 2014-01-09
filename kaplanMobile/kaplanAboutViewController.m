//
//  kaplanAboutViewController.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanAboutViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "JSONKit.h"
#import "kaplanServerHelper.h"
@interface kaplanAboutViewController ()

@end

@implementation kaplanAboutViewController
static kaplanAboutViewController *sharekaplanAboutViewController=nil;
@synthesize CustomNavBar;
@synthesize webView;

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
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_inside"]];
    self.CustomNavBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
    [self.CustomNavBar layer].shadowPath =[UIBezierPath bezierPathWithRect:self.CustomNavBar.bounds].CGPath;
    self.CustomNavBar.layer.shadowColor=[[UIColor blackColor] CGColor];
    self.CustomNavBar.layer.shadowOffset=CGSizeMake(0,0);
    self.CustomNavBar.layer.shadowRadius=10.0;
    self.CustomNavBar.layer.shadowOpacity=1.0;
    kaplanServerHelper *serverHelper=[kaplanServerHelper sharekaplanServerHelper];
    if ([serverHelper connectedToNetwork]) {
        NSString *urlString =[NSString stringWithFormat:@"http://kaplan.douho.net/ajax/Info.aspx?action=Detail&id=1700&app=0"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"GET"];
        
        NSHTTPURLResponse* urlResponse = nil;
        NSError *error = [[NSError alloc] init];
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        NSMutableString *responseString=[[NSMutableString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSString *JSONString = [responseString substringWithRange:NSMakeRange(1, responseString.length-2)];
        NSData* jsonData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *resultsDictionary = [jsonData objectFromJSONData];
        [self.webView loadHTMLString:[resultsDictionary objectForKey:@"newsText"] baseURL:nil];
        for (UIView *subView in [self.webView  subviews]) {
            if ([subView isKindOfClass:[UIScrollView class]]) {
                for (UIView *shadowView in [subView subviews]) {
                    if ([shadowView isKindOfClass:[UIImageView class]]) {
                        shadowView.hidden = YES;
                    }
                }
            }
        }

    }
    
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
