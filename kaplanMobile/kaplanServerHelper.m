//
//  kaplanServerHelper.m
//  kaplanMobile
//
//  Created by linchuan on 6/26/13.
//  Copyright (c) 2013 AlexZhu. All rights reserved.
//

#import "kaplanServerHelper.h"
#import "DownloadManager.h"
#import "NSURL+Download.h"
#import "SBJson.h"
#define kDocumentFolder					[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] 
@implementation kaplanServerHelper
static kaplanServerHelper *sharekaplanServerHelper = nil;
+(kaplanServerHelper*)sharekaplanServerHelper
{
    
    if (sharekaplanServerHelper == nil) {
        sharekaplanServerHelper = [[super allocWithZone:NULL] init];
    }
    return sharekaplanServerHelper;
}
-(NSDictionary*)checkForInitApp
{
    NSString *urlString =[NSString stringWithFormat:@"http://cd.douho.net/ajax/init.aspx?action=initAll&app=0"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSDictionary *tmpDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    if (tmpDic!=nil) {
        return tmpDic;
    }else
    return nil;
}
-(NSArray*)getCityLoadList
{
    NSString *urlString =[NSString stringWithFormat:@"http://cd.douho.net/ajax/city.aspx?action=loadList"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    //NSDictionary *tmpDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    NSArray *tmpArray=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    return tmpArray;
}
-(NSArray*)getClassLoadList
{
    NSString *urlString =[NSString stringWithFormat:@"http://cd.douho.net/ajax/allClass.aspx?action=loadlist&id=238"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    //NSDictionary *tmpDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    NSArray *tmpArray=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    return tmpArray;
}
-(NSArray*)getCountryList
{
    NSString *urlString =[NSString stringWithFormat:@"http://cd.douho.net/ajax/allClass.aspx?action=loadlist&id=239"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    //NSDictionary *tmpDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    NSArray *tmpArray=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    return tmpArray;
}
-(NSArray*)getSchoolListAtPage:(int)pageNum
{
    NSString *urlString =[NSString stringWithFormat:@"http://cd.douho.net/ajax/school.aspx?action=loadlist&id=239&pageSize=99"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSDictionary *tmpDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    NSArray *tmpArray=[[NSArray alloc] initWithArray:[tmpDic objectForKey:@"schoolList"]];
    return tmpArray;
}
-(NSArray*)LoadListAtPage:(int)pageNum;
{
    NSString *urlString =[NSString stringWithFormat:@"http://cd.douho.net/ajax/Info.aspx?action=LoadList&id=0&page=%d&app=0",pageNum];
   // NSString *urlString =[NSString stringWithFormat:@"http://cd.douho.net/ajax/init.aspx?action=initAll&app=0"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSMutableString *jsonString=[[NSMutableString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(jsonString);
   // NSString*jsonString = [[NSString alloc]initWithBytes:[responseData bytes]length:[responseData length]encoding:NSUTF8StringEncoding];
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSMutableDictionary *tmpDic =[jsonParser objectWithString:jsonString];
   // NSDictionary *tmpDic=[NSDictionary alloc] initWithObjectsAndKeys:@"2",@"total", nil
    if (tmpDic==nil)
    {
        NSLog(@"empty");
    }
    NSArray *tmpArray=[tmpDic objectForKey:@"newsList"];
 
    return tmpArray;
}
-(void)updateSQLite
{
    NSString *urlString =[NSString stringWithFormat:@"http://cd.douho.net/ajax/init.aspx?action=init&app=0"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSDictionary *initDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://cd.douho.net/%@",[initDic objectForKey:@"dbFile"]]];
	[url downloadWithDelegate:self Title:@"下载数据库" WithToFileName:[kDocumentFolder stringByAppendingPathComponent:@"schoolDB.db3"]];

}
-(BOOL)sendEvalutionToServer:(NSString*)jsonString
{
    NSLog(@"%@",jsonString);
    NSString *urlString =[NSString stringWithFormat:@"http://cd.douho.net/ajax/pinggu.aspx?action=save&json=%@&app=0",jsonString];
    NSLog(urlString);
    NSString *demostring=@"http://cd.douho.net/ajax/pinggu.aspx?action=save&json={\"cityID\":\"1004\",\"degreeID\":\"2\",\"countryID\":\"1\",\"name\":\"tonydai\",\"email\":\"tonydaix@163.com\",\"phone\":\"13981808031\"}&app=0";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:demostring]];
  //  [request setHTTPMethod:@"GET"];
    //http://cd.douho.net/ajax/pinggu.aspx?action=save&json={"cityID":"1004","degreeID":"2","countryID":"1","name":"tonydai","email":"tonydaix@163.com","phone":"13981808031"}&app=0
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSMutableString *responseString=[[NSMutableString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSString *string=@"true";
    NSRange range=[responseString rangeOfString:string];
    NSLog(@"%d",range.location);
    if (range.location>1) {
        return YES;
    }else
        return NO;
}
@end
