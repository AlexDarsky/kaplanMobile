//
//  kaplanServerHelper.h
//  kaplanMobile
//
//  Created by linchuan on 6/26/13.
//  Copyright (c) 2013 AlexZhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadManager.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"

@interface kaplanServerHelper : NSObject<SinaWeiboDelegate,SinaWeiboRequestDelegate>
{
        DownloadManager *download;
}
+(kaplanServerHelper*)sharekaplanServerHelper;
- (BOOL) connectedToNetwork;
-(NSDictionary*)checkForInitApp;
-(void)updateSQLite;
-(NSArray*)LoadListAtPage:(int)pageNum;
-(NSArray*)getCityLoadList;
-(NSArray*)getCityChildLoadList:(NSString*)subID;
-(NSArray*)getClassLoadList;
-(NSArray*)getCountryList;
-(BOOL)sendEvalutionToServer:(NSString*)jsonString;
-(NSArray*)getSchoolListAtPage:(int)pageNum;
-(NSDictionary*)getSchoolDetail:(NSString*)schoolID;
-(NSDictionary*)getNewDetailByID:(NSString*)newID;
@end
