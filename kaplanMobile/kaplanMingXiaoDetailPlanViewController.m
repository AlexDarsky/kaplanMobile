//
//  kaplanMingXiaoDetailPlanViewController.m
//  kaplanMobile
//
//  Created by linchuan on 6/21/13.
//  Copyright (c) 2013 AlexZhu. All rights reserved.
//

#import "kaplanMingXiaoDetailPlanViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface kaplanMingXiaoDetailPlanViewController ()

@end

@implementation kaplanMingXiaoDetailPlanViewController
@synthesize CustomNavBar,tableView,ShareView;
@synthesize schoolIconImage,schoolNameCN,schoolNameEN,schoolTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_inside.png"]];
        self.CustomNavBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
        self.CustomNavBar.layer.shadowColor=[[UIColor blackColor] CGColor];
        self.CustomNavBar.layer.shadowOffset=CGSizeMake(0,0);
        self.CustomNavBar.layer.shadowRadius=10.0;
        self.CustomNavBar.layer.shadowOpacity=1.0;
        self.ShareView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_bar"]];

    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
#pragma mark - tableview datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)reloadSchoolDetail:(NSString*)schoolCN withEN:(NSString*)schoolEN withDes:(NSString*)description withIcon:(UIImage*)schoolIcon
{
    [self setSchoolNameCN:@"圣多明尼格哥中学"];
    [self setSchoolNameEN:@"San Domenicon"];
    [self setSchoolTextView:@"多明尼哥中学位于旧金山以北20英里的马林郡，成立于1850年，是一所独立的提供大学预科课程的天主教女校，也是加利福尼亚州历史最悠久的女校。学校培养不同信仰，不同背景的年轻女生成为未来的领导者。在旧金山海湾地区，其教育体制是独一无二的。学校由蒙特利尔的多米尼克姐妹创立，经过几代人的努力，深知为学生进入并适应社会做准备的重要性。学校不仅秉承传统，也提供符合时代节拍的教育模式，更为年轻女孩们提供了与众不同的学习机会，使她们在各个方面得到提升，为她们今后的发展铺路。现有的学生中40%来自不同的州和国家。很多教师拥有硕士或以上学位。学生在课程范围内自由选择自己感兴趣的AP和进阶课程。学校占地面积515英亩，距离旧金山只有20英里。学生校园生活丰富多彩，有各种各样的艺术表演、文化节等。学校的其他优势包括：音乐室、戏剧艺术、骑马、雄厚的师资力量以及优美的校园环境。"];
    [self setSchoolIconImage:@"SanDomenico.jpg"];
    [self.tableView reloadData];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return 83;
    }else
        if (indexPath.row==1)
        {
            return 200;
                  }else
        {
            return 96;
            
        }

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc] init];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (indexPath.row==0) {
        UILabel *txtlCH=[[UILabel alloc] init];
        txtlCH.frame=CGRectMake(140, 1, cell.contentView.frame.size.width, cell.contentView.frame.size.height);
        txtlCH.backgroundColor=[UIColor clearColor];
        txtlCH.font=[UIFont fontWithName:@"Arial Hebrew" size:16];
        txtlCH.textColor=[UIColor whiteColor];
        [txtlCH setText:schoolNameCN];
        [cell addSubview:txtlCH];
        
        UILabel *txtlEN=[[UILabel alloc] init];
        txtlEN.frame=CGRectMake(140, 18, cell.contentView.frame.size.width, cell.contentView.frame.size.height);
        txtlEN.backgroundColor=[UIColor clearColor];
        txtlEN.font=[UIFont fontWithName:@"Arial Hebrew" size:12];
        txtlEN.textColor=[UIColor greenColor];
        [txtlEN setText:schoolNameEN];
        [cell addSubview:txtlEN];
        UIImageView *schoolImage=[[UIImageView alloc] initWithFrame:CGRectMake(40, 10, 98, 66)];
        [schoolImage setImage:[UIImage imageNamed:self.schoolIconImage]];
         [cell.contentView addSubview:schoolImage];
        UIImageView *customSeparator=[[UIImageView alloc] initWithFrame:CGRectMake(14, 92, 282, 1)];
        customSeparator.image=[UIImage imageNamed:@"line"];
        [cell.contentView addSubview:customSeparator];
    }else
         if (indexPath.row==1) {
             UITextView *schoolDescriptionTV=[[UITextView alloc] initWithFrame:CGRectMake(40, 15, 255, 180)];
             schoolDescriptionTV.backgroundColor=[UIColor clearColor];
             [schoolDescriptionTV setText:self.schoolTextView];
             [schoolDescriptionTV setTextColor:[UIColor whiteColor]];
             schoolDescriptionTV.editable=NO;
             [cell.contentView addSubview:schoolDescriptionTV];
             UIImageView *customSeparator=[[UIImageView alloc] initWithFrame:CGRectMake(14, 199, 282, 1)];
             customSeparator.image=[UIImage imageNamed:@"line"];
             [cell.contentView addSubview:customSeparator];

        }else
        {
            UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(30, 20, 239, 31)];
            [backBtn addTarget:self action:@selector(backToParentView:) forControlEvents:UIControlEventTouchUpInside];
            [backBtn setImage:[UIImage imageNamed:@"btn_back2"] forState:UIControlStateNormal];
            [cell.contentView addSubview:backBtn];
        }
            
    return cell;
    
}


#pragma mark - tableview delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(IBAction)backToParentView:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setCustomNavBar:nil];
    [self setTableView:nil];
    [self setShareView:nil];
    [super viewDidUnload];
}
@end
