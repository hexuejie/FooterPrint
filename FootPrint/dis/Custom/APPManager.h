//
//  APPManager.h
//  VegetableBasket
//  app库顶层类
//  Created by Silence on 2017/1/14.
//  Copyright © 2017年 YHS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APPManager : NSObject

/**
 获取自身

 @return APPManager 实例
 */
+(APPManager *)shareAPPManager;



#pragma mark - 单例托管管理
/**
 *  加入需要托管的单例
 *
 *  @param identifier 唯一标识
 *  @param instance   需要托管的单例
 */
+(void)addSingleInstanceWithIdentifier:(NSString *)identifier instance:(id)instance;

/**
 *  加入需要托管的单例
 *
 *  @param identifier 唯一标识
 *
 *  @return 托管的单例
 */
+(id)findSingleInstanceWithIdentifier:(NSString *)identifier;

/**
 *  根据标识移除需要托管的单例
 *
 *  @param identifier 唯一标识
 */
+(void)removeSingleInstanceWithIdentifier:(NSString *)identifier;

/**
 *  移除所有托管的单例
 */
+(void)removeAllSingleInstance;

/**
 *  处理回调
 *
 *  @param application       <#application description#>
 *  @param url               <#url description#>
 *  @param sourceApplication <#sourceApplication description#>
 *  @param annotation        <#annotation description#>
 *
 *  @return <#return value description#>
 */
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options;
@end
