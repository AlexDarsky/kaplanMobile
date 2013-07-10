//
//  kaplanMingXiaoDetailPlanViewController.m
//  kaplanMobile
//
//  Created by linchuan on 6/21/13.
//  Copyright (c) 2013 AlexZhu. All rights reserved.
//

#import "kaplanMingXiaoDetailPlanViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "kaplanServerHelper.h"
#import "animationImageView.h"
#import "SinaWeibo.h"
#import "kaplanSinaWeiBodelgate.h"

@interface kaplanMingXiaoDetailPlanViewController ()

@end

@implementation kaplanMingXiaoDetailPlanViewController
@synthesize CustomNavBar,tableView,ShareView;
@synthesize schoolNameCN,schoolNameEN,schoolTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_inside.png"]];
        self.CustomNavBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
        [self.CustomNavBar layer].shadowPath =[UIBezierPath bezierPathWithRect:self.CustomNavBar.bounds].CGPath;
        self.CustomNavBar.layer.shadowColor=[[UIColor blackColor] CGColor];
        self.CustomNavBar.layer.shadowOffset=CGSizeMake(0,0);
        self.CustomNavBar.layer.shadowRadius=10.0;
        self.CustomNavBar.layer.shadowOpacity=1.0;
        self.ShareView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_bar"]];

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
    [self.navigationController setNavigationBarHidden:YES];
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
   // [self setSchoolIconImage:@"SanDomenico.jpg"];
    [self.tableView reloadData];
}
-(void)reloadSchoolDetail:(NSString*)schoolID
{
    kaplanServerHelper *serverHelper=[kaplanServerHelper sharekaplanServerHelper];
    NSDictionary *schoolDetail=[[NSDictionary alloc] initWithDictionary:[serverHelper getSchoolDetail:schoolID]];
    NSString *nameString=[schoolDetail objectForKey:@"schoolCnName"];
     NSArray *nameArray=[nameString componentsSeparatedByString:@"("];
    [self setSchoolNameCN:[nameArray objectAtIndex:0]];
    [self setSchoolNameEN:[nameArray lastObject]];
    if ([schoolDetail objectForKey:@"intro"]!=nil) {
        [self setSchoolTextView:[schoolDetail objectForKey:@"intro"]];
    }else
        [self setSchoolTextView:@""];
    if ([schoolDetail objectForKey:@"areaName"]!=nil) {
         [self setAreaName:[schoolDetail objectForKey:@"areaName"]];
    }else
        [self setAreaName:@""];
    if ([schoolDetail objectForKey:@"cityName"]!=nil) {
        [self setCityName:[schoolDetail objectForKey:@"cityName"]];
    }else
            [self setCityName:@""];
    if ([schoolDetail objectForKey:@"createYear"]!=nil)
    {
        [self setCreateYear:[schoolDetail objectForKey:@"createYear"]];
    }else
        [self setCreateYear:@""];
    if ([schoolDetail objectForKey:@"timeRankNo"]!=nil) {
        [self setTimeRankNo:[schoolDetail objectForKey:@"timeRankNo"]];
    }else
            [self setTimeRankNo:@""];
    if ([schoolDetail objectForKey:@"rankInfo"]!=nil) {
            [self setRankInfo:[schoolDetail objectForKey:@"rankInfo"]];
    }else
            [self setRankInfo:@""];
    if ([schoolDetail objectForKey:@"address"]!=nil) {
        [self setAddress:[schoolDetail objectForKey:@"address"]];
    }else
        [self setAddress:@""];
    if ([schoolDetail objectForKey:@"poseCode"]!=nil) {
        [self setPoseCode:[schoolDetail objectForKey:@"poseCode"]];
    }else
        [self setPoseCode:@""];
    if ([schoolDetail objectForKey:@"employmentRate"]!=nil) {
        [self setEmploymentRate:[schoolDetail objectForKey:@"employmentRate"]];
    }else
        [self setEmploymentRate:[schoolDetail objectForKey:@"employmentRate"]];
    
    if ([schoolDetail objectForKey:@"webSite"]!=nil) {
            [self setWebSite:[schoolDetail objectForKey:@"webSite"]];
    }else
            [self setWebSite:@""];
    [self.tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return 53;
    }
    if (indexPath.row==1||indexPath.row==2||indexPath.row==3||indexPath.row==4||indexPath.row==7||indexPath.row==6||indexPath.row==8||indexPath.row==9)
    {
        return 20;
    }
    if (indexPath.row==5||indexPath.row==10||indexPath.row==11) {
        return 50;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc] init];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    switch (indexPath.row) {
        case 0:
        {
            UILabel *txtlCH=[[UILabel alloc] init];
            txtlCH.frame=CGRectMake(50, 1, cell.contentView.frame.size.width, cell.contentView.frame.size.height);
            txtlCH.backgroundColor=[UIColor clearColor];
            txtlCH.font=[UIFont fontWithName:@"Arial Hebrew" size:16];
            txtlCH.textColor=[UIColor whiteColor];
            [txtlCH setText:schoolNameCN];
            [cell addSubview:txtlCH];
            
            UILabel *txtlEN=[[UILabel alloc] init];
            txtlEN.frame=CGRectMake(50, 20, cell.contentView.frame.size.width, cell.contentView.frame.size.height);
            txtlEN.backgroundColor=[UIColor clearColor];
            txtlEN.font=[UIFont fontWithName:@"Arial Hebrew" size:12];
            txtlEN.textColor=[UIColor greenColor];
            [txtlEN setText:schoolNameEN];
            [cell addSubview:txtlEN];
            UIImageView *dotView=[[UIImageView alloc] initWithFrame:CGRectMake(30, 20, 15, 15)];
            [dotView setImage:[UIImage imageNamed:@"dot.png"]];
            [cell addSubview:dotView];
        }
            break;
        case 1:
        {
            UILabel *rowName=[[UILabel alloc] initWithFrame:CGRectMake(25, 0, 50, 20)];
            rowName.text=@"地区 :";
            rowName.textColor=[UIColor whiteColor];
            rowName.font=[UIFont systemFontOfSize:13.0];
            rowName.backgroundColor=[UIColor clearColor];
            [cell addSubview:rowName];
            UILabel *rowValue=[[UILabel alloc] initWithFrame:CGRectMake(65, 0, 60, 20)];
            rowValue.text=self.areaName;
            rowValue.textColor=[UIColor lightGrayColor];
            rowValue.font=[UIFont systemFontOfSize:12.0];
            rowValue.backgroundColor=[UIColor clearColor];
            [cell addSubview:rowValue];
        }
            break;
        case 2:
        {
            UILabel *rowName=[[UILabel alloc] initWithFrame:CGRectMake(25, 0, 50, 20)];
            rowName.text=@"城市 :";
            rowName.textColor=[UIColor whiteColor];
            rowName.font=[UIFont systemFontOfSize:13.0];
            rowName.backgroundColor=[UIColor clearColor];
            [cell addSubview:rowName];
            UILabel *rowValue=[[UILabel alloc] initWithFrame:CGRectMake(65, 0, 100, 20)];
            rowValue.text=self.cityName;
            rowValue.textColor=[UIColor lightGrayColor];
            rowValue.font=[UIFont systemFontOfSize:12.0];
            rowValue.backgroundColor=[UIColor clearColor];
            [cell addSubview:rowValue];
        }
            break;
        case 3:
        {
            UILabel *rowName=[[UILabel alloc] initWithFrame:CGRectMake(25, 0, 80, 20)];
            rowName.text=@"创建时间 :";
            rowName.textColor=[UIColor whiteColor];
            rowName.font=[UIFont systemFontOfSize:13.0];
            rowName.backgroundColor=[UIColor clearColor];
            [cell addSubview:rowName];
            UILabel *rowValue=[[UILabel alloc] initWithFrame:CGRectMake(80, 0, 100, 20)];
            rowValue.text=self.createYear;
            rowValue.textColor=[UIColor lightGrayColor];
            rowValue.font=[UIFont systemFontOfSize:12.0];
            rowValue.backgroundColor=[UIColor clearColor];
            [cell addSubview:rowValue];
        }
            break;
        case 4:
        {
            UILabel *rowName=[[UILabel alloc] initWithFrame:CGRectMake(25, 0, 50, 20)];
            rowName.text=@"排名 :";
            rowName.textColor=[UIColor whiteColor];
            rowName.font=[UIFont systemFontOfSize:13.0];
            rowName.backgroundColor=[UIColor clearColor];
            [cell addSubview:rowName];
            UILabel *rowValue=[[UILabel alloc] initWithFrame:CGRectMake(65, 0, 100, 20)];
            rowValue.text=self.timeRankNo;
            rowValue.textColor=[UIColor lightGrayColor];
            rowValue.font=[UIFont systemFontOfSize:12.0];
            rowValue.backgroundColor=[UIColor clearColor];
            [cell addSubview:rowValue];
        }
            break;
        case 5:
        {
            UILabel *rowName=[[UILabel alloc] initWithFrame:CGRectMake(25, 0, 80, 20)];
            rowName.text=@"其他排名 :";
            rowName.textColor=[UIColor whiteColor];
            rowName.font=[UIFont systemFontOfSize:13.0];
            rowName.backgroundColor=[UIColor clearColor];
            [cell addSubview:rowName];
            UITextView *rowValue=[[UITextView alloc] initWithFrame:CGRectMake(80, -5, 200, 50)];
            rowValue.backgroundColor=[UIColor clearColor];
            NSString *rowString=[self.rankInfo stringByReplacingOccurrencesOfString:@"<br/>" withString:@","];
            [rowValue setText:rowString];
            [rowValue setTextColor:[UIColor lightGrayColor]];
            rowValue.font=[UIFont systemFontOfSize:12.0];
            rowValue.editable=NO;
            [cell addSubview:rowValue];
        }
            break;
        case 6:
        {
            UILabel *rowName=[[UILabel alloc] initWithFrame:CGRectMake(25, 0, 80, 20)];
            rowName.text=@"学校地址 :";
            rowName.textColor=[UIColor whiteColor];
            rowName.font=[UIFont systemFontOfSize:13.0];
            rowName.backgroundColor=[UIColor clearColor];
            [cell addSubview:rowName];
            UILabel *rowValue=[[UILabel alloc] initWithFrame:CGRectMake(90, 0, 200, 20)];
            rowValue.text=self.address;
            rowValue.adjustsFontSizeToFitWidth=YES;
            rowValue.textColor=[UIColor lightGrayColor];
            rowValue.font=[UIFont systemFontOfSize:12.0];
            rowValue.backgroundColor=[UIColor clearColor];
            [cell addSubview:rowValue];

        }
            break;
        case 7:
        {
            UILabel *rowName=[[UILabel alloc] initWithFrame:CGRectMake(25, 0, 50, 20)];
            rowName.text=@"邮编 :";
            rowName.textColor=[UIColor whiteColor];
            rowName.font=[UIFont systemFontOfSize:13.0];
            rowName.backgroundColor=[UIColor clearColor];
            [cell addSubview:rowName];
            UILabel *rowValue=[[UILabel alloc] initWithFrame:CGRectMake(65, 0, 200, 20)];
            rowValue.text=self.poseCode;
            rowValue.textColor=[UIColor lightGrayColor];
            rowValue.font=[UIFont systemFontOfSize:12.0];
            rowValue.backgroundColor=[UIColor clearColor];
            [cell addSubview:rowValue];

        }
            break;
        case 8:
        {
            UILabel *rowName=[[UILabel alloc] initWithFrame:CGRectMake(25, 0, 65, 20)];
            rowName.text=@"升学率 :";
            rowName.textColor=[UIColor whiteColor];
            rowName.font=[UIFont systemFontOfSize:13.0];
            rowName.backgroundColor=[UIColor clearColor];
            [cell addSubview:rowName];
            UILabel *rowValue=[[UILabel alloc] initWithFrame:CGRectMake(75, 0, 200, 20)];
            rowValue.text=self.employmentRate;
            rowValue.textColor=[UIColor lightGrayColor];
            rowValue.font=[UIFont systemFontOfSize:12.0];
            rowValue.backgroundColor=[UIColor clearColor];
            [cell addSubview:rowValue];
        }
            break;
        case 9:
        {
            UILabel *rowName=[[UILabel alloc] initWithFrame:CGRectMake(25, 0, 80, 20)];
            rowName.text=@"学校网址 :";
            rowName.textColor=[UIColor whiteColor];
            rowName.font=[UIFont systemFontOfSize:13.0];
            rowName.backgroundColor=[UIColor clearColor];
            [cell addSubview:rowName];
            UILabel *rowValue=[[UILabel alloc] initWithFrame:CGRectMake(90, 0, 200, 20)];
            rowValue.text=self.webSite;
            rowValue.textColor=[UIColor blueColor];
            rowValue.font=[UIFont systemFontOfSize:12.0];
            rowValue.backgroundColor=[UIColor clearColor];
            [cell addSubview:rowValue];
        }
            break;
        case 10:
        {
            UILabel *rowName=[[UILabel alloc] initWithFrame:CGRectMake(25, 0, 80, 20)];
            rowName.text=@"学校简介 :";
            rowName.textColor=[UIColor whiteColor];
            rowName.font=[UIFont systemFontOfSize:13.0];
            rowName.backgroundColor=[UIColor clearColor];
            [cell addSubview:rowName];

            UITextView *schoolDescriptionTV=[[UITextView alloc] initWithFrame:CGRectMake(80, -5, 200, 50)];
            schoolDescriptionTV.backgroundColor=[UIColor clearColor];
            [schoolDescriptionTV setText:self.schoolTextView];
            [schoolDescriptionTV setTextColor:[UIColor lightGrayColor]];
            schoolDescriptionTV.font=[UIFont systemFontOfSize:12.0];
            schoolDescriptionTV.editable=NO;
            [cell.contentView addSubview:schoolDescriptionTV];


        }
            break;
        case 11:
        {
            UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(40, 0, 239, 31)];
            [backBtn addTarget:self action:@selector(backToParentView:) forControlEvents:UIControlEventTouchUpInside];
            [backBtn setImage:[UIImage imageNamed:@"btn_back1_s1"] forState:UIControlStateNormal];
            [cell.contentView addSubview:backBtn];
            
        }
            break;
    }
    if (indexPath.row==0) {
            }
    else
         if (indexPath.row==1) {
             
        }else
        {
                   }
            
    return cell;
    
}
void SchoolLogoFromURL( NSURL * URL, void (^imageBlock)(UIImage * image), void (^errorBlock)(void) )
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

#pragma mark - tableview delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==9) {
        NSString *url=[NSString stringWithFormat:@"http://%@",self.webSite];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

    }
}
-(IBAction)backToParentView:(id)sender
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
    NSString *string=[NSString stringWithFormat:@"我在Kaplan官方客户端上发现了%@，该校%@",self.schoolNameCN,schoolTextView];
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
        
        /*
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"kaplan官方客户端";
        message.description =[NSString stringWithFormat:@"我在kaplan官方手机端上发现了 %@,%@",self.schoolNameCN,self.schoolTextView];
        //UIImage *img=[[UIImage alloc] initWithContentsOfFile:@"Icon.png"];

        [message setThumbImage:[UIImage imageNamed:@"Icon.png"]];
        WXAppExtendObject *appExt=[WXAppExtendObject object];
        [appExt setExtInfo:[NSString stringWithFormat:@"%@",self.schoolTextView]];
        UIImage *img = [UIImage imageNamed:@"Icon.png"];
        NSData *dataObj = UIImageJPEGRepresentation(img, 1.0);
        WXImageObject *imgMessage=[WXImageObject object];
        imgMessage.imageData=dataObj;
        message.mediaObject =imgMessage;
        */
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = YES;
        req.text=[NSString stringWithFormat:@"我在kaplan官方手机端上发现了 %@,%@",self.schoolNameCN,self.schoolTextView];
        //req.message = message;
        req.scene = WXSceneTimeline;
        
        [WXApi sendReq:req];
    }else{
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:@"你的iPhone上还没有安装微信,无法使用此功能，使用微信可以方便的把你喜欢的作品分享给好友。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"免费下载微信", nil];
        [alView show];
        
    }
    

}
-(void)openBrower
{
    NSLog(@"touch");
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
