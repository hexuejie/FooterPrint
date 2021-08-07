//
//  SilencePageView.h
//  paging
//
//  Created by SilenceMac on 15/12/7.
//  Copyright © 2015年 陈小卫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AjaxResult.h"

@interface SilencePageView : NSObject
@property(assign,nonatomic) NSInteger pageIndex;
@property(assign,nonatomic) NSInteger pageSize;
@property(assign,nonatomic) BOOL isLastPage;
@property(assign,nonatomic) BOOL isLoding;
@property(assign,nonatomic) BOOL isNeedPage;
@property(assign,nonatomic) BOOL isPullRefresh; // 是否是下拉刷新状态


@property(strong,nonatomic) NSString *urlString; // 请求路径
@property(strong,nonatomic) NSString *pageKey;
@property(strong,nonatomic) NSString *pageSizeKey;
@property(strong,nonatomic) NSMutableArray *datas; //数据源
@property(weak,nonatomic) UIScrollView *dataView; // tableview 或者 collectView
@property(strong,nonatomic) void (^pagingCallBack)(BOOL isOk,NSMutableArray *datas,AjaxResult *result); //回调
@property(strong,nonatomic) void (^refreshCallBack)(BOOL isOk,id datas,AjaxResult *result); // 单独使用下拉刷新回调

// 特殊需求 改项目里面有这两个字段来做列表返回数据，特殊处理
// 数组对应的key
@property(nonatomic, strong) NSString *listKey;
// 数据总条数
@property(nonatomic, strong) NSString *totalCountKey;

// 没有更多的提示语
@property(strong,nonatomic) NSString *noMoreDataTipText;

-(instancetype)post:(UIScrollView *)dataView url:(NSString *)URLString parameters:(NSDictionary *)dicParam pagingCallBack:(void (^)(BOOL isOk,NSMutableArray *datas,AjaxResult *result))pagingCallBack;

-(instancetype)post:(UIScrollView *)dataView url:(NSString *)URLString parameters:(NSDictionary *)dicParam refreshCallBack:(void (^)(BOOL isOk,id datas,AjaxResult *result))refreshCallBack;

-(instancetype)get:(UIScrollView *)dataView url:(NSString *)URLString parameters:(NSDictionary *)dicParam pagingCallBack:(void (^)(BOOL isOk,NSMutableArray *datas,AjaxResult *result))pagingCallBack;

-(instancetype)get:(UIScrollView *)dataView url:(NSString *)URLString parameters:(NSDictionary *)dicParam refreshCallBack:(void (^)(BOOL isOk,id datas,AjaxResult *result))refreshCallBack;

-(void)reload;

-(void)downRefresh;

//业务相关的方法
-(void)setParamdDic:(NSDictionary *)param;
-(NSDictionary *)getParam;

// 是否有更多(可以丢给子类去实现)
-(BOOL)pageHasMore:(AjaxResult *)result;

@end
