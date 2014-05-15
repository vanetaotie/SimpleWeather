//
//  GetJsonWeather.h
//  SimpleWeather
//
//  Created by vane on 14-5-13.
//  Copyright (c) 2014年 vane.greenisland. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GetJsonWeather;

@protocol GetJsonWeatherDelegate <NSObject>

- (void)GetJsonWeather:(GetJsonWeather *)getJsonWeather today:(NSString *)today city:(NSString *)city week:(NSMutableArray *)week weather:(NSMutableArray *)weather wind:(NSMutableArray *)wind temperature:(NSMutableArray *)temperature;

@end

@interface GetJsonWeather : NSObject
{
    NSString *today;//当天日期
    NSString *currentCity;//当前城市
    NSMutableArray *detailWeek;//星期几
    NSMutableArray *detailWeather;//气象
    NSMutableArray *detailWind;//风力
    NSMutableArray *detailTemperature;//温度
}

@property (nonatomic, weak) id <GetJsonWeatherDelegate> delegate;
- (void)getWeatherWithURL:(NSURL *)url;//通过url获取天气数据

@end
