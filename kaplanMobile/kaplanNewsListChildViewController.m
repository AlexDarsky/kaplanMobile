//
//  kaplanNewsListChildViewController.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-22.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanNewsListChildViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface kaplanNewsListChildViewController ()

@end

@implementation kaplanNewsListChildViewController
static kaplanNewsListChildViewController *sharekaplanNewsListChildViewController = nil;
@synthesize tableView,CustomNavBar;
@synthesize newsTextView,newsTitleLabel,newsImageView;
+(kaplanNewsListChildViewController*)sharekaplanNewsListChildViewController
{
    if (sharekaplanNewsListChildViewController == nil) {
        sharekaplanNewsListChildViewController = [[super allocWithZone:NULL] init];
    }
    return sharekaplanNewsListChildViewController;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_inside"]];
        CustomNavBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
        [self.CustomNavBar layer].shadowPath =[UIBezierPath bezierPathWithRect:self.CustomNavBar.bounds].CGPath;
        self.CustomNavBar.layer.shadowColor=[[UIColor blackColor] CGColor];
        self.CustomNavBar.layer.shadowOffset=CGSizeMake(0,0);
        self.CustomNavBar.layer.shadowRadius=10.0;
        self.CustomNavBar.layer.shadowOpacity=1.0;
        newsTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(60, 10, 200, 20)];
        newsTitleLabel.textColor=[UIColor whiteColor];
        newsTitleLabel.backgroundColor=[UIColor clearColor];
        newsTextView=[[UITextView alloc] init];
        newsTextView.backgroundColor=[UIColor clearColor];
        newsTextView.textColor=[UIColor whiteColor];
        newsImageView=[[UIImage alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


}
-(void)reloadNewInfomation:(NSString*)title text:(NSString*)newText andImage:(UIImage*)newsImage
{
    NSLog(@"will reload");
    [self.newsTitleLabel setText:title];
    [self.newsTextView setText:newText];
    self.newsImageView=newsImage;
    [self.tableView reloadData];
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 62.0;
    }else
    {
        return 381.0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    if (indexPath.row==0)
    {
        UIImageView *iconImg=[[UIImageView alloc] initWithFrame:CGRectMake(40, 10, 15, 15)];
        iconImg.image=[UIImage imageNamed:@"dot"];
        [cell.contentView addSubview:iconImg];
        [cell.contentView addSubview:newsTitleLabel];
        UIImageView *customSeparator=[[UIImageView alloc] initWithFrame:CGRectMake(14, 61, 282, 1)];
        customSeparator.image=[UIImage imageNamed:@"line"];
        [cell.contentView addSubview:customSeparator];
        
    }else
    {
        if (self.newsImageView!=nil) {
            UIImageView *newIV=[[UIImageView alloc] initWithFrame:CGRectMake(60, 10, 235, 131)];
            [newIV setImage:self.newsImageView];
            [cell.contentView addSubview:newIV];
            self.newsTextView.frame=CGRectMake(60, 160, 235, 220);
            [cell.contentView addSubview:self.newsTextView];
            
        }else
        {
            self.newsTextView.frame=CGRectMake(60, 10, 235, 220);
            [cell.contentView addSubview:self.newsTextView];
        }
        UIImageView *customSeparator=[[UIImageView alloc] initWithFrame:CGRectMake(14, 380, 282, 1)];
        customSeparator.image=[UIImage imageNamed:@"line"];
        [cell.contentView addSubview:customSeparator];
        
    }
    return cell;
    
}
- (IBAction)backToParentView:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCustomNavBar:nil];
    [self setTableView:nil];
    [self setCustomNavBar:nil];
    [super viewDidUnload];
}
@end
