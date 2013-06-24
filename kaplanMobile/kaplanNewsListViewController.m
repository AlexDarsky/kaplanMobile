//
//  kaplanNewsListViewController.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanNewsListViewController.h"
#import "kaplanViewController.h"
#import "kaplanNewsListChildViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface kaplanNewsListViewController ()

@end

@implementation kaplanNewsListViewController
@synthesize NewsTableView,CustomNavBar;
@synthesize NewsListDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_inside"]];
        CustomNavBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
        self.CustomNavBar.layer.shadowColor=[[UIColor blackColor] CGColor];
        self.CustomNavBar.layer.shadowOffset=CGSizeMake(0,0);
        self.CustomNavBar.layer.shadowRadius=10.0;
        self.CustomNavBar.layer.shadowOpacity=1.0;
        newsTitleArray=[[NSMutableArray alloc] initWithObjects:@"习近平同团中央新一届领导班子成员集体谈话",@"我国婴幼儿奶粉将试行药店专柜销售",@"赵红霞受审哭求雷政富作证：两人最初有感情", nil];
        newsPreArray=[[NSMutableArray alloc] initWithObjects:@"中共中央总书记、国家主席、中央军委主席习近平20日下午在中南海同团中央新一届领导班子成员集体谈话并发表重要讲话强调，代表广大青年，赢得广大青年，依靠广大青年，是我们党不断从胜利走向胜利的重要保证。",@"今年5月31日，婴幼儿奶粉问题上了国务院常务会议，并以国务院名义对提升国产婴幼儿配方奶粉的质量和安全做出了全面、具体部署。",@"重庆市渝北区法院20日开庭审理肖烨等6人利用不雅视频敲诈勒索案，因涉及个人隐私，法院对此案进行不公开审理。鉴于涉案人数众多、案情复杂，法院预计该案庭审两天。", nil];
            }
    newsImageArray=[[NSMutableArray alloc] initWithObjects:@"new1.jpg",@"",@"", nil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [newsTitleArray count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 98;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    UIImageView *iconImg=[[UIImageView alloc] initWithFrame:CGRectMake(40, 10, 15, 15)];
    iconImg.image=[UIImage imageNamed:@"dot"];
    [cell.contentView addSubview:iconImg];
    UILabel *newTitle=[[UILabel alloc] initWithFrame:CGRectMake(60, 10, 200, 20)];
    newTitle.textColor=[UIColor whiteColor];
    newTitle.backgroundColor=[UIColor clearColor];
    newTitle.text=[newsTitleArray objectAtIndex:indexPath.row];
    [newTitle setNumberOfLines:0];
    [cell.contentView addSubview:newTitle];
    if ([newsImageArray objectAtIndex:indexPath.row]!=@"") {
        UIImageView *newImg=[[UIImageView alloc] initWithFrame:CGRectMake(40, 35, 66, 45)];
       [ newImg setImage:[UIImage imageNamed:[newsImageArray objectAtIndex:indexPath.row]]];
        [cell.contentView addSubview:newImg];
        UIFont *font = [UIFont fontWithName:@"Arial" size:12];
        UILabel *newPre=[[UILabel alloc] initWithFrame:CGRectMake(120, 20, 160, 90)];
        newPre.lineBreakMode=NSLineBreakByCharWrapping;
        [newPre setNumberOfLines:2];
        [newPre setFont:font];
        newPre.textColor=[UIColor greenColor];
        newPre.text=[newsPreArray objectAtIndex:indexPath.row];
        newPre.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:newPre];
        UIImageView *customSeparator=[[UIImageView alloc] initWithFrame:CGRectMake(14, 97, 282, 1)];
        customSeparator.image=[UIImage imageNamed:@"line"];
        [cell.contentView addSubview:customSeparator];
    }else
    {
     UIFont *font = [UIFont fontWithName:@"Arial" size:12];
    UILabel *newPre=[[UILabel alloc] initWithFrame:CGRectMake(60, 30, 200, 60)];
    newPre.lineBreakMode=NSLineBreakByCharWrapping;
    [newPre setNumberOfLines:2];
    [newPre setFont:font];
    newPre.textColor=[UIColor greenColor];
    newPre.text=[newsPreArray objectAtIndex:indexPath.row];
    newPre.backgroundColor=[UIColor clearColor];
    [cell.contentView addSubview:newPre];
        UIImageView *customSeparator=[[UIImageView alloc] initWithFrame:CGRectMake(14, 97, 282, 1)];
        customSeparator.image=[UIImage imageNamed:@"line"];
        [cell.contentView addSubview:customSeparator];
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"yahoo!!");
    kaplanNewsListChildViewController *newsChild=[kaplanNewsListChildViewController sharekaplanNewsListChildViewController];
    [self.navigationController pushViewController:newsChild animated:YES];
    [newsChild reloadNewInfomation:[newsTitleArray objectAtIndex:indexPath.row] text:[newsPreArray objectAtIndex:indexPath.row] andImage:[UIImage imageNamed:[newsImageArray objectAtIndex:indexPath.row]]];

    
    
}
- (IBAction)bactToMainView:(id)sender
{
    [NewsListDelegate showBackView:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCustomNavBar:nil];
    [self setNewsTableView:nil];
    [super viewDidUnload];
}
@end
