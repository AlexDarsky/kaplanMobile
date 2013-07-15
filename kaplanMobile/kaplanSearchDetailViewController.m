//
//  kaplanSearchDetailViewController.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-7-4.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanSearchDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "kaplanSQLIteHelper.h"
#import "kaplanSinaWeiBodelgate.h"

@interface kaplanSearchDetailViewController ()

@end

@implementation kaplanSearchDetailViewController
@synthesize CustomNavBar,tableView,schoolCN,schoolEN,shareView;

static kaplanSearchDetailViewController *sharekaplanSearchDetailViewController = nil;
+(kaplanSearchDetailViewController*)sharekaplanSearchDetailViewController
{
    if (sharekaplanSearchDetailViewController == nil) {
        sharekaplanSearchDetailViewController = [[super allocWithZone:NULL] init];
    }
    return sharekaplanSearchDetailViewController;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_inside.png"]];
        self.CustomNavBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
        [self.navigationController setNavigationBarHidden:YES];
        
        [self.CustomNavBar layer].shadowPath =[UIBezierPath bezierPathWithRect:self.CustomNavBar.bounds].CGPath;
        self.CustomNavBar.layer.shadowColor=[[UIColor blackColor] CGColor];
        self.CustomNavBar.layer.shadowOffset=CGSizeMake(0,0);
        self.CustomNavBar.layer.shadowRadius=10.0;
        self.CustomNavBar.layer.shadowOpacity=1.0;
        self.shareView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_bar"]];
        listArray=[[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [listArray count];
}

-(void)loadSchoolAllClass:(NSString*)schoolName
{
    self.schoolCN.text=schoolName;
    self.schoolEN.text=@"浏览院校专业详情";
    if ([listArray count]>0) {
        [listArray removeAllObjects];
    }
    kaplanSQLIteHelper *sqliteHelper=[kaplanSQLIteHelper sharekaplanSQLIteHelper];
    NSMutableArray *tmpArray=[[NSMutableArray alloc] initWithArray:[sqliteHelper getSchoolAllClass:schoolName]];
    for (NSDictionary *tmpDic in tmpArray) {
        if ([tmpDic objectForKey:@"c4"]!=nil) {
            [listArray addObject:[tmpDic objectForKey:@"c4"]];

        }
           }
    [self.tableView reloadData];
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    UIImageView *customSeparator=[[UIImageView alloc] initWithFrame:CGRectMake(14, 30, 282, 1)];
    customSeparator.image=[UIImage imageNamed:@"line"];
    [cell.contentView addSubview:customSeparator];
    cell.textLabel.text=[NSString stringWithFormat:@"   ☸ %@",[listArray objectAtIndex:indexPath.row]];
    cell.textLabel.textColor=[UIColor lightGrayColor];
    return cell;
    
}

- (IBAction)backToParentView:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)shareBtn:(id)sender
{
    UIMenuBarItem *menuItem1 = [[UIMenuBarItem alloc] initWithTitle:@"分享到微信" target:self image:[UIImage imageNamed:@"micro_messenger.png"] action:@selector(shareToWeiXin)];
    UIMenuBarItem *menuItem2 = [[UIMenuBarItem alloc] initWithTitle:@"分享到新浪微博" target:self image:[UIImage imageNamed:@"sinaweibo"] action:@selector(shareToWeiBo)];
    NSMutableArray *items =
    //[NSMutableArray arrayWithObjects:menuItem1, menuItem2, menuItem3,nil];
    //[NSMutableArray arrayWithObjects:menuItem1, menuItem2, menuItem3,  menuItem4, menuItem5, menuItem6, nil];
    [NSMutableArray arrayWithObjects:menuItem1,menuItem2,nil];
    
    menuBar = [[UIMenuBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 240.0f) items:items];
    //menuBar.layer.borderWidth = 1.f;
    //menuBar.layer.borderColor = [[UIColor orangeColor] CGColor];
    //menuBar.tintColor = [UIColor orangeColor];
    menuBar.delegate = self;
    menuBar.items = [NSMutableArray arrayWithObjects:menuItem1,menuItem2,nil];
    
    [menuBar show];
    
}
-(void)shareToWeiBo
{
    NSLog(@"分享新浪微博");
    NSString *string=[NSString stringWithFormat:@"我在kaplan官方客户端上发现了%@。",self.schoolCN.text];
    
    NSDictionary *shareInfo=[[NSDictionary alloc] initWithObjectsAndKeys:string,@"title", nil];
    kaplanSinaWeiBodelgate *sinaWeiBodelgate=[kaplanSinaWeiBodelgate sharekaplanSinaWeiBodelgate];
    if ([sinaWeiBodelgate connectToSinaWeiBoWith:shareInfo]) {
        [menuBar dismiss];
    }
}
-(void)shareToWeiXin
{
    [menuBar dismiss];
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"kaplan名校分享";
        message.description =[NSString stringWithFormat:@"我在kaplan官方手机端上发现了 %@",self.schoolCN.text];
        [message setThumbImage:[UIImage imageNamed:@"Icon"]];
        WXAppExtendObject *appExt=[WXAppExtendObject object];
        [appExt setExtInfo:[NSString stringWithFormat:@"我在kaplan官方手机端上发现了 %@",self.schoolCN.text]];
        message.mediaObject =appExt;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = YES;
        req.text=[NSString stringWithFormat:@"我在kaplan官方手机端上发现了 %@.",schoolCN.text];
        //req.message = message;
        req.scene = WXSceneTimeline;
        
        [WXApi sendReq:req];
    }else{
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:@"你的iPhone上还没有安装微信,无法使用此功能，使用微信可以方便的把你喜欢的作品分享给好友。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"免费下载微信", nil];
        [alView show];
        
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCustomNavBar:nil];
    [self setTableView:nil];
    [self setSchoolCN:nil];
    [self setSchoolEN:nil];
    [super viewDidUnload];
}
@end
