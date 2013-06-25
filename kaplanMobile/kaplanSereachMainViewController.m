//
//  kaplanSereachMainViewController.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanSereachMainViewController.h"
#import "kaplanViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface kaplanSereachMainViewController ()

@end

@implementation kaplanSereachMainViewController
@synthesize CustomNavBar;
@synthesize SereachDelegate;
@synthesize SearchView,searchBtn1,searchBtn2,SearchTextField,DisplayTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_inside"]];
        CustomNavBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
        SearchView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_bar"]];
        [self.CustomNavBar layer].shadowPath =[UIBezierPath bezierPathWithRect:self.CustomNavBar.bounds].CGPath;
        self.CustomNavBar.layer.shadowColor=[[UIColor blackColor] CGColor];
        self.CustomNavBar.layer.shadowOffset=CGSizeMake(0,0);
        self.CustomNavBar.layer.shadowRadius=10.0;
        self.CustomNavBar.layer.shadowOpacity=1.0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    searchBtn1.selected=YES;
    searchBtn2.selected=NO;
    searchMode=0;
    SearchTextField.placeholder=@"  请输入您要查询的专业";

    schoolNameCN=[[NSMutableArray alloc] initWithObjects:@"圣多明尼哥中学",@"圣泽维尔学院",@"斯卡特古德学校",@"史蒂文森中学",@"斯阔谷学院",@"夏威夷科学院", nil];
    schoolNameEN=[[NSMutableArray alloc] initWithObjects:@"San Domenico",@"Academy of St.Xavier",@"Scattergood Friends",@"Stevenson School",@"Squaw Valley Academy",@"Hwai' i Preparatory", nil];
    
}
- (IBAction)backToMainView:(id)sender {
    [SereachDelegate showBackView:nil];
}
- (IBAction)changeToMode:(id)sender
{
    switch ([sender tag]) {
        case 0:
        {
            if (searchBtn1.selected!=YES) {
                searchBtn1.selected=YES;
                searchBtn2.selected=NO;
                SearchTextField.placeholder=@"  请输入您要查询的专业";
                searchMode=0;
            }
        }
            break;
        case 1:
        {
            if (searchBtn2.selected!=YES) {
                searchBtn2.selected=YES;
                searchBtn1.selected=NO;
                SearchTextField.placeholder=@"  请输入您要查询的院校名称";
                searchMode=1;
            }
        }
            break;

    }
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [schoolNameCN count];
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
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            UILabel *nameCN=[[UILabel alloc] initWithFrame:CGRectMake(75, 10,120, 18)];
            //nameCN.textColor=[UIColor colorWithRed:25 green:186 blue:106 alpha:1.0];
    nameCN.textColor=[UIColor whiteColor];
    nameCN.backgroundColor=[UIColor clearColor];
            nameCN.text=[schoolNameCN objectAtIndex:indexPath.row];
            [cell.contentView addSubview:nameCN];
            UILabel *nameEN=[[UILabel alloc] initWithFrame:CGRectMake(75, 30, 160, 18)];
            nameEN.textColor=[UIColor greenColor];
            nameEN.text=[schoolNameEN objectAtIndex:indexPath.row];
    nameEN.font=[UIFont fontWithName:@"Arial Hebrew" size:12];
    nameEN.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:nameEN];
    UIImageView *customSeparator=[[UIImageView alloc] initWithFrame:CGRectMake(14, 49, 282, 1)];
    customSeparator.image=[UIImage imageNamed:@"line"];
    [cell.contentView addSubview:customSeparator];
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"yahoo!!");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDisplayTableView:nil];
    [super viewDidUnload];
}
@end
