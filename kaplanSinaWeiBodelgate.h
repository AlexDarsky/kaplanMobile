//
//  kaplanSinaWeiBodelgate.h
//  kaplanMobile
//
//  Created by AlexZhu on 13-7-9.
//  Copyright (c) 2013年 AlexZhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
@interface kaplanSinaWeiBodelgate : UIResponder<SinaWeiboDelegate,SinaWeiboRequestDelegate>
+(kaplanSinaWeiBodelgate*)sharekaplanSinaWeiBodelgate;

@property (strong)id SinaWeiBoActionDelagete;
-(BOOL)connectToSinaWeiBoWith:(NSDictionary*)dictionary;
@end
