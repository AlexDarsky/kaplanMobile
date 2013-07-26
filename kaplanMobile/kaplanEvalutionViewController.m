//
//  kaplanEvalutionViewController.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanEvalutionViewController.h"
#import "kaplanViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SVProgressHUD.h"
#import "kaplanServerHelper.h"
@interface kaplanEvalutionViewController ()

@end

@implementation kaplanEvalutionViewController
@synthesize CustomNavBar;
@synthesize evalutionDelgate,grandChild;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_inside"]];
        CustomNavBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
        [self.CustomNavBar layer].shadowPath =[UIBezierPath bezierPathWithRect:self.CustomNavBar.bounds].CGPath;
        self.CustomNavBar.layer.anchorPoint=CGPointMake(0.5, 0.5);
        self.CustomNavBar.layer.shadowColor=[[UIColor blackColor] CGColor];
        self.CustomNavBar.layer.shadowOffset=CGSizeMake(0,0);
        self.CustomNavBar.layer.shadowRadius=10.0;
        self.CustomNavBar.layer.shadowOpacity=1.0;
        self.ChoiceCityBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        self.ChoiceCountryBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        self.ChoiceEducationBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        
    }
    return self;
}
- (IBAction)backToMainView:(id)sender {
    [evalutionDelgate showBackView:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    evalutionChildViewController=[[kaplanEvalutionChildViewController alloc] initWithNibName:@"kaplanEvalutionChildViewController" bundle:nil];
    evalutionChildViewController.evalutionChildDelegate=self;
    grandChild=[kaplanEvalutionGrandChildViewController sharekaplanEvalutionGrandChildViewController];
    grandChild.evalutionGrandChildDelegate=self;
    

}
- (IBAction)goToChildViewCon:(id)sender
{
    switch ([sender tag]) {
        case 0:
        {
            [self.navigationController pushViewController:evalutionChildViewController animated:YES];
            [evalutionChildViewController reloadListForMode:0];
        }
            break;
        case 1:
        {

            [self.navigationController pushViewController:evalutionChildViewController animated:YES];
            [evalutionChildViewController reloadListForMode:1];
        }
            break;
        case 2:
        {
      
            [self.navigationController pushViewController:evalutionChildViewController animated:YES];
            [evalutionChildViewController reloadListForMode:2];

        }
            break;

    }
}
-(void)setCity:(NSString*)city andID:(int)idNumber
{
    
    [self.ChoiceCityBtn.titleLabel setText:[NSString stringWithFormat:@"  %@",city]];
    cityID=idNumber;
}
-(void)setEducation:(NSString*)education andID:(int)idNumber
{
    [self.ChoiceEducationBtn.titleLabel setText:[NSString stringWithFormat:@"  %@",education]];
    degreeID=idNumber;
}
-(void)setDestination:(NSString*)destination andID:(int)idNumber
{
    [self.ChoiceCountryBtn.titleLabel setText:[NSString stringWithFormat:@"  %@",destination]];
    countryID=idNumber;
}
- (IBAction)submitEvalution:(id)sender
{

    kaplanServerHelper *serverHelper=[kaplanServerHelper sharekaplanServerHelper];
    if ([serverHelper connectedToNetwork]) {
        NSString *submitString=[NSString stringWithFormat:@"{\"cityID\":\"%d\",\"degreeID\":\"%d\",\"countryID\":\"%d\",\"name\":\"%@\",\"email\":\"%@\",\"phone\":\"%@\"}",cityID,degreeID,countryID,self.userName.text,self.userEmail.text,self.userNumber.text];
        NSDictionary *submitDic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",cityID],@"cityID",[NSString stringWithFormat:@"%d",degreeID],@"degreeID",[NSString stringWithFormat:@"%d",countryID],@"countryID",self.userName.text,@"name",self.userEmail.text,@"email",self.userNumber.text,@"phone", nil];
        if ([self.ChoiceCityBtn.titleLabel.text isEqualToString:@"  所在地"]||[self.ChoiceEducationBtn.titleLabel.text isEqualToString:@"  现有学历"]||[self.ChoiceCountryBtn.titleLabel.text isEqualToString:@"  意向留学国家"]
||[self.userName.text isEqualToString:@""]||self.userName.text==nil||[self.userEmail.text isEqualToString:@""]||self.userEmail.text==nil||[self.userNumber.text isEqualToString:@""]||self.userNumber.text==nil) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"操作未完成" message:@"请填写您的完整的信息" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
            return;
        }
        if ([NSJSONSerialization isValidJSONObject:submitDic]) {
            
            if ([serverHelper sendEvalutionToServer:submitString]) {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"在线评估" message:@"保存评估资料成功，我们的顾问将会尽快将评估结果通知给您。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }else{
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"在线评估" message:@"保存评估资料失败。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
        }else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误" message:@"评估失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }

    }else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)exitKeyboard:(id)sender {
    [sender resignFirstResponder];
}
- (void)viewDidUnload {
    [self setChoiceCityBtn:nil];
    [self setChoiceEducationBtn:nil];
    [self setChoiceCountryBtn:nil];
    [self setUserName:nil];
    [self setUserEmail:nil];
    [self setUserNumber:nil];
    [super viewDidUnload];
}
@end
