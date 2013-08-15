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
#import "kaplanServerHelper.h"
#import "kaplanSQLIteHelper.h"
#import "kaplanSearchChildViewController.h"
#import "kaplanSearchDetailViewController.h"


@interface kaplanSereachMainViewController ()
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@end

@implementation kaplanSereachMainViewController
@synthesize selectedIndexPath = _selectedIndexPath;
@synthesize CustomNavBar;
@synthesize SereachDelegate;
@synthesize SearchView,SearchView2,searchBtn1,searchBtn2,SearchTextField,DisplayTableView;
@synthesize degreedBtn,schoolBtn,classBtn;
@synthesize searchChildViewController;
@synthesize searchDetailViewController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_inside"]];
        CustomNavBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
        SearchView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_bar"]];
        SearchView2.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_bar"]];
        [self.CustomNavBar layer].shadowPath =[UIBezierPath bezierPathWithRect:self.CustomNavBar.bounds].CGPath;
        self.CustomNavBar.layer.shadowColor=[[UIColor blackColor] CGColor];
        self.CustomNavBar.layer.shadowOffset=CGSizeMake(0,0);
        self.CustomNavBar.layer.shadowRadius=10.0;
        self.CustomNavBar.layer.shadowOpacity=1.0;
        self.degreedBtn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
        self.schoolBtn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
        self.classBtn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
        self.degreedBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        self.schoolBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        self.classBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;

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
    SearchView2.hidden=YES;
    SearchView.hidden=NO;
    schoolNameCN=[[NSMutableArray alloc] initWithCapacity:0];
    schoolNameEN=[[NSMutableArray alloc] initWithCapacity:0];
    degreeArray=[[NSMutableArray alloc] initWithCapacity:0];
    if ([[UIScreen mainScreen] bounds].size.height>480.00)
    {
        searchChildViewController=[[kaplanSearchChildViewController alloc] initWithNibName:@"kaplanSearchChildViewController_4" bundle:nil];
        searchDetailViewController=[[kaplanSearchDetailViewController alloc] initWithNibName:@"kaplanSearchDetailViewController_4" bundle:nil];
        
    }
else{
    searchChildViewController=[[kaplanSearchChildViewController alloc] initWithNibName:@"kaplanSearchChildViewController" bundle:nil];
    searchDetailViewController=[[kaplanSearchDetailViewController alloc] initWithNibName:@"kaplanSearchDetailViewController" bundle:nil];
}
searchChildViewController.SearchChildDelegate=self;
}
-(void)viewWillAppear:(BOOL)animated
{
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
                SearchView.hidden=NO;
                SearchView2.hidden=YES;
                searchMode=0;
                self.DisplayTableView.frame=CGRectMake(30, 171, self.DisplayTableView.frame.size.width, self.DisplayTableView.frame.size.height);
            }
        }
            break;
        case 1:
        {
            if (searchBtn2.selected!=YES) {
                searchBtn2.selected=YES;
                searchBtn1.selected=NO;
                SearchView.hidden=YES;
                SearchView2.hidden=NO;
                searchMode=1;
                self.DisplayTableView.frame=CGRectMake(30, 202, self.DisplayTableView.frame.size.width, self.DisplayTableView.frame.size.height);
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
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(28, 10, 27, 27);
    [button setBackgroundImage:[UIImage imageNamed:@"numberbox_s1"] forState:UIControlStateNormal];
    if (indexPath.row>98)
    {
        button.titleLabel.font= [UIFont systemFontOfSize: 12.0];
        [button setTitle:[NSString stringWithFormat:@"%d",indexPath.row+1] forState:UIControlStateNormal];
    }else
    {
        [button setTitle:[NSString stringWithFormat:@"%d",indexPath.row+1] forState:UIControlStateNormal];

    }
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.userInteractionEnabled=NO;
    [cell addSubview:button];
    UILabel *nameCN=[[UILabel alloc] initWithFrame:CGRectMake(69, 10,200, 18)];
            //nameCN.textColor=[UIColor colorWithRed:25 green:186 blue:106 alpha:1.0];
    nameCN.textColor=[UIColor whiteColor];
    nameCN.backgroundColor=[UIColor clearColor];
    nameCN.text=[schoolNameCN objectAtIndex:indexPath.row];
    nameCN.adjustsFontSizeToFitWidth=YES;
    [cell.contentView addSubview:nameCN];
    UILabel *nameEN=[[UILabel alloc] initWithFrame:CGRectMake(70, 30, 200, 18)];
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
    if (searchMode==0) {

        [self.navigationController pushViewController:searchDetailViewController animated:YES];
        [searchDetailViewController loadSchoolAllClass:[schoolNameCN objectAtIndex:indexPath.row]];
    }else
    {

        [self.navigationController pushViewController:searchDetailViewController animated:YES];
        [searchDetailViewController loadSchoolAllClass:[schoolNameEN objectAtIndex:indexPath.row]];
    }
        
}
- (IBAction)queryFromDBBy:(id)sender
{
    int targetMode=0;
    if (![self.degreedBtn.titleLabel.text isEqualToString:@"选择预科类型"]) {
        targetMode+=100;
    }
    if (![self.schoolBtn.titleLabel.text isEqualToString:@"选择院校"]) {
        targetMode+=10;
    }
    if (![self.classBtn.titleLabel.text isEqualToString:@"选择专业方向"]) {
        targetMode+=1;
    }
    if (targetMode==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误" message:@"请选择您要查询的选项" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
        [alert show];
    }else
    {
        NSLog(@"dhshhadjkasdha");
        kaplanSQLIteHelper *SQLIteHelper=[kaplanSQLIteHelper sharekaplanSQLIteHelper];
        NSMutableArray *tmpArray=[SQLIteHelper querySchoolsFromDBBy:self.degreedBtn.titleLabel.text :self.schoolBtn.titleLabel.text :self.classBtn.titleLabel.text forMode:targetMode];
        if ([tmpArray count]>0)
        {
            [schoolNameCN removeAllObjects];
            [schoolNameEN removeAllObjects];
            [degreeArray removeAllObjects];
            NSLog(@"%d",[tmpArray count]);
            for (NSDictionary *tmpDic in tmpArray)
            {
                if (tmpDic!=nil) {
                    if (![schoolNameCN containsObject:[tmpDic objectForKey:@"c3"]]) {
                        [schoolNameCN addObject:[tmpDic objectForKey:@"c3"]];
                        NSLog(@"CN2");
                        [schoolNameEN addObject:[tmpDic objectForKey:@"c2"]];
                        NSLog(@"EN2");
                        [degreeArray addObject:[tmpDic objectForKey:@"c1"]];
                        NSLog(@"addOK");
                        
                    }
                }else
                    NSLog(@"fall");
                
            }
            [self.DisplayTableView reloadData];
        }else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误" message:@"查询不要您所要查询的内容" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
            [alert show];
        }

    }
    
}
- (IBAction)queryFromDB:(id)sender
{
    if(SearchView.hidden==NO)
    {
    if ([self.SearchTextField.text isEqualToString:@""]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入您要查询的内容。" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
        [alert show];
        
    }else
    {
        kaplanSQLIteHelper *SQLIteHelper=[kaplanSQLIteHelper sharekaplanSQLIteHelper];
        if ([SQLIteHelper didDBexists]) {
            NSMutableArray *tmpArray=[SQLIteHelper querySchoolsFromDB:self.SearchTextField.text];
            if ([tmpArray count]>0)
            {
                [schoolNameCN removeAllObjects];
                [schoolNameEN removeAllObjects];
                [degreeArray removeAllObjects];
                NSLog(@"%d",[tmpArray count]);
                for (NSDictionary *tmpDic in tmpArray)
                {
                    if (tmpDic!=nil) {
                        if (![schoolNameCN containsObject:[tmpDic objectForKey:@"c2"]]) {
                            [schoolNameCN addObject:[tmpDic objectForKey:@"c2"]];
                            NSLog(@"CN2");
                            [schoolNameEN addObject:[tmpDic objectForKey:@"c2"]];
                            NSLog(@"EN2");
                            [degreeArray addObject:[tmpDic objectForKey:@"c1"]];
                            NSLog(@"addOK");
                            
                        }
                    }else
                        NSLog(@"fall");
                    
                }
                [self.DisplayTableView reloadData];
            }else
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误" message:@"查询不要您所要查询的内容" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
                [alert show];
            }
        }else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"警告" message:@"本地数据库损坏或丢失，请前往\"设置\"重新下载" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [alert show];
        }
    }
    }
}
- (IBAction)exitKeyboard:(id)sender {
    [sender resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)showMenu:(id)sender
{
    switch ([sender tag]) {
        case 0:
            [self.navigationController pushViewController:searchChildViewController animated:YES];
            [searchChildViewController loadResource:0];
            break;
        case 1:
            [self.navigationController pushViewController:searchChildViewController animated:YES];
            [searchChildViewController loadResource:1];
            break;
        case 2:
            [self.navigationController pushViewController:searchChildViewController animated:YES];
            [searchChildViewController loadResource:2];
            break;
    }
}
-(void)setText:(NSString*)textString For:(int)mode
{
    switch (mode) {
        case 0:
            if ([textString isEqualToString:@"清空选择"]) {
                [self.degreedBtn setTitle:@"选择预科类型" forState:UIControlStateNormal];

            }else
            [self.degreedBtn setTitle:textString forState:UIControlStateNormal];
            break;
        case 1:
            if ([textString isEqualToString:@"清空选择"]) {
                [self.schoolBtn setTitle:@"选择院校" forState:UIControlStateNormal];
                
            }else
                [self.schoolBtn setTitle:textString forState:UIControlStateNormal];
            break;
        case 2:
            if ([textString isEqualToString:@"清空选择"]) {
                [self.classBtn setTitle:@"选择专业方向" forState:UIControlStateNormal];
                
            }else
                [self.classBtn setTitle:textString forState:UIControlStateNormal];
            break;
    }
}

- (void)viewDidUnload {
    [self setDisplayTableView:nil];
    [self setSearchView2:nil];
    [self setDegreedBtn:nil];
    [self setSchoolBtn:nil];
    [self setClassBtn:nil];
    [super viewDidUnload];
}
@end
