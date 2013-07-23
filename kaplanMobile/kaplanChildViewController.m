//
//  kaplanNewsListChildViewController.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-22.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanChildViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "kaplanServerHelper.h"
#import "UIMenuBar.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "kaplanSinaWeiBodelgate.h"
@interface kaplanChildViewController ()

@end

@implementation kaplanChildViewController

@synthesize CustomNavBar;
@synthesize newsImageURL,newsWebView,newsImageView,newsTitle,shareView;
static kaplanChildViewController *sharekaplanChildViewController = nil;
+(kaplanChildViewController*)sharekaplanChildViewController;
{
    if (sharekaplanChildViewController == nil) {
        sharekaplanChildViewController = [[super allocWithZone:NULL] init];
    }
    return sharekaplanChildViewController;
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
        self.newsTitle.textColor=[UIColor whiteColor];
        self.newsTitle.backgroundColor=[UIColor clearColor];
        self.newsTitle.numberOfLines=0;
        newsWebView.backgroundColor=[UIColor clearColor];
        newsWebView.opaque = NO;
        newsWebView.scrollView.scrollEnabled=YES;
        [newsWebView.scrollView setShowsVerticalScrollIndicator:NO];
        [newsWebView.scrollView setShowsHorizontalScrollIndicator:NO];
        for (UIView *subView in [self.newsWebView  subviews]) {
            if ([subView isKindOfClass:[UIScrollView class]]) {
                for (UIView *shadowView in [subView subviews]) {
                    if ([shadowView isKindOfClass:[UIImageView class]]) {
                        shadowView.hidden = YES;
                    }
                }
            }
        }
        self.shareView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_bar"]];
        self.newsImageView.frame=CGRectMake(5, 0, newsImageView.frame.size.width, newsImageView.frame.size.height);
        [newsWebView.scrollView addSubview:self.newsImageView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


}

-(void)reloadNewInfomationByID:(NSString *)newID
{
    kaplanServerHelper *serverHelper=[kaplanServerHelper sharekaplanServerHelper];
    NSMutableDictionary *newDetail=[[NSMutableDictionary alloc] initWithDictionary:[serverHelper getNewDetailByID:newID]];
    NSString *newTitle=[NSString stringWithFormat:@"%@",[newDetail objectForKey:@"title"]];
    [self.newsTitle setText:[newTitle stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "]];
   // [self.newsWebView loadHTMLString:[newDetail objectForKey:@"newsText"] baseURL:nil];
    if (![[newDetail objectForKey:@"picUrl"] isEqualToString:@""])
    {
        NSLog(@"NULL");
        //NSLog(@"%@",[newDetail objectForKey:@"newsText"]);
        NSString *jsString = [NSString stringWithFormat:@"<html>"
                              "<head> "
                              "<style type=\"text/css\"> "
                              //"p{ color:#fff｝"
                              "img{ max-width:65px; max-height:85px; }"
                              "body {font-size: %f;; color: %@;}"
                              "a{color:#ccc}"
                              "</style>"
                              "</head>"
                              "<body><p><br/><br/><br/><br/><br/><br/><br/><br/><br/></P>%@</body>"
                              "</html>", 11.0, @"#fff",[newDetail objectForKey:@"newsText"]];
        jsString=[jsString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        
        [newsWebView loadHTMLString:[jsString stringByReplacingOccurrencesOfString:@"/File" withString:@"http://cd.douho.net/File"] baseURL:nil];
        NSLog(@"HTML CODE%@",[jsString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "]);
        self.newsImageURL=[newDetail objectForKey:@"picUrl"];
        NSString *url=[NSString stringWithFormat:@"http://cd.douho.net%@",self.newsImageURL];
        newImageFromURL( [NSURL URLWithString:url], ^( UIImage * image )
                        {
                            [self.newsImageView setImage:image];
                        }, ^(void){
                        });
    }else
    {
        NSLog(@"%@",[newDetail objectForKey:@"newsText"]);
        NSString *jsString = [NSString stringWithFormat:@"<html>"
                              "<head> "
                              "<style type=\"text/css\"> "
                              "body {font-size: %f;; color: %@;}"
                              "a{color:#ccc}"
                              "</style>"
                              "</head>"
                              "<body>%@</body>"
                              "</html>", 14.0, @"#fff", [newDetail objectForKey:@"newsText"]];
        jsString=[jsString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        
        [newsWebView loadHTMLString:[jsString stringByReplacingOccurrencesOfString:@"/File" withString:@"http://cd.douho.net/File"] baseURL:nil];
        [self.newsImageView setImage:nil];
        //self.newsWebView.frame=CGRectMake(46, self.view., <#CGFloat width#>, <#CGFloat height#>)
    }

         
}
-(void)reloadRemotoNotificationByTitle:(NSString *)title
{
    kaplanServerHelper *serverHelper=[kaplanServerHelper sharekaplanServerHelper];
    NSMutableDictionary *newDetail=[[NSMutableDictionary alloc] initWithDictionary:[serverHelper getRemotoNotification:title]];
    NSString *newTitle=[NSString stringWithFormat:@"%@",[newDetail objectForKey:@"title"]];
    
    [self.newsTitle setText:[newTitle stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "]];
    // [self.newsWebView loadHTMLString:[newDetail objectForKey:@"newsText"] baseURL:nil];
    if (![[newDetail objectForKey:@"picUrl"] isEqualToString:@""])
    {
        NSLog(@"NULL");
        //NSLog(@"%@",[newDetail objectForKey:@"newsText"]);
        NSString *jsString = [NSString stringWithFormat:@"<html>"
                              "<head> "
                              "<style type=\"text/css\"> "
                              //"p{ color:#fff｝"
                              "img{ max-width:65px; max-height:85px; }"
                              "body {font-size: %f;; color: %@;}"
                              "a{color:#ccc}"
                              "</style>"
                              "</head>"
                              "<body><p><br/><br/><br/><br/><br/><br/><br/><br/><br/></P>%@</body>"
                              "</html>", 11.0, @"#fff",[newDetail objectForKey:@"newsText"]];
        jsString=[jsString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        
        [newsWebView loadHTMLString:[jsString stringByReplacingOccurrencesOfString:@"/File" withString:@"http://cd.douho.net/File"] baseURL:nil];
        NSLog(@"HTML CODE%@",[jsString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "]);
        self.newsImageURL=[newDetail objectForKey:@"picUrl"];
        NSString *url=[NSString stringWithFormat:@"http://cd.douho.net%@",self.newsImageURL];
        newImageFromURL( [NSURL URLWithString:url], ^( UIImage * image )
                        {
                            [self.newsImageView setImage:image];
                        }, ^(void){
                        });
    }else
    {
        NSLog(@"%@",[newDetail objectForKey:@"newsText"]);
        NSString *jsString = [NSString stringWithFormat:@"<html>"
                              "<head> "
                              "<style type=\"text/css\"> "
                              "body {font-size: %f;; color: %@;}"
                              "a{color:#ccc}"
                              "</style>"
                              "</head>"
                              "<body>%@</body>"
                              "</html>", 14.0, @"#fff", [newDetail objectForKey:@"newsText"]];
        jsString=[jsString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        
        [newsWebView loadHTMLString:[jsString stringByReplacingOccurrencesOfString:@"/File" withString:@"http://cd.douho.net/File"] baseURL:nil];
        [self.newsImageView setImage:nil];
        //self.newsWebView.frame=CGRectMake(46, self.view., <#CGFloat width#>, <#CGFloat height#>)
    }
    
}

- (IBAction)backToParentView:(id)sender
{
    NSLog(@"removeFromParentViewController");
    [self dismissViewControllerAnimated:YES completion:nil];
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
    NSString *string=[NSString stringWithFormat:@"我在Kaplan官方客户端上发现了%@",self.newsTitle.text];
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
        message.description =[NSString stringWithFormat:@"我在kaplan官方手机端上发现了 %@",self.newsTitle.text];
        [message setThumbImage:[UIImage imageNamed:@"Icon"]];
        WXAppExtendObject *appExt=[WXAppExtendObject object];
        [appExt setExtInfo:[NSString stringWithFormat:@"我在kaplan官方手机端上发现了 %@",self.newsTitle.text]];
        message.mediaObject =appExt;
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = YES;
        req.text=[NSString stringWithFormat:@"我在kaplan官方手机端上发现了 %@的消息.",newsTitle.text];
        //req.message = message;
        req.scene = WXSceneTimeline;
        [WXApi sendReq:req];
    }else{
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:@"你的iPhone上还没有安装微信,无法使用此功能，使用微信可以方便的把你喜欢的东西分享给好友。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"免费下载微信", nil];
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
    [self setShareView:nil];
    [self setNewsWebView:nil];
    [self setNewsImageView:nil];
    [self setNewsWebView:nil];
    [self setNewsImageView:nil];
    [self setNewsTitle:nil];
    [super viewDidUnload];
}
@end
