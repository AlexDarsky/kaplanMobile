//
//  kaplanEvalutionChildViewController.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanEvalutionChildViewController.h"
#import "kaplanEvalutionViewController.h"
#import "kaplanEvalutionGrandChildViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "kaplanServerHelper.h"

@interface kaplanEvalutionChildViewController ()

@end

@implementation kaplanEvalutionChildViewController
@synthesize childCustomNavBar;
@synthesize tableView,modeLabel;
@synthesize evalutionChildDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_inside"]];
        childCustomNavBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
         [self.childCustomNavBar layer].shadowPath =[UIBezierPath bezierPathWithRect:self.childCustomNavBar.bounds].CGPath;
        self.childCustomNavBar.layer.shadowColor=[[UIColor blackColor] CGColor];
        self.childCustomNavBar.layer.shadowOffset=CGSizeMake(0,0);
        self.childCustomNavBar.layer.shadowRadius=10.0;
        self.childCustomNavBar.layer.shadowOpacity=1.0;
       // childCustomNavBar.backgroundColor=[UIColor whiteColor];
        nameArray=[[NSMutableArray alloc] initWithCapacity:0];
        IDArray=[[NSMutableArray alloc] initWithCapacity:0];

    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


}
-(void)reloadListForMode:(int)targetMode
{
    NSLog(@"ok!");
    selectMode=targetMode;
    if ([nameArray count]>0)
    {
        [nameArray removeAllObjects];
    }
    if ([IDArray count]>0)
    {
        [IDArray removeAllObjects];
    }
    kaplanServerHelper *serverHelper=[kaplanServerHelper sharekaplanServerHelper];
    switch (selectMode) {
        case 0:
        {

            NSArray *tmpArray=[[NSArray alloc] initWithArray:[serverHelper getCityLoadList]];
                       for (NSDictionary *tmpDic in tmpArray)
            {
                [nameArray addObject:[tmpDic objectForKey:@"cityName"]];
                [IDArray addObject:[tmpDic objectForKey:@"id"]];
            }
        }
            break;
        case 1:
        {
            NSArray *tmpArray=[[NSArray alloc] initWithArray:[serverHelper getClassLoadList]];
            for (NSDictionary *tmpDic in tmpArray)
            {
                [nameArray addObject:[tmpDic objectForKey:@"classCName"]];
                [IDArray addObject:[tmpDic objectForKey:@"id"]];
            }
        }

            break;
        case 2:
        {
            NSArray *tmpArray=[[NSArray alloc] initWithArray:[serverHelper getCountryList]];
            for (NSDictionary *tmpDic in tmpArray)
            {
                [nameArray addObject:[tmpDic objectForKey:@"classCName"]];
                [IDArray addObject:[tmpDic objectForKey:@"id"]];
            }
        }

            break;
    }

    [self.tableView reloadData];
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int number=0;
    switch (selectMode) {
        case 0:
            
            modeLabel.text=@"所在地";
            break;
        case 1:

            modeLabel.text=@"现有学历";
            break;
        case 2:
            modeLabel.text=@"意向留学国家";
            break;

    }
    number=[IDArray count];
    return number;
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
    

    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
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
    NSString *newString = [NSString stringWithFormat:@"%@",[IDArray objectAtIndex:indexPath.row]];

    switch (selectMode) {
        case 0:
        {
            kaplanEvalutionGrandChildViewController *evalutionGrandChildViewController=[kaplanEvalutionGrandChildViewController sharekaplanEvalutionGrandChildViewController];
            [self.navigationController pushViewController:evalutionGrandChildViewController animated:YES];
            //grandChild.evalutionGrandChildDelegate=self;
            [evalutionGrandChildViewController reloadListBySubId:[IDArray objectAtIndex:indexPath.row]];
        }
            break;
        case 1:
            [evalutionChildDelegate setEducation:[nameArray objectAtIndex:indexPath.row] andID:[newString intValue]];
             [self.navigationController popToRootViewControllerAnimated:YES];

            break;
        case 2:
            [evalutionChildDelegate setDestination:[nameArray objectAtIndex:indexPath.row] andID:[newString intValue]];
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
    }
   

}
-(void)setSubCity:(NSString*)cityName :(NSString*)grandChildID
{
    NSLog(@"hahah");
    [evalutionChildDelegate setCity:cityName andID:[grandChildID intValue]];
}
- (IBAction)backToParentViewCon:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setChildCustomNavBar:nil];
    [self setTableView:nil];
    [self setModeLabel:nil];
    [super viewDidUnload];
}
@end
