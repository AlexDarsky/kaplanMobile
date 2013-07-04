//
//  kaplanSearchDetailViewController.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-7-4.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanSearchDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "kaplanSQLIteHelper.h"

@interface kaplanSearchDetailViewController ()

@end

@implementation kaplanSearchDetailViewController
@synthesize CustomNavBar,tableView,schoolCN,schoolEN,shareView;

static kaplanSearchDetailViewController *sharekaplanSearchDetailViewController = nil;
+(kaplanSearchDetailViewController*)sharekaplanSearchDetailViewController
{
    if (sharekaplanSearchDetailViewController == nil) {
        sharekaplanSearchDetailViewController = [[super allocWithZone:NULL] init];
    }
    return sharekaplanSearchDetailViewController;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_inside.png"]];
        self.CustomNavBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
        [self.navigationController setNavigationBarHidden:YES];
        
        [self.CustomNavBar layer].shadowPath =[UIBezierPath bezierPathWithRect:self.CustomNavBar.bounds].CGPath;
        self.CustomNavBar.layer.shadowColor=[[UIColor blackColor] CGColor];
        self.CustomNavBar.layer.shadowOffset=CGSizeMake(0,0);
        self.CustomNavBar.layer.shadowRadius=10.0;
        self.CustomNavBar.layer.shadowOpacity=1.0;
        self.shareView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_bar"]];
        listArray=[[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [listArray count];
}

-(void)loadSchoolAllClass:(NSString*)schoolName
{
    self.schoolCN.text=schoolName;
    self.schoolEN.text=@"浏览院校专业详情";
    if ([listArray count]>0) {
        [listArray removeAllObjects];
    }
    kaplanSQLIteHelper *sqliteHelper=[kaplanSQLIteHelper sharekaplanSQLIteHelper];
    NSMutableArray *tmpArray=[[NSMutableArray alloc] initWithArray:[sqliteHelper getSchoolAllClass:schoolName]];
    for (NSDictionary *tmpDic in tmpArray) {
        if ([tmpDic objectForKey:@"c4"]!=nil) {
            [listArray addObject:[tmpDic objectForKey:@"c4"]];

        }
           }
    [self.tableView reloadData];
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    UIImageView *customSeparator=[[UIImageView alloc] initWithFrame:CGRectMake(14, 30, 282, 1)];
    customSeparator.image=[UIImage imageNamed:@"line"];
    [cell.contentView addSubview:customSeparator];
    cell.textLabel.text=[NSString stringWithFormat:@"   ☸ %@",[listArray objectAtIndex:indexPath.row]];
    cell.textLabel.textColor=[UIColor lightGrayColor];
    return cell;
    
}

- (IBAction)backToParentView:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)shareBtn:(id)sender
{
    NSString *subjectsString=@"他们拥有的课程是：";
    for (int i=0; i<5; i++)
    {
        subjectsString=[subjectsString stringByAppendingFormat:@" %@,",[listArray objectAtIndex:i]];
    }
    NSString *postText = [NSString stringWithFormat:@"我在 kaplan官方客户端上发现了 %@，%@",self.schoolCN.text,subjectsString];
    NSArray *activityItems = @[postText];
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                                                                     applicationActivities:nil];
    activityController.excludedActivityTypes = (@[
                                                UIActivityTypeAssignToContact,
                                                UIActivityTypeMail,
                                                UIActivityTypeMessage,
                                                UIActivityTypePrint,
                                                UIActivityTypeSaveToCameraRoll
                                                ]);
    
    [self presentViewController:activityController animated:YES completion:NULL];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCustomNavBar:nil];
    [self setTableView:nil];
    [self setSchoolCN:nil];
    [self setSchoolEN:nil];
    [super viewDidUnload];
}
@end
