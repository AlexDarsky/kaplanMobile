//
//  kaplanServerHelper.h
//  kaplanMobile
//
//  Created by linchuan on 6/26/13.
//  Copyright (c) 2013 AlexZhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadManager.h"

@interface kaplanServerHelper : NSObject
{
        DownloadManager *download;
}
+(kaplanServerHelper*)sharekaplanServerHelper;
-(NSDictionary*)checkForInitApp;
-(void)updateSQLite;
-(NSArray*)LoadListAtPage:(int)pageNum;
-(NSArray*)getCityLoadList;
-(NSArray*)getClassLoadList;
-(NSArray*)getCountryList;
-(BOOL)sendEvalutionToServer:(NSString*)jsonString;
-(NSArray*)getSchoolListAtPage:(int)pageNum;
@end
