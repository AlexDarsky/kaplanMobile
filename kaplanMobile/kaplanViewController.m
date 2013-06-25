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
@synthesize MainView,NavBackView;
@synthesize tabBarController;
@synthesize evalutionNavCon,SchoolsViewNavCon,NewsViewNavCon,kaplanSettingViewCon;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    kaplanSereachMainViewController *kaplanSereachMainViewCon=[[kaplanSereachMainViewController alloc] initWithNibName:@"kaplanSereachMainViewController" bundle:nil];
    kaplanSereachMainViewCon.SereachDelegate=self;
    
    kaplanAboutViewController *kaplanAboutViewCon=[[kaplanAboutViewController alloc] initWithNibName:@"kaplanAboutViewController" bundle:nil];
    
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
    SchoolsViewNavCon=[[UINavigationController alloc] initWithRootViewController:kaplanMingXiaoBoLanViewCon];
    SchoolsViewNavCon.navigationBarHidden=YES;
    
    self.tabBarController=[[UITabBarController alloc] init];
    self.tabBarController.viewControllers=[NSArray arrayWithObjects:kaplanSereachMainViewCon,kaplanAboutViewCon,NewsViewNavCon,evalutionNavCon,SchoolsViewNavCon,nil];
    if (kaplanRootViewCon) {
        kaplanRootViewCon=nil;
    }
    self.tabBarController.navigationController.navigationBarHidden=YES;
    kaplanRootViewCon=self;
    backViewShowing=NO;
    self.backViewController=tabBarController;
    [self.MainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_index" ]]];
    [self addChildViewController:self.backViewController];
    [self.NavBackView addSubview:self.backViewController.view];
    [self hideTabBar];
    [NSTimer scheduledTimerWithTimeInterval:1 target: self selector: @selector(handleTimer:)  userInfo:nil  repeats: YES];
    page=[[UIPageControl alloc] initWithFrame:CGRectMake(240, 110, 38,36)];
    sv=[[UIScrollView alloc] initWithFrame:CGRectMake(10, 55, 300, 88)];
    sv.backgroundColor=[UIColor clearColor];
    sv.showsHorizontalScrollIndicator=NO;
    demoArray=[[NSMutableArray alloc] initWithObjects: @"homepage1.png",@"homepage2.png",@"homepage3.png",@"homepage4.png", nil];
    sv.delegate=self;
    [self AdImg:demoArray];
    [self setCurrentPage:page.currentPage];
    [self.MainView addSubview:sv];
    [self.MainView addSubview:page];
    [MainView layer].shadowPath =[UIBezierPath bezierPathWithRect:MainView.bounds].CGPath;
    self.MainView.layer.shadowColor=[[UIColor blackColor] CGColor];
    self.MainView.layer.shadowOffset=CGSizeMake(0,0);
    self.MainView.layer.shadowRadius=10.0;
    self.MainView.layer.shadowOpacity=1.0;
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
        // NSString *url=[arr objectAtIndex:i];
        UIButton *img=[[UIButton alloc]initWithFrame:CGRectMake(320*i, 0, 300, 88)];
        [img addTarget:self action:@selector(Action) forControlEvents:UIControlEventTouchUpInside];
        [sv addSubview:img];
        [img setImage:[UIImage imageNamed:[arr objectAtIndex:i]] forState:UIControlStateNormal];
        /*
         UIImageFromURL( [NSURL URLWithString:url], ^( UIImage * image )
         {
         [img setImage:image forState:UIControlStateNormal];
         }, ^(void){
         });*/
    }
    
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
        }
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        CGFloat translation = -305;
        self.MainView.transform = CGAffineTransformMakeTranslation(translation, 0);
        [UIView commitAnimations];
        backViewShowing=YES;
       // self.MainView.layer.shadowOpacity=1.0;

    }else
    {

        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        CGFloat translation = 0;
        self.MainView.transform = CGAffineTransformMakeTranslation(translation, 0);
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
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    

    [self.navigationController pushViewController:kaplanSettingViewCon animated:YES];
        /*
    NSURL *url=[NSURL URLWithString:@"http://music.baidu.com/data/music/file?link=http://zhangmenshiting.baidu.com/data2/music/42911424/4015334072000320.mp3?xcode=36921517c1d51441e93e8edf4c3ce7091ae285f61fcd240c"];
	[url downloadWithDelegate:self Title:@"目标文件" WithToFileName:[kDocumentFolder stringByAppendingPathComponent:@"2.mp3"]];
     */

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMainView:nil];
    [super viewDidUnload];
}
@end
