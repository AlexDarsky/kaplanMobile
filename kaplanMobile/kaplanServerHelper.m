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
#import "JSONKit.h"

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
- (BOOL) connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
	
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
	
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
	
    if (!didRetrieveFlags)
    {
        NSLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
	
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
	
    
	NSURL *testURL = [NSURL URLWithString:@"http://www.baidu.com/"];
	NSURLRequest *testRequest = [NSURLRequest requestWithURL:testURL  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
	NSURLConnection *testConnection = [[NSURLConnection alloc] initWithRequest:testRequest delegate:self];
    return ((isReachable && !needsConnection) || nonWiFi) ? (testConnection ? YES : NO) : NO;
}

-(NSDictionary*)checkForInitApp
{
    NSString *urlString =[NSString stringWithFormat:@"http://kaplan.douho.net/ajax/init.aspx?action=initAll&app=0"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSMutableString *string=[[NSMutableString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(string);
    NSDictionary *tmpDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    if (tmpDic!=nil) {
        return tmpDic;
    }else
    return nil;
}
-(NSArray*)getCityLoadList
{
    NSString *urlString =[NSString stringWithFormat:@"http://kaplan.douho.net/ajax/city.aspx?action=loadList"];
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
-(NSArray*)getCityChildLoadList:(NSString*)subID
{
    NSString *urlString =[NSString stringWithFormat:@"http://kaplan.douho.net/ajax/city.aspx?action=loadList&id=%@",subID];
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
    NSString *urlString =[NSString stringWithFormat:@"http://kaplan.douho.net/ajax/allClass.aspx?action=loadlist&id=238"];
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
-(BOOL)sendDeviceTokenToServer:(NSString*)deviceToken
{
    deviceToken=[deviceToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    deviceToken=[deviceToken stringByReplacingOccurrencesOfString:@">" withString:@""];
    deviceToken=[deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *urlString =[NSString stringWithFormat:@"http://kaplan.douho.net/ajax/token.aspx?action=save&token=%@",deviceToken];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSString*jsonString = [[NSString alloc]initWithBytes:[responseData bytes]length:[responseData length]encoding:NSUTF8StringEncoding];
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *resultsDictionary = [jsonData objectFromJSONData];
    if ([[resultsDictionary objectForKey:@"success"] isEqualToString:@"true"]) {
        NSLog(@"YES!!!!!!");
        return YES;
    }else
        return NO;

}
-(NSDictionary*)getNewDetailByID:(NSString*)newID
{
    NSString *urlString =[NSString stringWithFormat:@"http://kaplan.douho.net/ajax/Info.aspx?action=Detail&id=%@&app=0",newID];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSMutableString *responseString=[[NSMutableString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSString *JSONString = [responseString substringWithRange:NSMakeRange(1, responseString.length-2)];
    NSLog(JSONString);
    NSData* jsonData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *resultsDictionary = [jsonData objectFromJSONData];
    return resultsDictionary;
}
-(NSDictionary*)getRemotoNotification:(NSString*)title
{
    
   NSString *urlString =[NSString stringWithFormat:@"http://kaplan.douho.net/ajax/Info.aspx?action=detail&title=%@",title];
   // NSString *urlString =[NSString stringWithFormat:@"http://cd.douho.net/ajax/Info.aspx?action=detail&title=SIC中国学生在谢菲尔德大学成功毕业，并被剑桥大学录取"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[self getEncodedString:urlString]]];
    [request setHTTPMethod:@"POST"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (responseData==nil) {
        NSLog(@"Nil");
    }
    NSString *responseString = [[NSString alloc]initWithBytes:[responseData bytes]length:[responseData length]encoding:NSUTF8StringEncoding];
    NSLog(@"getRemotoNotification:%@",responseString);
    NSString *jsonString = [responseString substringWithRange:NSMakeRange(1, responseString.length-2)];
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *resultsDictionary = [jsonData objectFromJSONData];
    return resultsDictionary;

}
-(NSArray*)getCountryList
{
    NSString *urlString =[NSString stringWithFormat:@"http://kaplan.douho.net/ajax/allClass.aspx?action=loadlist&id=239"];
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
    NSString *urlString =[NSString stringWithFormat:@"http://kaplan.douho.net/ajax/school.aspx?action=loadlist&id=239&pageSize=99"];
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
-(NSDictionary*)getSchoolDetail:(NSString*)schoolID
{
    NSString *urlString =[NSString stringWithFormat:@"http://kaplan.douho.net/ajax/school.aspx?action=Detail&id=%@&app=0",schoolID];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];    
    //针对NSData数据
    NSMutableString *responseString=[[NSMutableString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSString *JSONString = [responseString substringWithRange:NSMakeRange(1, responseString.length-2)];
    NSLog(JSONString);
    NSData* jsonData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *resultsDictionary = [jsonData objectFromJSONData];
    return resultsDictionary;
}
-(NSArray*)LoadListAtPage:(int)pageNum;
{
    NSString *urlString =[NSString stringWithFormat:@"http://kaplan.douho.net/ajax/Info.aspx?action=LoadList&id=0&page=%d&app=0&get=0",pageNum];
   // NSString *urlString =[NSString stringWithFormat:@"http://cd.douho.net/ajax/init.aspx?action=initAll&app=0"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
   // NSString*jsonString = [[NSString alloc]initWithBytes:[responseData bytes]length:[responseData length]encoding:NSUTF8StringEncoding];
    NSMutableDictionary *tmpDic =[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
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
    NSString *urlString =[NSString stringWithFormat:@"http://kaplan.douho.net/ajax/init.aspx?action=init&app=0"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSDictionary *initDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"http://kaplan.douho.net%@",[initDic objectForKey:@"dbFile"]);
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://kaplan.douho.net%@",[initDic objectForKey:@"dbFile"]]];
	[url downloadWithDelegate:self Title:@"数据库下载中" WithToFileName:[kDocumentFolder stringByAppendingPathComponent:@"schoolDB.db3"]];
    /*
    NSURLRequest *downloadrequest = [NSURLRequest requestWithURL:url];
    NSError *downloaderror = nil;
    NSData   *data = [NSURLConnection sendSynchronousRequest:downloadrequest
                                           returningResponse:nil
                                                       error:&downloaderror];
    if (data != nil){
        NSLog(@"下载成功");
        if ([data writeToFile:@"schoolDB.db3" atomically:YES]) {
            NSLog(@"保存成功.");
        }
        else
        {
            NSLog(@"保存失败.");
        }
    } else {
        NSLog(@"%@", error);
    }
     */
    [[NSUserDefaults standardUserDefaults] setObject:[initDic objectForKey:@"dbVerID"] forKey:@"dbVerID"];

}
-(BOOL)sendEvalutionToServer:(NSString*)jsonString
{
    NSLog(@"%@",jsonString);
    NSString *urlString =[NSString stringWithFormat:@"http://kaplan.douho.net/ajax/pinggu.aspx?action=save&json=%@&app=0",jsonString];
    /*
    NSString *urlString=@"http://cd.douho.net/ajax/pinggu.aspx?action=save&json={\"cityID\":\"1004\",\"degreeID\":\"2\",\"countryID\":\"1\",\"name\":\"tonydai\",\"email\":\"tonydaix@163.com\",\"phone\":\"13981808031\"}&app=0";
     */
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[self getEncodedString:urlString]]];
    [request setHTTPMethod:@"POST"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSString*jssonString = [[NSString alloc]initWithBytes:[responseData bytes]length:[responseData length]encoding:NSUTF8StringEncoding];
    NSLog(jssonString);
    //http://cd.douho.net/ajax/pinggu.aspx?action=save&json={"cityID":"1004","degreeID":"2","countryID":"1","name":"tonydai","email":"tonydaix@163.com","phone":"13981808031"}&app=0
    
    NSDictionary *resultsDictionary = [responseData objectFromJSONData];
    if ([[resultsDictionary objectForKey:@"success"] isEqualToString:@"true"]) {
        NSLog(@"YES!!!!!!");
        return YES;
    }else
        return NO;
}
-(NSString*)getEncodedString:(NSString*)urlString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)urlString,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8));
    return encodedString;
}
@end
