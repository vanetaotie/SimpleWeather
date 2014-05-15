//
//  MainViewController.m
//  SimpleWeather
//
//  Created by vane on 14-5-13.
//  Copyright (c) 2014年 vane.greenisland. All rights reserved.
//

#import "MainViewController.h"
#import "GetJsonWeather.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15, 40, 80, 34)];
    [button setTitle:@"实时天气" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(refreshWeahter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIImageView *imageReset = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reset"]];
    [imageReset setFrame:CGRectMake(270, 43, 30, 30)];
    imageReset.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapImageReset = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetLabel)];
    [imageReset addGestureRecognizer:tapImageReset];
    [self.view addSubview:imageReset];
    
    [self initView];
}

- (void)initView
{
    cityView = [[UILabel alloc] initWithFrame:CGRectMake(100, 140, 120, 60)];
    [cityView setTextColor:[UIColor whiteColor]];
    [cityView setText:@"城市"];
    [cityView setFont:[UIFont fontWithName:@"Helvetica Neue" size:30]];
    [cityView setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:cityView];
    
    weahterView = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 120, 30)];
    [weahterView setTextColor:[UIColor whiteColor]];
    [weahterView setText:@"天气"];
    [weahterView setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [weahterView setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:weahterView];
    
    temperatureView = [[UILabel alloc] initWithFrame:CGRectMake(0, 220, 320, 100)];
    [temperatureView setTextColor:[UIColor whiteColor]];
    [temperatureView setText:@"气温"];
    [temperatureView setFont:[UIFont fontWithName:@"Helvetica" size:60]];
    [temperatureView setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:temperatureView];
    
    windView = [[UILabel alloc] initWithFrame:CGRectMake(100, 310, 120, 30)];
    [windView setTextColor:[UIColor whiteColor]];
    [windView setText:@"风力"];
    [windView setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [windView setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:windView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshWeahter
{
    NSURL *url = [NSURL URLWithString:@"http://api.map.baidu.com/telematics/v3/weather?location=%E5%8D%97%E4%BA%AC&output=json&ak=v8y83rGA6Oy1HSutzHQiFQdV"];
    GetJsonWeather *jsonWeahter = [[GetJsonWeather alloc] init];
    [jsonWeahter getWeatherWithURL:url];
    jsonWeahter.delegate = self;
}

- (void)resetLabel
{
    cityView.text = @"城市";
    weahterView.text = @"天气";
    windView.text = @"风力";
    temperatureView.text = @"气温";
}

#pragma mark GetJsonWeather-Delegate

- (void)GetJsonWeather:(GetJsonWeather *)getJsonWeather today:(NSString *)today city:(NSString *)city week:(NSMutableArray *)week weather:(NSMutableArray *)weather wind:(NSMutableArray *)wind temperature:(NSMutableArray *)temperature
{
    NSLog(@"日期：%@",today);
    NSLog(@"城市：%@",city);
    NSLog(@"周历：%@",[week objectAtIndex:0]);
    NSLog(@"天气：%@",[weather objectAtIndex:0]);
    NSLog(@"风力：%@",[wind objectAtIndex:0]);
    NSLog(@"温度：%@",[temperature objectAtIndex:0]);
    
    //刷新界面
    cityView.text = city;
    weahterView.text = [weather objectAtIndex:0];
    windView.text = [wind objectAtIndex:0];
    temperatureView.text = [temperature objectAtIndex:0];
}

@end
