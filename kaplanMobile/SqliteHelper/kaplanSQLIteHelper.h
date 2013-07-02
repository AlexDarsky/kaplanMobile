//
//  kaplanSQLIteHelper.h
//  SQLiteDemo
//
//  Created by linchuan on 7/1/13.
//  Copyright (c) 2013 abby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface kaplanSQLIteHelper : NSObject
{
    sqlite3 *db;
}

+(kaplanSQLIteHelper*)sharekaplanSQLIteHelper;
-(void)openDB;
-(void)queryDB:(NSString*)queryString;
-(NSMutableArray*)querySchoolsFromDB:(NSString*)queryString;
@end
