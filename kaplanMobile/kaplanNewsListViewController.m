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
#import "SVProgressHUD.h"
#import "kaplanServerHelper.h"

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
    [self.navigationController setNavigationBarHidden:YES];
    newsidArray=[[NSMutableArray alloc] initWithCapacity:0];
    newsTitleArray=[[NSMutableArray alloc] initWithCapacity:0];
    newsPreArray=[[NSMutableArray alloc]initWithCapacity:0];
    newsImageArray=[[NSMutableArray alloc] initWithCapacity:0];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    if ([newsTitleArray count]<=0) {
        // [SVProgressHUD showWithStatus:@"载入中，请稍等"];
        kaplanServerHelper *serverHelper=[kaplanServerHelper sharekaplanServerHelper];
        NSArray *loadArray=[[NSArray alloc] initWithArray:[serverHelper LoadListAtPage:1]];
        for (NSDictionary *newInfo in loadArray) {
            [newsidArray addObject:[newInfo objectForKey:@"id"]];
            [newsTitleArray addObject:[newInfo objectForKey:@"title"]];
            if ([newInfo objectForKey:@"intro"]!=nil) {
                [newsPreArray addObject:[newInfo objectForKey:@"intro"]]; 
            }else
            {NSLog(@"intro NULL");
            [newsPreArray addObject:@"NULL"];
            }
            [newsImageArray addObject:[NSString stringWithFormat:@"http://cd.douho.net%@",[newInfo objectForKey:@"picUrl"]]];
        }
        [self.NewsTableView beginUpdates];
        [self.NewsTableView reloadData];
        [self.NewsTableView endUpdates];
       // [SVProgressHUD dismissWithSuccess:@"读取完成"];
    }
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
    if (![[newsImageArray objectAtIndex:indexPath.row]isEqualToString:@""]) {
        UIImageView *newImg=[[UIImageView alloc] initWithFrame:CGRectMake(40, 35, 66, 45)];
        NSString *url=[newsImageArray objectAtIndex:indexPath.row];
        [cell.contentView addSubview:newImg];
        UIImageFromURL( [NSURL URLWithString:url], ^( UIImage * image )
                       {
                           [newImg setImage:image];
                       }, ^(void){
                       });
        UIFont *font = [UIFont fontWithName:@"Arial" size:12];
        UILabel *newPre=[[UILabel alloc] initWithFrame:CGRectMake(120, 20, 160, 90)];
        newPre.lineBreakMode=NSLineBreakByCharWrapping;
        [newPre setNumberOfLines:2];
        [newPre setFont:font];
        newPre.textColor=[UIColor greenColor];
        NSString *preString=[NSString stringWithFormat:@"%@",[newsPreArray objectAtIndex:indexPath.row]];
        newPre.text=[preString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        newPre.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:newPre];
        UIImageView *customSeparator=[[UIImageView alloc] initWithFrame:CGRectMake(14, 97, 282, 1)];
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
    //[newsChild reloadNewInfomation:[newsTitleArray objectAtIndex:indexPath.row] text:[newsPreArray objectAtIndex:indexPath.row] andImage:[newsImageArray objectAtIndex:indexPath.row]];
    //[newsChild reloadNewInfomation:[newsTitleArray objectAtIndex:indexPath.row] text:[newsPreArray objectAtIndex:indexPath.row] andImage:[newsImageArray objectAtIndex:indexPath.row]];
    [newsChild reloadNewInfomationByID:[newsidArray objectAtIndex:indexPath.row]];
    
}
- (IBAction)bactToMainView:(id)sender
{
    [NewsListDelegate showBackView:nil];
}
void UIImageFromURL( NSURL * URL, void (^imageBlock)(UIImage * image), void (^errorBlock)(void) )
{
    dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^(void)
                   {
                       NSData * data = [[NSData alloc] initWithContentsOfURL:URL] ;
                       UIImage * image = [[UIImage alloc] initWithData:data];
                       dispatch_async( dispatch_get_main_queue(), ^(void){
                           if( image != nil )
                           {
                               imageBlock( image );
                           } else {
                               errorBlock();
                           }
                       });
                   });
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
