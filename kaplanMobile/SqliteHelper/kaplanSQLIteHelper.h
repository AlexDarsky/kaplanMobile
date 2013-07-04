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
-(BOOL)didDBexists;
-(NSMutableArray*)querySchoolsFromDB:(NSString*)queryString;
-(NSMutableArray*)querySchoolsFromDBBy:(NSString*)parameter1 :(NSString*)parameter2 :(NSString*)parameter3;
-(NSMutableArray*)querySchoolsFromDBBy:(NSString*)parameter1 :(NSString*)parameter2 :(NSString*)parameter3 forMode:(int)mode;
-(NSMutableArray*)getSchoolAllClass:(NSString*)schoolName;
-(NSMutableArray*)queryAllSchoolsByClass;
@end
