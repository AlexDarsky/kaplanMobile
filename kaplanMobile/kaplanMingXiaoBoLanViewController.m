//
//  kaplanMingXiaoBoLanViewController.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanMingXiaoBoLanViewController.h"
#import "kaplanViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "kaplanServerHelper.h"

@interface kaplanMingXiaoBoLanViewController ()

@end

@implementation kaplanMingXiaoBoLanViewController
@synthesize schoolsTableView;
@synthesize MingXiaoBoLanDelegate;
@synthesize SearchTextField,SearchView;
@synthesize CustomNavBar;
/*static kaplanMingXiaoBoLanViewController *sharedkaplanMingXiaoBoLanViewController = nil;

+(kaplanMingXiaoBoLanViewController*)sharedkaplanMingXiaoBoLanViewController
{
    if (sharedkaplanMingXiaoBoLanViewController == nil) {
        sharedkaplanMingXiaoBoLanViewController = [[super allocWithZone:NULL] init];
    }
    return sharedkaplanMingXiaoBoLanViewController;
}
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization


    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    if ([schoolIDArray count]==0) {
        kaplanServerHelper *serverHelper=[kaplanServerHelper sharekaplanServerHelper];
        NSArray *tmpArray=[[NSArray alloc] initWithArray:[serverHelper getSchoolListAtPage:1]];
        for (NSDictionary *tmpDic in tmpArray) {
            [schoolsArrayCH addObject:[tmpDic objectForKey:@"schoolCnName"]];
            [schoolIDArray addObject:[tmpDic objectForKey:@"id"]];
            [schoolArrayEN addObject:@"ENGLISH"];
        }
        [self.schoolsTableView reloadData];
    }
    
}
- (void)viewDidLoad
{
      [super viewDidLoad];
    //self.searchView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_bar.png"]];
    //self.searchFied.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"input"]];
    schoolsArrayCH=[[NSMutableArray alloc] initWithCapacity:0];
           self.SearchView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_bar"]];
    schoolArrayEN=[[NSMutableArray alloc] initWithCapacity:0];
    schoolIDArray=[[NSMutableArray alloc] initWithCapacity:0];
    self.SearchView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_bar"]];
    self.SearchTextField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"input"]];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_inside.png"]];
    self.CustomNavBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.CustomNavBar layer].shadowPath =[UIBezierPath bezierPathWithRect:self.CustomNavBar.bounds].CGPath;
    self.CustomNavBar.layer.shadowColor=[[UIColor blackColor] CGColor];
    self.CustomNavBar.layer.shadowOffset=CGSizeMake(0,0);
    self.CustomNavBar.layer.shadowRadius=10.0;
    self.CustomNavBar.layer.shadowOpacity=1.0;

   
}

#pragma mark -tableview datasource



- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
        return [schoolsArrayCH count];
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
    // static NSString *cellIdentifier = @"MyCell";
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        
       // cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
       
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
   
    UIImageView *dotView=[[UIImageView alloc] initWithFrame:CGRectMake(40, 10, 15, 15)];
    [dotView setImage:[UIImage imageNamed:@"dot.png"]];
    
    UIImageView *lineView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 50,280 , 1)];
    [lineView setImage:[UIImage imageNamed:@"line.png"]];
    [cell addSubview:lineView];
    [cell addSubview:dotView];
    
    UILabel *txtlCH=[[UILabel alloc] init];
    txtlCH.frame=CGRectMake(75, 1, cell.contentView.frame.size.width, cell.contentView.frame.size.height);
    txtlCH.backgroundColor=[UIColor clearColor];
    txtlCH.font=[UIFont fontWithName:@"Arial Hebrew" size:19];
    txtlCH.textColor=[UIColor whiteColor];
    [txtlCH setText:[schoolsArrayCH objectAtIndex:indexPath.row]];
    [cell addSubview:txtlCH];
    
    UILabel *txtlEN=[[UILabel alloc] init];
    txtlEN.frame=CGRectMake(75, 18, cell.contentView.frame.size.width, cell.contentView.frame.size.height);
    txtlEN.backgroundColor=[UIColor clearColor];
    txtlEN.font=[UIFont fontWithName:@"Arial Hebrew" size:12];
    txtlEN.textColor=[UIColor greenColor];
    [txtlEN setText:[schoolArrayEN objectAtIndex:indexPath.row]];
    [cell addSubview:txtlEN];

       
    return cell;
            
    
}
#pragma mark -tableview delegate



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      kaplanMingXiaoDetailPlanViewController *kdetailPlanViewController=[[kaplanMingXiaoDetailPlanViewController alloc] init];
    
    [kdetailPlanViewController reloadSchoolDetail:nil withEN:nil withDes:nil withIcon:nil];
    [self.navigationController pushViewController:kdetailPlanViewController animated:YES];
    
    
}
- (IBAction)backToMainView:(id)sender
{
    [MingXiaoBoLanDelegate showBackView:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSearchView:nil];
    [self setSearchTextField:nil];
    [self setCustomNavBar:nil];
    [super viewDidUnload];
}
@end
