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
    sqlite3_open([databaseFilePath UTF8String], &db);
}
-(BOOL)didDBexists
{
    NSArray *documentsPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory
                                                                , NSUserDomainMask
                                                                , YES);
    NSString *databaseFilePath=[[documentsPaths objectAtIndex:0] stringByAppendingPathComponent:DBNAME];
    BOOL isDir;
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:databaseFilePath isDirectory:&isDir];
    if (exists) {
        return YES;
    }else
        return NO;
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
-(NSMutableArray*)getSchoolAllClass:(NSString*)schoolName
{
    if ([self didDBexists]) {
        [self openDB];
        NSString *sqlQuery =[NSString stringWithFormat:@"SELECT * FROM schools WHERE schoolCnName = ?"];
        sqlite3_stmt * statement;
        NSMutableArray *tmpArray=[[NSMutableArray alloc] initWithCapacity:0];
        if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
            sqlite3_bind_text(statement, 1, [schoolName UTF8String], -1, SQLITE_TRANSIENT);
            while (sqlite3_step(statement) == SQLITE_ROW) {
                //int _id=sqlite3_column_int(statement, 0);
                NSString *name1=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
                NSString *name2=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
                NSString *name3=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 3) encoding:NSUTF8StringEncoding];
                NSDictionary *tmpDic=[[NSDictionary alloc] initWithObjectsAndKeys:name1,@"c1",name2,@"c2",name3,@"c4", nil];
                [tmpArray addObject:tmpDic];
                NSLog(@"OKOKO");
            }
            sqlite3_close(db);
            return tmpArray;
        }
        
    }
}
-(NSMutableArray*)querySchoolsFromDB:(NSString*)queryString
{
    if ([self didDBexists]) {
        [self openDB];
        NSString *sqlQuery =[NSString stringWithFormat:@"SELECT * FROM schools WHERE majors = ?"];
        sqlite3_stmt * statement;
        NSMutableArray *tmpArray=[[NSMutableArray alloc] initWithCapacity:0];
        if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
            sqlite3_bind_text(statement, 1, [queryString UTF8String], -1, SQLITE_TRANSIENT);
            while (sqlite3_step(statement) == SQLITE_ROW) {
                //int _id=sqlite3_column_int(statement, 0);
                NSString *name1=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
                NSString *name2=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
                NSString *name3=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 2) encoding:NSUTF8StringEncoding];
                NSDictionary *tmpDic=[[NSDictionary alloc] initWithObjectsAndKeys:name1,@"c1",name2,@"c2",name3,@"c3", nil];
                [tmpArray addObject:tmpDic];
                NSLog(@"OKOKO");
            }
            sqlite3_close(db);
            return tmpArray;
        }

    }else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"警告" message:@"本地数据库损坏或丢失，请前往\"设置\"重新下载" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        return nil;
    }
}
-(NSMutableArray*)queryAllSchoolsByClass
{
    if ([self didDBexists]) {
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
                NSLog(tmpDic);
                [tmpArray addObject:tmpDic];
                NSLog(@"OKOKO");
            }
        }
        sqlite3_close(db);
        return tmpArray;
    }else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"警告" message:@"本地数据库损坏或丢失，请前往\"设置\"重新下载" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        return nil;
    }

    
}
-(NSMutableArray*)querySchoolsFromDBBy:(NSString*)parameter1 :(NSString*)parameter2 :(NSString*)parameter3;
{
    if ([self didDBexists]) {
        [self openDB];
        NSString *sqlQuery =[NSString stringWithFormat:@"SELECT * FROM schools WHERE typeCN= ? AND schoolCnName= ? AND specialities = ?"];
        sqlite3_stmt * statement;
        NSMutableArray *tmpArray=[[NSMutableArray alloc] initWithCapacity:0];
        if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
            sqlite3_bind_text(statement, 1, [parameter1 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [parameter2 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [parameter3 UTF8String], -1, SQLITE_TRANSIENT);
            while (sqlite3_step(statement) == SQLITE_ROW) {
                //int _id=sqlite3_column_int(statement, 0);
                NSString *name1=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
                NSString *name2=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
                NSString *name4=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 3) encoding:NSUTF8StringEncoding];
                NSDictionary *tmpDic=[[NSDictionary alloc] initWithObjectsAndKeys:name1,@"c1",name2,@"c2",name4,@"c3", nil];
                [tmpArray addObject:tmpDic];
                NSLog(@"OKOKO");
            }
        }
        sqlite3_close(db);
        return tmpArray;

    }else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"警告" message:@"本地数据库损坏或丢失，请前往\"设置\"重新下载" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        return nil;

    }
   
}
-(NSMutableArray*)querySchoolsFromDBBy:(NSString*)parameter1 :(NSString*)parameter2 :(NSString*)parameter3 forMode:(int)mode
{
    if ([self didDBexists]) {
        [self openDB];
        switch (mode) {
            case 100:
            {
                NSLog(@"100");
                NSString *sqlQuery =[NSString stringWithFormat:@"SELECT * FROM schools WHERE typeCN= ? "];
                sqlite3_stmt * statement;
                NSMutableArray *tmpArray=[[NSMutableArray alloc] initWithCapacity:0];
                if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
                    sqlite3_bind_text(statement, 1, [parameter1 UTF8String], -1, SQLITE_TRANSIENT);
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        //int _id=sqlite3_column_int(statement, 0);
                        NSString *name1=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
                        NSString *name2=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
                        NSString *name4=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 3) encoding:NSUTF8StringEncoding];
                        if (name4!=nil) {
                            NSDictionary *tmpDic=[[NSDictionary alloc] initWithObjectsAndKeys:name1,@"c1",name2,@"c2",name4,@"c3", nil];
                            [tmpArray addObject:tmpDic];
                            NSLog(@"OKOKO");
                        }
                        
                    }
                }
                sqlite3_close(db);
                return tmpArray;
            }
                break;
            case 110:
            {
                     NSLog(@"110");
                NSString *sqlQuery =[NSString stringWithFormat:@"SELECT * FROM schools WHERE typeCN= ? AND schoolCnName= ?"];
                sqlite3_stmt * statement;
                NSMutableArray *tmpArray=[[NSMutableArray alloc] initWithCapacity:0];
                if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
                    sqlite3_bind_text(statement, 1, [parameter1 UTF8String], -1, SQLITE_TRANSIENT);
                    sqlite3_bind_text(statement, 2, [parameter2 UTF8String], -1, SQLITE_TRANSIENT);
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        //int _id=sqlite3_column_int(statement, 0);
                        NSString *name1=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
                        NSString *name2=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
                        NSString *name4=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 3) encoding:NSUTF8StringEncoding];
                        NSDictionary *tmpDic=[[NSDictionary alloc] initWithObjectsAndKeys:name1,@"c1",name2,@"c2",name4,@"c3", nil];
                        [tmpArray addObject:tmpDic];
                        NSLog(@"OKOKO");
                    }
                }
                sqlite3_close(db);
                return tmpArray;
            }
                break;
            case 111:
            {
                     NSLog(@"111");
                NSString *sqlQuery =[NSString stringWithFormat:@"SELECT * FROM schools WHERE typeCN= ? AND schoolCnName= ? AND specialities = ?"];
                sqlite3_stmt * statement;
                NSMutableArray *tmpArray=[[NSMutableArray alloc] initWithCapacity:0];
                if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
                    sqlite3_bind_text(statement, 1, [parameter1 UTF8String], -1, SQLITE_TRANSIENT);
                    sqlite3_bind_text(statement, 2, [parameter2 UTF8String], -1, SQLITE_TRANSIENT);
                    sqlite3_bind_text(statement, 3, [parameter3 UTF8String], -1, SQLITE_TRANSIENT);
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        //int _id=sqlite3_column_int(statement, 0);
                        NSString *name1=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
                        NSString *name2=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
                        NSString *name4=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 3) encoding:NSUTF8StringEncoding];
                        NSDictionary *tmpDic=[[NSDictionary alloc] initWithObjectsAndKeys:name1,@"c1",name2,@"c2",name4,@"c3", nil];
                        [tmpArray addObject:tmpDic];
                        NSLog(@"OKOKO");
                    }
                }
                sqlite3_close(db);
                return tmpArray;
            }
                break;
            case 101:
            {     NSLog(@"101");
                NSString *sqlQuery =[NSString stringWithFormat:@"SELECT * FROM schools WHERE typeCN= ?  AND specialities = ?"];
                sqlite3_stmt * statement;
                NSMutableArray *tmpArray=[[NSMutableArray alloc] initWithCapacity:0];
                if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
                    sqlite3_bind_text(statement, 1, [parameter1 UTF8String], -1, SQLITE_TRANSIENT);
                    sqlite3_bind_text(statement, 2, [parameter3 UTF8String], -1, SQLITE_TRANSIENT);
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        //int _id=sqlite3_column_int(statement, 0);
                        NSString *name1=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
                        NSString *name2=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
                        NSString *name4=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 3) encoding:NSUTF8StringEncoding];
                        NSDictionary *tmpDic=[[NSDictionary alloc] initWithObjectsAndKeys:name1,@"c1",name2,@"c2",name4,@"c3", nil];
                        [tmpArray addObject:tmpDic];
                        NSLog(@"OKOKO");
                    }
                }
                sqlite3_close(db);
                return tmpArray;
            }
                break;

            case 11:
            {     NSLog(@"11");
                NSString *sqlQuery =[NSString stringWithFormat:@"SELECT * FROM schools WHERE schoolCnName= ? AND specialities = ?"];
                sqlite3_stmt * statement;
                NSMutableArray *tmpArray=[[NSMutableArray alloc] initWithCapacity:0];
                if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
                    sqlite3_bind_text(statement, 1, [parameter2 UTF8String], -1, SQLITE_TRANSIENT);
                    sqlite3_bind_text(statement, 2, [parameter3 UTF8String], -1, SQLITE_TRANSIENT);
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        //int _id=sqlite3_column_int(statement, 0);
                        NSString *name1=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
                        NSString *name2=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
                        NSString *name4=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 3) encoding:NSUTF8StringEncoding];
                        NSDictionary *tmpDic=[[NSDictionary alloc] initWithObjectsAndKeys:name1,@"c1",name2,@"c2",name4,@"c3", nil];
                        [tmpArray addObject:tmpDic];
                        NSLog(@"OKOKO");
                    }
                }
                sqlite3_close(db);
                return tmpArray;
            }
                break;
            case 10:
            {
                     NSLog(@"10");
                NSString *sqlQuery =[NSString stringWithFormat:@"SELECT * FROM schools WHERE  schoolCnName= ?"];
                sqlite3_stmt * statement;
                NSMutableArray *tmpArray=[[NSMutableArray alloc] initWithCapacity:0];
                if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
                    sqlite3_bind_text(statement, 1, [parameter2 UTF8String], -1, SQLITE_TRANSIENT);
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        //int _id=sqlite3_column_int(statement, 0);
                        NSString *name1=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
                        NSString *name2=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
                        NSString *name4=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 3) encoding:NSUTF8StringEncoding];
                        NSDictionary *tmpDic=[[NSDictionary alloc] initWithObjectsAndKeys:name1,@"c1",name2,@"c2",name4,@"c3", nil];
                        [tmpArray addObject:tmpDic];
                        NSLog(@"OKOKO");
                    }
                }
                sqlite3_close(db);
                return tmpArray;
            }
                break;
            case 1:
            {
                     NSLog(@"1");
                NSString *sqlQuery =[NSString stringWithFormat:@"SELECT * FROM schools WHERE specialities = ?"];
                sqlite3_stmt * statement;
                NSMutableArray *tmpArray=[[NSMutableArray alloc] initWithCapacity:0];
                if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
                    sqlite3_bind_text(statement, 1, [parameter3 UTF8String], -1, SQLITE_TRANSIENT);
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        //int _id=sqlite3_column_int(statement, 0);
                        NSString *name1=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
                        NSString *name2=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
                        NSString *name4=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 3) encoding:NSUTF8StringEncoding];
                        NSDictionary *tmpDic=[[NSDictionary alloc] initWithObjectsAndKeys:name1,@"c1",name2,@"c2",name4,@"c3", nil];
                        [tmpArray addObject:tmpDic];
                        NSLog(@"OKOKO");
                    }
                }
                sqlite3_close(db);
                return tmpArray;
            }
                break;

        }
    }else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"警告" message:@"本地数据库损坏或丢失，请前往\"设置\"重新下载" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        return nil;
        
    }
    
}


@end
