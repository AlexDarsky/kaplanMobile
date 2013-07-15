//
//  kaplanEvalutionGrandChildViewController.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-7-3.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanEvalutionGrandChildViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "kaplanServerHelper.h"
#import "kaplanEvalutionChildViewController.h"
#import "kaplanEvalutionViewController.h"

@interface kaplanEvalutionGrandChildViewController ()

@end

@implementation kaplanEvalutionGrandChildViewController
@synthesize grabdChildCustomNavBar,tableView;
@synthesize evalutionGrandChildDelegate;

static kaplanEvalutionGrandChildViewController *sharekaplanEvalutionGrandChildViewController=nil;


+(kaplanEvalutionGrandChildViewController*)sharekaplanEvalutionGrandChildViewController
{
    
    if (sharekaplanEvalutionGrandChildViewController == nil) {
        sharekaplanEvalutionGrandChildViewController = [[super allocWithZone:NULL] init];
    }
    return sharekaplanEvalutionGrandChildViewController;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_inside"]];
        grabdChildCustomNavBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
        [self.grabdChildCustomNavBar layer].shadowPath =[UIBezierPath bezierPathWithRect:self.grabdChildCustomNavBar.bounds].CGPath;
        self.grabdChildCustomNavBar.layer.shadowColor=[[UIColor blackColor] CGColor];
        self.grabdChildCustomNavBar.layer.shadowOffset=CGSizeMake(0,0);
        self.grabdChildCustomNavBar.layer.shadowRadius=10.0;
        self.grabdChildCustomNavBar.layer.shadowOpacity=1.0;
        // childCustomNavBar.backgroundColor=[UIColor whiteColor];
        nameArray=[[NSMutableArray alloc] initWithCapacity:0];
        IDArray=[[NSMutableArray alloc] initWithCapacity:0];

    }
    return self;
}
-(void)reloadListBySubId:(NSString*)targetID
{
    NSLog(@"ok!");
    if ([nameArray count]>0)
    {
        [nameArray removeAllObjects];
    }
    if ([IDArray count]>0)
    {
        [IDArray removeAllObjects];
    }
    kaplanServerHelper *serverHelper=[kaplanServerHelper sharekaplanServerHelper];
    NSArray *tmpArray=[[NSArray alloc] initWithArray:[serverHelper getCityChildLoadList:targetID]];
    for (NSDictionary *tmpDic in tmpArray)
    {
                [nameArray addObject:[tmpDic objectForKey:@"cityName"]];
                [IDArray addObject:[tmpDic objectForKey:@"id"]];
    }
        [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [IDArray count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    [cell.textLabel setTextColor:[UIColor greenColor]];
    [cell.textLabel setText:[nameArray objectAtIndex:indexPath.row]];
    UIImageView *customSeparator=[[UIImageView alloc] initWithFrame:CGRectMake(14, 50, 282, 1)];
    customSeparator.image=[UIImage imageNamed:@"line"];
    [cell.contentView addSubview:customSeparator];
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"aaaa");
    NSString *newString = [NSString stringWithFormat:@"%@",[IDArray objectAtIndex:indexPath.row]];
    [evalutionGrandChildDelegate setCity:[nameArray objectAtIndex:indexPath.row] andID:[newString intValue]];
    [self.navigationController popToRootViewControllerAnimated:YES];

}
- (IBAction)backTO:(id)sender
{
    NSLog(@"backTo");
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
