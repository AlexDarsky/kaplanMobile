//
//  animationImageView.m
//  AnimationDemo
//
//  Created by AlexZhu on 13-7-4.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import "animationImageView.h"

@implementation animationImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)startImageViewAnimation
{
    NSArray *myImages = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"10001.png"],[UIImage imageNamed:@"10002.png"],[UIImage imageNamed:@"10003.png"],[UIImage imageNamed:@"10004.png"],[UIImage imageNamed:@"10005.png"],[UIImage imageNamed:@"10006.png"],[UIImage imageNamed:@"10007.png"],[UIImage imageNamed:@"10008.png"],[UIImage imageNamed:@"10009.png"],
                         nil];
    self.animationImages = myImages;
    self.animationDuration = 0.3; // 秒
    self.animationRepeatCount = 0; // 0 = 无限
    [self startAnimating];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
