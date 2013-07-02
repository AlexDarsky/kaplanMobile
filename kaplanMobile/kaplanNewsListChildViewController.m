//
//  kaplanNewsListChildViewController.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-22.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanNewsListChildViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface kaplanNewsListChildViewController ()

@end

@implementation kaplanNewsListChildViewController
static kaplanNewsListChildViewController *sharekaplanNewsListChildViewController = nil;
@synthesize tableView,CustomNavBar;
@synthesize newsImageURL,newsTitleLabel,newsWebView;
+(kaplanNewsListChildViewController*)sharekaplanNewsListChildViewController
{
    if (sharekaplanNewsListChildViewController == nil) {
        sharekaplanNewsListChildViewController = [[super allocWithZone:NULL] init];
    }
    return sharekaplanNewsListChildViewController;
}
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
        newsTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(60, 10, 200, 20)];
        newsTitleLabel.textColor=[UIColor whiteColor];
        newsTitleLabel.backgroundColor=[UIColor clearColor];
        newsWebView=[[UIWebView alloc] init];
        newsWebView.backgroundColor=[UIColor clearColor];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


}
-(void)reloadNewInfomation:(NSString*)title text:(NSString*)newText andImage:(NSString*)newsImage
{
    NSLog(@"will reload");
    [self.newsTitleLabel setText:title];
    [self.newsWebView loadHTMLString:newText baseURL:nil];
    self.newsImageURL=newsImage;
    [self.tableView reloadData];
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 62.0;
    }else
    {
        return 381.0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    if (indexPath.row==0)
    {
        UIImageView *iconImg=[[UIImageView alloc] initWithFrame:CGRectMake(40, 10, 15, 15)];
        iconImg.image=[UIImage imageNamed:@"dot"];
        [cell.contentView addSubview:iconImg];
        [cell.contentView addSubview:newsTitleLabel];
        UIImageView *customSeparator=[[UIImageView alloc] initWithFrame:CGRectMake(14, 61, 282, 1)];
        customSeparator.image=[UIImage imageNamed:@"line"];
        [cell.contentView addSubview:customSeparator];
        
    }else
    {
        if (![self.newsImageURL isEqualToString:@"NULL"]) {
            UIImageView *newIV=[[UIImageView alloc] initWithFrame:CGRectMake(60, 10, 235, 131)];
            NSString *url=self.newsImageURL;
            [cell.contentView addSubview:newIV];
            newImageFromURL( [NSURL URLWithString:url], ^( UIImage * image )
                           {
                               [newIV setImage:image];
                           }, ^(void){
                           });

            self.newsWebView.frame=CGRectMake(60, 160, 235, 200);
            [cell.contentView addSubview:self.newsWebView];
           
            
        }else
        {
            self.newsWebView.frame=CGRectMake(60, 10, 235, 200);
            [cell.contentView addSubview:self.newsWebView];
     
        }
        UIImageView *customSeparator=[[UIImageView alloc] initWithFrame:CGRectMake(14, 380, 282, 1)];
        customSeparator.image=[UIImage imageNamed:@"line"];
        [cell.contentView addSubview:customSeparator];
        
    }
    return cell;
    
}
- (IBAction)backToParentView:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
void newImageFromURL( NSURL * URL, void (^imageBlock)(UIImage * image), void (^errorBlock)(void) )
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
    [self setTableView:nil];
    [self setCustomNavBar:nil];
    [super viewDidUnload];
}
@end
