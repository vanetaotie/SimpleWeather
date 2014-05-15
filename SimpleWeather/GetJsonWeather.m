//
//  GetJsonWeather.m
//  SimpleWeather
//
//  Created by vane on 14-5-13.
//  Copyright (c) 2014年 vane.greenisland. All rights reserved.
//

#import "GetJsonWeather.h"

@implementation GetJsonWeather

- (void)getWeatherWithURL:(NSURL *)url
{
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if ([data length]>0 && error == nil) {
            NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            today = [weatherDic objectForKey:@"date"];
            
            NSArray *results = [weatherDic objectForKey:@"results"];
            NSDictionary *resultsDic = [results objectAtIndex:0];
            currentCity = [resultsDic objectForKey:@"currentCity"];
            
            NSArray *weather_data = [resultsDic objectForKey:@"weather_data"];
            detailWeek = [[NSMutableArray alloc] initWithCapacity:20];
            detailWeather = [[NSMutableArray alloc] initWithCapacity:20];
            detailWind = [[NSMutableArray alloc] initWithCapacity:20];
            detailTemperature = [[NSMutableArray alloc] initWithCapacity:20];
            for (NSDictionary *weatherData in weather_data)
            {
                [detailWeek addObject:[weatherData objectForKey:@"date"]];
                [detailWeather addObject:[weatherData objectForKey:@"weather"]];
                [detailWind addObject:[weatherData objectForKey:@"wind"]];
                [detailTemperature addObject:[weatherData objectForKey:@"temperature"]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //数据传输
                [self.delegate GetJsonWeather:self today:today city:currentCity week:detailWeek weather:detailWeather wind:detailWind temperature:detailTemperature];
            });
        }else if ([data length] == 0 && error == nil){
            NSLog(@"没有数据");
        }else if (error != nil){
            NSLog(@"发生错误：%@",error);
        }
    }];
}

@end
