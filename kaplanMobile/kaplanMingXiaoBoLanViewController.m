//
//  kaplanMingXiaoBoLanViewController.m
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "kaplanMingXiaoBoLanViewController.h"

@interface kaplanMingXiaoBoLanViewController ()

@end

@implementation kaplanMingXiaoBoLanViewController
@synthesize schoolsTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        schoolsArray=[[NSMutableArray alloc] initWithObjects:@"贝勒大学",@"东北大学",@"福蒙特大学",@"玛瑞斯学院",@"斯蒂文斯理工学院",@"德保大学", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
