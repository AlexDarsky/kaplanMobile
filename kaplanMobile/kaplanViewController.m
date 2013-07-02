//
//  kaplanViewController.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanViewController.h"
#import "kaplanMingXiaoBoLanViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "kaplanAboutViewController.h"
#import "kaplanNewsListViewController.h"
#import "kaplanSereachMainViewController.h"
#import "kaplanEvalutionViewController.h"
#import "DownloadManager.h"
#import "NSURL+Download.h"
#import "kaplanSettingViewController.h"
#import "kaplanServerHelper.h"
#define kDocumentFolder					[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] 
@class kaplanEvalutionViewController;
@interface kaplanViewController ()
{
    UIViewController *currentMainController;
    BOOL backViewShowing;
    CGFloat currentTranslate;
}
@property (strong,nonatomic)UIViewController  *backViewController;

@end

@implementation kaplanViewController

static kaplanViewController *kaplanRootViewCon;
@synthesize NavBackView,MainScrollView;
@synthesize tabBarController;
@synthesize evalutionNavCon,SchoolsViewNavCon,NewsViewNavCon,kaplanSettingViewCon,SettingViewNavCon;
@synthesize appVersionID,dbVerID;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        /*
        kaplanMingXiaoBoLanViewController *kaplanMingXiaoBoLanViewCon = [[kaplanMingXiaoBoLanViewController alloc] initWithNibName:@"kaplanMingXiaoBoLanViewController" bundle:nil];
        kaplanAboutViewController *kaplanAboutViewCon=[[kaplanAboutViewController alloc] initWithNibName:@"kaplanAboutViewController" bundle:nil];
        self.tabBarController=[[UITabBarController alloc] init];
        self.tabBarController.viewControllers=[NSArray arrayWithObjects:kaplanAboutViewCon,kaplanMingXiaoBoLanViewCon,nil];
        if (kaplanRootViewCon) {
            kaplanRootViewCon=nil;
        }
        kaplanRootViewCon=self;
        backViewShowing=NO;
        self.backViewController=tabBarController;
        [self.MainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_index" ]]];
        [self addChildViewController:self.backViewController];
        [self.NavBackView addSubview:self.backViewController.view];
         */
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

    kaplanSereachMainViewController *kaplanSereachMainViewCon=[[kaplanSereachMainViewController alloc] initWithNibName:@"kaplanSereachMainViewController" bundle:nil];
    kaplanSereachMainViewCon.SereachDelegate=self;
    kaplanNewsListViewController *kaplanNewsListViewCon=[[kaplanNewsListViewController alloc] initWithNibName:@"kaplanNewsListViewController" bundle:nil];
    kaplanNewsListViewCon.NewsListDelegate=self;
    NewsViewNavCon=[[UINavigationController alloc] initWithRootViewController:kaplanNewsListViewCon];
    NewsViewNavCon.navigationBarHidden=YES;
    
    kaplanEvalutionViewController *kaplanEvalutionViewCon=[[kaplanEvalutionViewController alloc] initWithNibName:@"kaplanEvalutionViewController" bundle:nil];
    kaplanEvalutionViewCon.evalutionDelgate=self;
    
    evalutionNavCon=[[UINavigationController alloc] initWithRootViewController:kaplanEvalutionViewCon];
    evalutionNavCon.navigationBarHidden=YES;
    
    kaplanMingXiaoBoLanViewController *kaplanMingXiaoBoLanViewCon = [[kaplanMingXiaoBoLanViewController alloc] initWithNibName:@"kaplanMingXiaoBoLanViewController" bundle:nil];
    kaplanMingXiaoBoLanViewCon.MingXiaoBoLanDelegate=self;
    
    kaplanSettingViewCon=[[kaplanSettingViewController alloc] initWithNibName:@"kaplanSettingViewController" bundle:nil];
    kaplanSettingViewCon.settingDelegate=self;
    SettingViewNavCon=[[UINavigationController alloc] initWithRootViewController:kaplanSettingViewCon];
    
    SchoolsViewNavCon=[[UINavigationController alloc] initWithRootViewController:kaplanMingXiaoBoLanViewCon];
    SchoolsViewNavCon.navigationBarHidden=YES;
    
    self.tabBarController=[[UITabBarController alloc] init];
    self.tabBarController.viewControllers=[NSArray arrayWithObjects:kaplanSereachMainViewCon,SettingViewNavCon,NewsViewNavCon,evalutionNavCon,SchoolsViewNavCon,nil];
    if (kaplanRootViewCon) {
        kaplanRootViewCon=nil;
    }
    self.tabBarController.navigationController.navigationBarHidden=YES;
    kaplanRootViewCon=self;
    backViewShowing=NO;
    self.backViewController=tabBarController;
    [self.MainScrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_index" ]]];
    [self addChildViewController:self.backViewController];
    [self.NavBackView addSubview:self.backViewController.view];
    [self hideTabBar];
    [NSTimer scheduledTimerWithTimeInterval:1 target: self selector: @selector(handleTimer:)  userInfo:nil  repeats: YES];
    page=[[UIPageControl alloc] initWithFrame:CGRectMake(240, 110, 38,36)];
    if ([[UIScreen mainScreen] bounds].size.height>480.00) {
       
        sv=[[UIScrollView alloc] initWithFrame:CGRectMake(10, [[UIScreen mainScreen] bounds].size.height/10, 305, 134)];
    }
    else{
     sv=[[UIScrollView alloc] initWithFrame:CGRectMake(10, [[UIScreen mainScreen] bounds].size.height/10+7, 305, 134)];
    }
    UIImageView *svBG=[[UIImageView alloc] initWithFrame:CGRectMake(sv.frame.origin.x-5, sv.frame.origin.y-4, 311, 144)];
    [svBG setImage:[UIImage imageNamed:@"rolling"]];
    sv.showsHorizontalScrollIndicator=NO;
    sv.backgroundColor=[UIColor clearColor];
    [MainScrollView layer].shadowPath =[UIBezierPath bezierPathWithRect:MainScrollView.bounds].CGPath;
    self.MainScrollView.layer.shadowColor=[[UIColor blackColor] CGColor];
    self.MainScrollView.layer.shadowOffset=CGSizeMake(0,0);
    self.MainScrollView.layer.shadowRadius=10.0;
    self.MainScrollView.layer.shadowOpacity=1.0;
    kaplanServerHelper *serverHelper=[kaplanServerHelper sharekaplanServerHelper];
    NSMutableDictionary *initInfo=[[NSMutableDictionary alloc] initWithDictionary:[serverHelper checkForInitApp]];
    topListArray=[[NSMutableArray alloc] initWithArray:[initInfo objectForKey:@"topList"]];
    sv.delegate=self;
    [self AdImg:topListArray];
    [self setCurrentPage:page.currentPage];
    [self.MainScrollView addSubview:svBG];
    //[self.MainScrollView addSubview:self.MainView];
    [self.MainScrollView addSubview:sv];
    [self.MainScrollView addSubview:page];
    if (![[initInfo objectForKey:@"appVersion"] isEqualToString:self.appVersionID])
    {
        NSLog(@"%@,%@",[initInfo objectForKey:@"appVersion"],self.appVersionID);
    }else
        if (![[initInfo objectForKey:@"dbVerID"] isEqualToString:self.dbVerID]) {
        UIActionSheet* mySheet = [[UIActionSheet alloc]
                                  initWithTitle:@"数据库版本过旧"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:@"更新数据库"
                                  otherButtonTitles:nil];
        [mySheet showInView:self.view];

        }else
    {
        [kaplanSettingViewCon.checkDataBase setUserInteractionEnabled:NO];
    }
    
}

#pragma sv
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    page.currentPage=scrollView.contentOffset.x/320;
    [self setCurrentPage:page.currentPage];
    
    
}
-(void)AdImg:(NSMutableArray*)arr{
    [sv setContentSize:CGSizeMake(320*[arr count], 88)];
    page.numberOfPages=[arr count];
    
    for ( int i=0; i<[arr count]; i++) {
        
        NSDictionary *tmpDictionary=[[NSDictionary alloc] initWithDictionary:[arr objectAtIndex:i]];
        UIButton *img=[[UIButton alloc]initWithFrame:CGRectMake(315*i, 0, 300, 134)];
        [img addTarget:self action:@selector(Action) forControlEvents:UIControlEventTouchUpInside];
        [sv addSubview:img];
         NSString *url=[NSString stringWithFormat:@"http://cd.douho.net%@",[tmpDictionary objectForKey:@"picUrl"]];
         NewImageFromURL( [NSURL URLWithString:url], ^( UIImage * image )
         {
         [img setImage:image forState:UIControlStateNormal];
         }, ^(void){
         });
    }
    
}
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)newsize{
    
    // 创建一个bitmap的context
    
    // 并把它设置成为当前正在使用的context
    
    UIGraphicsBeginImageContext(newsize);
    
    // 绘制改变大小的图片
    
    [img drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    
    // 从当前context中创建一个改变大小后的图片
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    
    return scaledImage;
    
}
void NewImageFromURL( NSURL * URL, void (^imageBlock)(UIImage * image), void (^errorBlock)(void) )
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
-(void)Action
{
    UIAlertView *alerView=[[UIAlertView alloc] initWithTitle:@"我是广告君" message:@"现在还木有广告哦" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alerView show];
}
- (void) setCurrentPage:(NSInteger)secondPage {
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [page.subviews count]; subviewIndex++) {
        UIImageView* subview = [page.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 24/2;
        size.width = 24/2;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     size.width,size.height)];
        
        if (subviewIndex == secondPage) [subview setImage:[UIImage imageNamed:@"rolling_selected"]];
        else [subview setImage:[UIImage imageNamed:@"rolling_unselected"]];
        
    }
}


#pragma sideBar
-(IBAction)showBackView:(id)sender
{
    if ( backViewShowing==NO) {
        switch ([sender tag]) {
            case 1:
            {
                self.tabBarController.selectedIndex=0;
            }
                break;
            case 2:
            {
                 self.tabBarController.selectedIndex=1;
            }
                break;
            case 3:
            {
                 self.tabBarController.selectedIndex=2;
            }
                break;
            case 4:
            {
                 self.tabBarController.selectedIndex=3;
            }
                break;
            case 5:
            {
                 self.tabBarController.selectedIndex=4;
            }
                break;
            case 6:{
                self.tabBarController.selectedIndex=1;
            }
        }
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        CGFloat translation = -305;
        self.MainScrollView.transform = CGAffineTransformMakeTranslation(translation, 0);
        [UIView commitAnimations];
        backViewShowing=YES;
       // self.MainView.layer.shadowOpacity=1.0;
        if ([sender tag]==2) {
            [kaplanSettingViewCon performSelector:@selector(pushToAboutUS:) withObject:nil afterDelay:1.0];

        }

    }else
    {

        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        CGFloat translation = 0;
        self.MainScrollView.transform = CGAffineTransformMakeTranslation(translation, 0);
        [UIView commitAnimations];
        backViewShowing=NO;
    }

}
- (void) handleTimer: (NSTimer *) timer
{
    if (TimeNum % 3 == 0 ) {
        //Tend 默认值为No
        if (!Tend) {
            NSLog(@"curretn page is %d",page.currentPage);
            page.currentPage++;
            if (page.currentPage==page.numberOfPages-1) {
                Tend=YES;
            }
        }else{
            page.currentPage--;
            if (page.currentPage==0) {
                Tend=NO;
            }
        }
        
        [UIView animateWithDuration:0.7 //速度0.7秒
                         animations:^{//修改坐标
                             sv.contentOffset = CGPointMake(page.currentPage*320,0);
                         }];
        
        
    }
    TimeNum ++;
}
-(void)scaleBegin:(CALayer *)aLayer
{
    const float maxScale=120.0;
    if (aLayer.transform.m11<maxScale) {
        if (aLayer.transform.m11==1.0) {
            [aLayer setTransform:CATransform3DMakeScale( 1.1, 1.1, 1.0)];
            
        }else{
            [aLayer setTransform:CATransform3DScale(aLayer.transform, 1.1, 1.1, 1.0)];
        }
        [self performSelector:_cmd withObject:aLayer afterDelay:0.05];
    }else [aLayer removeFromSuperlayer];
}
- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}
- (IBAction)turnToSetting:(id)sender
{
    self.tabBarController.selectedIndex=1;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGFloat translation = -305;
    self.MainScrollView.transform = CGAffineTransformMakeTranslation(translation, 0);
    [UIView commitAnimations];
    backViewShowing=YES;

}
- (void)actionSheet:(UIActionSheet *)actionSheet

didDismissWithButtonIndex:(NSInteger)buttonIndex

{
    
    if( buttonIndex != [actionSheet cancelButtonIndex]){
        [kaplanSettingViewCon updateDataBase:nil];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
   // [self setMainView:nil];
    [self setMainScrollView:nil];
    [super viewDidUnload];
}
@end
