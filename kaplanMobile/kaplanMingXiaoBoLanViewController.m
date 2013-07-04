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
        self.SearchTextField.delegate=self;

    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
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
    displayCNArray=[[NSMutableArray alloc] initWithCapacity:0];
    displayENArray=[[NSMutableArray alloc] initWithCapacity:0];
    self.SearchView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_bar"]];
    self.SearchTextField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"input"]];
    [self.SearchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_inside.png"]];
    self.CustomNavBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.CustomNavBar layer].shadowPath =[UIBezierPath bezierPathWithRect:self.CustomNavBar.bounds].CGPath;
    self.CustomNavBar.layer.shadowColor=[[UIColor blackColor] CGColor];
    self.CustomNavBar.layer.shadowOffset=CGSizeMake(0,0);
    self.CustomNavBar.layer.shadowRadius=10.0;
    self.CustomNavBar.layer.shadowOpacity=1.0;
    if ([schoolIDArray count]==0) {
        kaplanServerHelper *serverHelper=[kaplanServerHelper sharekaplanServerHelper];
        NSArray *tmpArray=[[NSArray alloc] initWithArray:[serverHelper getSchoolListAtPage:1]];
        for (NSDictionary *tmpDic in tmpArray)
        {
            NSString *nameString=[tmpDic objectForKey:@"schoolCnName"];
            NSArray *nameArray=[nameString componentsSeparatedByString:@"("];
            NSLog(@"%d",[nameArray count]);
            [schoolsArrayCH addObject:[nameArray objectAtIndex:0]];
            [schoolIDArray addObject:[tmpDic objectForKey:@"id"]];
            [schoolArrayEN addObject:[nameArray lastObject]];
        }
    }
    displayCNArray=[schoolsArrayCH mutableCopy];
    displayENArray=[schoolArrayEN mutableCopy];
    [self.schoolsTableView reloadData];
}

#pragma mark -tableview datasource


- (void) textFieldDidChange:(UITextField*) TextField
{
    if ([self.SearchTextField.text isEqualToString:@""])
    {
        displayCNArray=[schoolsArrayCH mutableCopy];
        displayENArray=[schoolArrayEN mutableCopy];
        [self.schoolsTableView reloadData];
    }else
    {
        NSLog(@"textFieldDidChange textFieldDidChange");
        if ([displayCNArray count]>0) {
            [displayCNArray removeAllObjects];
            [displayENArray removeAllObjects];
        }
        for (int i=0; i<[schoolsArrayCH count]; i++) {
            NSString *tmpString=[schoolsArrayCH objectAtIndex:i];
            if ([tmpString rangeOfString:TextField.text].location !=NSNotFound) {
                [displayCNArray addObject:[schoolsArrayCH objectAtIndex:i]];
                [displayENArray addObject:[schoolArrayEN objectAtIndex:i]];
            }
        }
        [self.schoolsTableView reloadData];

    }
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
        return [displayCNArray count];
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
   
    UIImageView *dotView=[[UIImageView alloc] initWithFrame:CGRectMake(45, 15, 15, 15)];
    [dotView setImage:[UIImage imageNamed:@"dot.png"]];
    
    UIImageView *lineView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 50,280 , 1)];
    [lineView setImage:[UIImage imageNamed:@"line.png"]];
    [cell addSubview:lineView];
    [cell addSubview:dotView];
    
    UILabel *txtlCH=[[UILabel alloc] init];
    txtlCH.frame=CGRectMake(70, 1, cell.contentView.frame.size.width, cell.contentView.frame.size.height);
    txtlCH.backgroundColor=[UIColor clearColor];
    txtlCH.font=[UIFont fontWithName:@"Arial Hebrew" size:19];
    txtlCH.textColor=[UIColor whiteColor];
    [txtlCH setText:[displayCNArray objectAtIndex:indexPath.row]];
    [cell addSubview:txtlCH];
    
    UILabel *txtlEN=[[UILabel alloc] init];
    txtlEN.frame=CGRectMake(70, 18, cell.contentView.frame.size.width, cell.contentView.frame.size.height);
    txtlEN.backgroundColor=[UIColor clearColor];
    txtlEN.font=[UIFont fontWithName:@"Arial Hebrew" size:12];
    txtlEN.textColor=[UIColor greenColor];
    [txtlEN setText:[displayENArray objectAtIndex:indexPath.row]];
    [cell addSubview:txtlEN];

       
    return cell;
            
    
}
#pragma mark -tableview delegate



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    kaplanMingXiaoDetailPlanViewController *kdetailPlanViewController=nil;
    if ([[UIScreen mainScreen] bounds].size.height>480.00)
    {
        kdetailPlanViewController=[[kaplanMingXiaoDetailPlanViewController alloc] initWithNibName:@"kaplanMingXiaoDetailPlanViewController_4" bundle:nil];
    }
    else
    {
        kdetailPlanViewController=[[kaplanMingXiaoDetailPlanViewController alloc] initWithNibName:@"kaplanMingXiaoDetailPlanViewController" bundle:nil];
    }

    NSString *selected=[displayCNArray objectAtIndex:indexPath.row];
    [kdetailPlanViewController reloadSchoolDetail:[schoolIDArray objectAtIndex:[schoolsArrayCH indexOfObject:selected]]];
    [self.navigationController pushViewController:kdetailPlanViewController animated:YES];
    
    
}
- (IBAction)backToMainView:(id)sender
{
    [MingXiaoBoLanDelegate showBackView:nil];
}

- (IBAction)exitKeyBoard:(id)sender
{
    [sender resignFirstResponder];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"111");
    CGRect frame = textField.frame;
    int offset = self.view.frame.size.height-216-self.SearchView.frame.size.height+12
    ;//键盘高度216
    NSLog(@"%d",offset);
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.SearchView.frame = CGRectMake(0.0f, offset, self.SearchView.frame.size.width, self.SearchView.frame.size.height);
    
    [UIView commitAnimations];
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"didEndEditing");
    self.SearchView.frame =CGRectMake(0, self.view.frame.size.height-self.SearchView.frame.size.height/2, self.SearchView.frame.size.width, self.SearchView.frame.size.height);
}- (void)didReceiveMemoryWarning
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
