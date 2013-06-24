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
        self.SearchView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_bar.png"]];
        self.SearchTextField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"input"]];
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_inside.png"]];
        self.CustomNavBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
        self.CustomNavBar.layer.shadowColor=[[UIColor blackColor] CGColor];
        self.CustomNavBar.layer.shadowOffset=CGSizeMake(0,0);
        self.CustomNavBar.layer.shadowRadius=10.0;
        self.CustomNavBar.layer.shadowOpacity=1.0;

    }
    return self;
}

- (void)viewDidLoad
{
  
    //self.searchView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_bar.png"]];
    //self.searchFied.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"input"]];
        schoolsArrayCH=[[NSMutableArray alloc] initWithObjects:@"贝勒大学",@"东北大学",@"福蒙特大学",@"玛瑞斯学院",@"斯蒂文斯理工学院",@"德保大学",nil];
   
    schoolArrayEN=[[NSMutableArray alloc] initWithObjects:@"abc",@"bcd",@"cde",@"abc",@"adf", @"deg",nil];
    [super viewDidLoad];
   
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
