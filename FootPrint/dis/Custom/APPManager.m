//
//  APPManager.m
//  VegetableBasket
//
//  Created by Silence on 2017/1/14.
//  Copyright © 2017年 YHS. All rights reserved.
//

#import "APPManager.h"
#import "OpenShare.h"
/**
 *  自身实例
 */
static APPManager *instanceAPPManager;

@interface APPManager()
/**
 *  托管整个app的单例
 */
@property (nonatomic, strong) NSMutableDictionary<NSString *,id> *appSingleInstances;
@end

@implementation APPManager



#pragma mark - 公开方法
+(APPManager *)shareAPPManager{
    
    return instanceAPPManager;
}


+(void)addSingleInstanceWithIdentifier:(NSString *)identifier instance:(id)instance {
    
    [instanceAPPManager.appSingleInstances setObject:instance forKey:identifier];
}

+(id)findSingleInstanceWithIdentifier:(NSString *)identifier {
    return instanceAPPManager.appSingleInstances[identifier];
}

+(void)removeSingleInstanceWithIdentifier:(NSString *)identifier {
    [instanceAPPManager.appSingleInstances removeObjectForKey:identifier];
}

+(void)removeAllSingleInstance {
    [instanceAPPManager.appSingleInstances removeAllObjects];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [self application:application openURL:url];
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    return [self application:app openURL:url];
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url{
    //第二步：添加回调
    if ([OpenShare handleOpenURL:url]) {
        return YES;
    }
    
    return YES;
}

#pragma mark - 私有方法

/**
 *  初始化方法
 *
 *  @return 返回自身对象
 */
-(instancetype)init{
    if (instanceAPPManager == nil) {
        self = [super init];
        if (self) {
            // 初始化相关功能
            self.appSingleInstances = [NSMutableDictionary dictionary];
        }
        instanceAPPManager = self;
    }
    return self;
}
@end
