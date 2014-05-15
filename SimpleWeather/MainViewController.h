//
//  MainViewController.h
//  SimpleWeather
//
//  Created by vane on 14-5-13.
//  Copyright (c) 2014年 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetJsonWeather.h"

@interface MainViewController : UIViewController <GetJsonWeatherDelegate>
{
    UILabel *cityView;//城市
    UILabel *weahterView;//天气
    UILabel *windView;//风力
    UILabel *temperatureView;//温度
}

@end
