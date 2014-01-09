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
#import "UIScrollView+AH3DPullRefresh.h"

@interface kaplanNewsListViewController ()

@end

@implementation kaplanNewsListViewController
@synthesize NewsTableView,CustomNavBar;
@synthesize NewsListDelegate;
@synthesize newsListChildViewController;

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
        currentPage=1;
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
    currentPage=1;
   /*
    [self.NewsTableView setPullToRefreshHandler:^{
        NSArray *newImage=[NSArray arrayWithObject:@"blank"];
        [self performSelector:@selector(doneLoadingTableViewData) withObject:newImage afterDelay:0.1];
    }];
    */
    if ([[UIScreen mainScreen] bounds].size.height>480.00)
    {
        newsListChildViewController=[[kaplanNewsListChildViewController alloc] initWithNibName:@"kaplanNewsListChildViewController_4" bundle:nil];
    }else
    {
                newsListChildViewController=[[kaplanNewsListChildViewController alloc] initWithNibName:@"kaplanNewsListChildViewController" bundle:nil];
    }

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
     kaplanServerHelper *serverHelper=[kaplanServerHelper sharekaplanServerHelper];
    if ([serverHelper connectedToNetwork]) {
        if ([newsTitleArray count]<=0) {
            // [SVProgressHUD showWithStatus:@"载入中，请稍等"];
            kaplanServerHelper *serverHelper=[kaplanServerHelper sharekaplanServerHelper];
            NSArray *loadArray=[[NSArray alloc] initWithArray:[serverHelper LoadListAtPage:currentPage]];
            for (NSDictionary *newInfo in loadArray) {
                [newsidArray addObject:[newInfo objectForKey:@"id"]];
                [newsTitleArray addObject:[newInfo objectForKey:@"title"]];
                if ([newInfo objectForKey:@"intro"]!=nil) {
                    [newsPreArray addObject:[newInfo objectForKey:@"intro"]];
                }else
                {NSLog(@"intro NULL");
                    [newsPreArray addObject:@"NULL"];
                }
                        NSLog(@"is %@",[newInfo objectForKey:@"picUrl"]);
                if (![[newInfo objectForKey:@"picUrl"] isEqualToString:@""]) {
                    [newsImageArray addObject:[NSString stringWithFormat:@"http://kaplan.douho.net%@",[newInfo objectForKey:@"picUrl"]]];
                }else
                {NSLog(@"picUrl NULL");
                    [newsImageArray addObject:@"NULL"];
                }
                
            }
            [self.NewsTableView beginUpdates];
            [self.NewsTableView reloadData];
            [self.NewsTableView endUpdates];
            // [SVProgressHUD dismissWithSuccess:@"读取完成"];
        }
    }

}

- (void)doneLoadingTableViewData{
    NSLog(@"===加载完数据");
     [self.NewsTableView refreshFinished];
    NSLog(@"%d",currentPage);
    kaplanServerHelper *serverHelper=[kaplanServerHelper sharekaplanServerHelper];
    NSArray *loadArray=[[NSArray alloc] initWithArray:[serverHelper LoadListAtPage:currentPage+1]];
    if ([loadArray count]>0) {
        for (NSDictionary *newInfo in loadArray) {
        
             if (![newsidArray containsObject:[newInfo objectForKey:@"id"]]) {
             [newsidArray addObject:[newInfo objectForKey:@"id"]];
             [newsTitleArray addObject:[newInfo objectForKey:@"title"]];
             if ([newInfo objectForKey:@"intro"]!=nil) {
             [newsPreArray addObject:[newInfo objectForKey:@"intro"]];
             }else
             {NSLog(@"intro NULL");
             [newsPreArray addObject:@"NULL"];
             }
             
             if (![[newInfo objectForKey:@"picUrl"] isEqualToString:@""]) {
             [newsImageArray addObject:[NSString stringWithFormat:@"http://kaplan.douho.net%@",[newInfo objectForKey:@"picUrl"]]];
             }else
             {NSLog(@"picUrl NULL");
             [newsImageArray addObject:@"NULL"];
             }
             
             }else
             {
                 
                 NSLog(@"跳出");
                 [SVProgressHUD dismiss];
                 return;
             }
            /*
            [newsidArray addObject:[newInfo objectForKey:@"id"]];
            [newsTitleArray addObject:[newInfo objectForKey:@"title"]];
            if ([newInfo objectForKey:@"intro"]!=nil) {
                [newsPreArray addObject:[newInfo objectForKey:@"intro"]];
            }else
            {NSLog(@"intro NULL");
                [newsPreArray addObject:@"NULL"];
            }
            
            if (![[newInfo objectForKey:@"picUrl"] isEqualToString:@""]) {
                [newsImageArray addObject:[NSString stringWithFormat:@"http://kaplan.douho.net%@",[newInfo objectForKey:@"picUrl"]]];
            }else
            {NSLog(@"picUrl NULL");
                [newsImageArray addObject:@"NULL"];
            }*/
            
        }
        [self.NewsTableView reloadData];
        currentPage+=1;
        /*
         [self.NewsTableView beginUpdates];
         [self.NewsTableView reloadData];
         [self.NewsTableView endUpdates];
         */
        [SVProgressHUD dismiss];
        CGPoint point=CGPointMake(0,self.NewsTableView.contentSize.height-self.NewsTableView.frame.size.height);
        [self.NewsTableView setContentOffset:point animated:YES];


    }else
    {
        [SVProgressHUD dismiss];
    }
        
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"%f %f",scrollView.contentOffset.y,scrollView.contentSize.height - scrollView.frame.size.height);
    if(scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height))&&scrollView.contentOffset.y>0)
        
    {
        [self loadDataBegin];
    }
    
}
- (void) loadDataBegin

{
        
[SVProgressHUD showWithStatus:@"正在加载"];
        
        
    
      //  [self doneLoadingTableViewData];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==[newsidArray count]-1) {
        return 40;
    }return 0;
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
    if (![[newsImageArray objectAtIndex:indexPath.row] isEqualToString:@"NULL"])
    {
        NSLog(@"98989898");
        return 98;
    }else
    {
        return 58;

    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    UIImageView *iconImg=[[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 15, 15)];
    iconImg.image=[UIImage imageNamed:@"dot"];
    [cell.contentView addSubview:iconImg];
    UILabel *newTitle=[[UILabel alloc] initWithFrame:CGRectMake(35, 0, 240, 40)];
    newTitle.textColor=[UIColor whiteColor];
    newTitle.font=[UIFont systemFontOfSize:14.0];
    newTitle.backgroundColor=[UIColor clearColor];
    NSString *nameString=[NSString stringWithFormat:@"%@",[newsTitleArray objectAtIndex:indexPath.row]];
    newTitle.text=[nameString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];    [newTitle setNumberOfLines:0];
    [cell.contentView addSubview:newTitle];
    if (![[newsImageArray objectAtIndex:indexPath.row] isEqualToString:@"NULL"]) {
        UIImageView *newImg=[[UIImageView alloc] initWithFrame:CGRectMake(15, 45, 66, 45)];
        NSString *url=[newsImageArray objectAtIndex:indexPath.row];
        NSLog(url);
        [cell.contentView addSubview:newImg];
        UIImageFromURL( [NSURL URLWithString:url], ^( UIImage * image )
                       {
                           [newImg setImage:image];
                       }, ^(void){
                       });
        UIFont *font = [UIFont fontWithName:@"Arial" size:12];
        UILabel *newPre=[[UILabel alloc] initWithFrame:CGRectMake(95, 20, 180, 90)];
        newPre.lineBreakMode=NSLineBreakByCharWrapping;
        [newPre setNumberOfLines:2];
        [newPre setFont:font];
        newPre.textColor=[UIColor greenColor];
        //newPre.textColor=[UIColor colorWithRed:0.02 green:0.199 blue:0.108 alpha:1.0];
        NSString *preString=[NSString stringWithFormat:@"%@",[newsTitleArray objectAtIndex:indexPath.row]];
        newPre.text=[preString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        newPre.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:newPre];
        UIImageView *customSeparator=[[UIImageView alloc] initWithFrame:CGRectMake(14, 97, 282, 1)];
        [customSeparator setImage:[UIImage imageNamed:@"line.png"]];
        [cell.contentView addSubview:customSeparator];
        
    }else
    {
     UIFont *font = [UIFont fontWithName:@"Arial" size:11];
    UILabel *newPre=[[UILabel alloc] initWithFrame:CGRectMake(40, 18, 240, 60)];
    newPre.lineBreakMode=NSLineBreakByCharWrapping;
    [newPre setNumberOfLines:1];
    [newPre setFont:font];
    newPre.textColor=[UIColor greenColor];
    NSString *preString=[NSString stringWithFormat:@"%@",[newsTitleArray objectAtIndex:indexPath.row]];
    newPre.text=[preString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    newPre.backgroundColor=[UIColor clearColor];
    [cell.contentView addSubview:newPre];
    UIImageView *customSeparator=[[UIImageView alloc] initWithFrame:CGRectMake(14, 57, 282, 1)];
        customSeparator.image=[UIImage imageNamed:@"line"];
    [cell addSubview:customSeparator];
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"yahoo!!");

    
    [self.navigationController pushViewController:newsListChildViewController animated:YES];
    //[newsChild reloadNewInfomation:[newsTitleArray objectAtIndex:indexPath.row] text:[newsPreArray objectAtIndex:indexPath.row] andImage:[newsImageArray objectAtIndex:indexPath.row]];
    //[newsChild reloadNewInfomation:[newsTitleArray objectAtIndex:indexPath.row] text:[newsPreArray objectAtIndex:indexPath.row] andImage:[newsImageArray objectAtIndex:indexPath.row]];
    [newsListChildViewController reloadNewInfomationByID:[newsidArray objectAtIndex:indexPath.row]];
    
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
