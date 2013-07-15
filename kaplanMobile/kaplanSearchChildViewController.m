//
//  kaplanSearchChildViewController.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-7-4.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanSearchChildViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "kaplanSereachMainViewController.h"

@interface kaplanSearchChildViewController ()

@end

@implementation kaplanSearchChildViewController
@synthesize CustonNavBar,tableView;
@synthesize SearchChildDelegate;
static kaplanSearchChildViewController *sharekaplanSearchChildViewController = nil;
+(kaplanSearchChildViewController*)sharekaplanSearchChildViewController
{
    if (sharekaplanSearchChildViewController == nil) {
        sharekaplanSearchChildViewController = [[super allocWithZone:NULL] init];
    }
    return sharekaplanSearchChildViewController;
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
    schoolList=[NSMutableArray arrayWithObjects:@"清空选择",@"谢菲尔德大学",@"伦敦城市大学",@"克兰菲尔德大学",@"利物浦大学", @"威斯敏斯特大学", @"布莱顿大学", @"格拉斯哥大学", @"西英格兰大学",@"诺丁汉特伦特大学", nil];
    
    degreeList=[NSMutableArray arrayWithObjects:@"清空选择",@"本科预科",@"硕士预科",@"大一快捷课程",nil];

    specialitiesList=[NSMutableArray arrayWithObjects:@"清空选择",@"Art&Design",
                      @"Business Management",
                      @"Business",
                      @"Biological Sciences & Life Sciences",
                      @"Biological Sciences and Life Sciences",
                      @"Business Law and social science",
                      @"Business Pathway",
                      @"Business with Mathematics Pathway",
                      @"Business, Law and Social Science, Business and Mathematics",
                      @"Finance",@"International Year One in Business: Business pathway",@"International Year One in Engineering",@"Law & Journalism Media & Social Sciences",@"Law and Social Sciences",@"Law and Social Sciences pathway",@"Law Journalism Media Social Sciences",@"Management",@"Maths and Social Science/ Science and Engineering",@"Physics and Engineering",@"Physics and Engineering,  Chemistry and Chemical Engineering",@"Sciences & Engineering",@"Science and Engineering",@"Social Science",nil];
    loadResource=0;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_inside.png"]];
    self.CustonNavBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
    [self.CustonNavBar layer].shadowPath =[UIBezierPath bezierPathWithRect:self.CustonNavBar.bounds].CGPath;
    self.CustonNavBar.layer.shadowColor=[[UIColor blackColor] CGColor];
    self.CustonNavBar.layer.shadowOffset=CGSizeMake(0,0);
    self.CustonNavBar.layer.shadowRadius=10.0;
    self.CustonNavBar.layer.shadowOpacity=1.0;


}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int number=0;
    switch (loadResource) {
        case 0:
            number=[degreeList count];
            break;
        case 1:
            number=[schoolList count];
            break;
        case 2:
            number=[specialitiesList count];
            break;

    }
    return number;
}
-(void)loadResource:(int)resourceID
{
    loadResource=resourceID;
    [self.tableView reloadData];
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    cell.textLabel.textColor=[UIColor greenColor];
    switch (loadResource) {
        case 0:
    cell.textLabel.text=[degreeList objectAtIndex:indexPath.row];
            break;
        case 1:
    cell.textLabel.text=[schoolList objectAtIndex:indexPath.row];
            break;
        case 2:
    cell.textLabel.text=[specialitiesList objectAtIndex:indexPath.row];
            break;
            
    }
    UIImageView *customSeparator=[[UIImageView alloc] initWithFrame:CGRectMake(14, 40, 282, 1)];
    customSeparator.image=[UIImage imageNamed:@"line"];
    [cell.contentView addSubview:customSeparator];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (loadResource) {
        case 0:
        {
            [SearchChildDelegate setText:[degreeList objectAtIndex:indexPath.row] For:0];
        }
            break;
        case 1:
        {
             [SearchChildDelegate setText:[schoolList objectAtIndex:indexPath.row] For:1];
        }
            break;
        case 2:
        {
             [SearchChildDelegate setText:[specialitiesList objectAtIndex:indexPath.row] For:2];
        }
            break;
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
    [self setCustonNavBar:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
