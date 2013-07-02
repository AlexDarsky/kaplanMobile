//
//  kaplanSQLIteHelper.m
//  SQLiteDemo
//
//  Created by linchuan on 7/1/13.
//  Copyright (c) 2013 abby. All rights reserved.
//

#import "kaplanSQLIteHelper.h"
#define DBNAME    @"schoolDB.db3"
#define NAME      @"name"
#define AGE       @"age"
#define ADDRESS   @"address"
#define TABLENAME @"PERSONINFO"


@implementation kaplanSQLIteHelper
static kaplanSQLIteHelper *sharekaplanSQLIteHelper = nil;
+(kaplanSQLIteHelper*)sharekaplanSQLIteHelper
{
    
    if (sharekaplanSQLIteHelper == nil) {
        sharekaplanSQLIteHelper = [[super allocWithZone:NULL] init];
    }
    return sharekaplanSQLIteHelper;
}

-(void)openDB
{
    NSArray *documentsPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory
                                                                , NSUserDomainMask
                                                                , YES);
    NSString *databaseFilePath=[[documentsPaths objectAtIndex:0] stringByAppendingPathComponent:DBNAME];
    if (sqlite3_open([databaseFilePath UTF8String], &db)==SQLITE_OK) {
        NSLog(@"open sqlite db ok.");
    }
}
-(void)queryDB:(NSString*)queryString
{
    NSString *sqlQuery =[NSString stringWithFormat:@"SELECT * FROM schools"];
    sqlite3_stmt * statement;
     NSMutableArray *tmpArray=[[NSMutableArray alloc] initWithCapacity:0];
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
       
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //int _id=sqlite3_column_int(statement, 0);
            NSString *name1=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
            NSString *name2=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
            NSString *name3=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 2) encoding:NSUTF8StringEncoding];
            NSDictionary *tmpDic=[[NSDictionary alloc] initWithObjectsAndKeys:@"c1",name1,@"c2",name2,@"c3",name3, nil];
            [tmpArray addObject:tmpDic];
        }
    }
    sqlite3_close(db);
}
-(NSMutableArray*)querySchoolsFromDB:(NSString*)queryString
{
    [self openDB];
    NSString *sqlQuery =[NSString stringWithFormat:@"SELECT * FROM schools"];
    sqlite3_stmt * statement;
     NSMutableArray *tmpArray=[[NSMutableArray alloc] initWithCapacity:0];
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
       
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //int _id=sqlite3_column_int(statement, 0);
            NSString *name1=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
            NSString *name2=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
            NSString *name3=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 2) encoding:NSUTF8StringEncoding];
            NSDictionary *tmpDic=[[NSDictionary alloc] initWithObjectsAndKeys:name1,@"c1",name2,@"c2",name3,@"c3", nil];
            [tmpArray addObject:tmpDic];
            NSLog(@"OKOKO");
        }
    }
    sqlite3_close(db);
    return tmpArray;
}
@end
