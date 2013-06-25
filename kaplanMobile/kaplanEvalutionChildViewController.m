//
//  kaplanEvalutionChildViewController.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanEvalutionChildViewController.h"
#import "kaplanEvalutionViewController.h"
#import <QuartzCore/QuartzCore.h>

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
        cityArray=[[NSMutableArray alloc] initWithObjects:@"成都",@"北京",@"上海",@"深圳",@"天津",@"南京",@"湖南",@"辽宁",@"西藏",@"新疆", nil];
        educationArray=[[NSMutableArray alloc] initWithObjects:@"初中",@"高中",@"大专",@"本科",@"硕士",nil];
        destinationArray=[[NSMutableArray alloc] initWithObjects:@"美国",@"英国",@"澳大利亚",@"加拿大",@"意大利",@"法国",@"瑞士",@"新西兰",@"日本",@"韩国",@"泰国",@"新加坡", nil];

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
    [self.tableView reloadData];
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int number=0;
    switch (selectMode) {
        case 0:
            number=[cityArray count];
            modeLabel.text=@"所在地";
            break;
        case 1:
            number=[educationArray count];
            modeLabel.text=@"现有学历";
            break;
        case 2:
            number=[destinationArray count];
            modeLabel.text=@"意向留学国家";
            break;

    }
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
    

    switch (selectMode) {
        case 0:
        {
    
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                
                [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
                [cell.textLabel setTextColor:[UIColor greenColor]];
                [cell.textLabel setText:[cityArray objectAtIndex:indexPath.row]];
   

        }
            break;
        case 1:
        {
           
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                [cell.textLabel setTextColor:[UIColor greenColor]];
                [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
                [cell.textLabel setText:[educationArray objectAtIndex:indexPath.row]];
  

        }
            break;
        case 2:
        {
            
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                [cell.textLabel setTextColor:[UIColor greenColor]];
                [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
                [cell.textLabel setText:[destinationArray objectAtIndex:indexPath.row]];


        }
            break;
    }
           return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (selectMode) {
        case 0:
            [evalutionChildDelegate setCity:[cityArray objectAtIndex:indexPath.row]];
            break;
        case 1:
            [evalutionChildDelegate setEducation:[educationArray objectAtIndex:indexPath.row]];

            break;
        case 2:
            [evalutionChildDelegate setDestination:[destinationArray objectAtIndex:indexPath.row]];

            break;
    }
    [self.navigationController popToRootViewControllerAnimated:YES];

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
