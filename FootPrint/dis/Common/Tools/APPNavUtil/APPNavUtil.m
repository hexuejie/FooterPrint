//
//  APPNavUtil.m
//  Dy
//
//  Created by 陈小卫 on 16/6/29.
//  Copyright © 2016年 陈小卫. All rights reserved.
//

#import "APPNavUtil.h"
#import <CoreLocation/CLLocation.h>
#import <MapKit/MKMapItem.h>
@interface APPNavUtil()<UIActionSheetDelegate>
@property (nonatomic,strong) NSMutableArray *availableMaps;
@property (nonatomic, strong) UserLocation *fromLocation;
@property (nonatomic, strong) UserLocation *toLocation;
@property (nonatomic, strong) UserLocation *toEndLocation;

@property (nonatomic, weak) UIView *inView;
@end

@implementation APPNavUtil

-(void)navInView:(UIView *)inView fromLocation:(UserLocation *)from toLocation:(UserLocation *)to{
    self.inView = inView;
    self.fromLocation = from;
    self.toLocation = to;
    self.toEndLocation = to;
    [self navGo];
}




#pragma mark - 发起导航

- (void)navGo{
    [self availableMapsApps];
    UIActionSheet *action = [[UIActionSheet alloc] init];
    action.tag = 1068;
    
    [action addButtonWithTitle:@"使用系统自带地图导航"];
    for (NSDictionary *dic in self.availableMaps) {
        [action addButtonWithTitle:[NSString stringWithFormat:@"%@", dic[@"name"]]];
    }
    [action addButtonWithTitle:@"取消"];
    action.cancelButtonIndex = self.availableMaps.count + 1;
    action.delegate = self;
    [action showInView:self.inView];
}


- (void)availableMapsApps {
    if(_toLocation == nil || _fromLocation == nil)
    {
        return;
    }
    CLLocationCoordinate2D startCoor = {_fromLocation.latitude,_fromLocation.longitude};
    CLLocationCoordinate2D endCoor = {_toLocation.latitude,_toLocation.longitude};
    
    self.availableMaps = @[].mutableCopy;
    
    NSString *toName = _toLocation.name;
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://map/"]]){
        NSString *urlString = [NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:%@&mode=transit",
                               startCoor.latitude, startCoor.longitude, endCoor.latitude, endCoor.longitude, toName];
        
        NSDictionary *dic = @{@"name": @"百度地图",
                              @"url": urlString};
        [self.availableMaps addObject:dic];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSString *urlString = [NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=applicationScheme&poiname=%@&poiid=BGVIS&lat=%f&lon=%f&dev=0&style=3",
                               toName,toName, endCoor.latitude, endCoor.longitude];
        
        NSDictionary *dic = @{@"name": @"高德地图",
                              @"url": urlString};
        [self.availableMaps addObject:dic];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        NSString *urlString = [NSString stringWithFormat:@"comgooglemaps://?saddr=%@&daddr=%f,%f¢er=%f,%f&directionsmode=transit", toName,endCoor.latitude, endCoor.longitude, startCoor.latitude, startCoor.longitude];
        
        NSDictionary *dic = @{@"name": @"Google Maps",
                              @"url": urlString};
        [self.availableMaps addObject:dic];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        CLLocationCoordinate2D startCoor = {_fromLocation.latitude,_fromLocation.longitude};
        CLLocationCoordinate2D endCoor = {_toLocation.latitude,_toLocation.longitude};
        
        if (iOS7Later) {
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:placemark];
            toLocation.name = _toLocation.name;
            
            [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
        }else{
            NSString *urlString = [[NSString alloc] initWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&dirfl=d",startCoor.latitude,startCoor.longitude,endCoor.latitude,endCoor.longitude];
            urlString =  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *aURL = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:aURL];
        }
    }else if (buttonIndex < self.availableMaps.count+1) {
        NSDictionary *mapDic = self.availableMaps[buttonIndex-1];
        NSString *urlString = mapDic[@"url"];
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
}


@end
