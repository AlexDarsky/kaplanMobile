//
//  kaplanAboutViewController.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-6-20.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kaplanAboutViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *CustomNavBar;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
+(kaplanAboutViewController*)sharekaplanAboutViewController;
@end
