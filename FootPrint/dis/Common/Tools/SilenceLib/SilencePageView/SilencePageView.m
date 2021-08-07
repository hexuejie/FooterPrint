//
//  SilencePageView.m
//  paging
//
//  Created by SilenceMac on 15/12/7.
//  Copyright © 2015年 SilenceMac. All rights reserved.
//

#import "SilencePageView.h"
#import "MJRefresh.h"
#import "APPRequest.h"
#import "ImportHeader.h"
#import "MJCustomFooter.h"
@interface SilencePageView()
@property(strong,nonatomic) SilencePageView *instance;


@property(strong,nonatomic) NSMutableDictionary *param; //参数
@property(assign,nonatomic) BOOL isPost; //参数

@property (nonatomic,assign) BOOL hasmore;// 是否有更多

@property(assign,nonatomic) NSInteger dataCount;

@end

@implementation SilencePageView

-(instancetype)get:(UIScrollView *)dataView url:(NSString *)URLString parameters:(NSDictionary *)dicParam refreshCallBack:(void (^)(BOOL, id, AjaxResult *))refreshCallBack{
    [self post:dataView url:URLString parameters:dicParam refreshCallBack:refreshCallBack];
    self.isPost = NO;
    return self;
}

-(instancetype)get:(UIScrollView *)dataView url:(NSString *)URLString parameters:(NSDictionary *)dicParam pagingCallBack:(void (^)(BOOL, NSMutableArray *, AjaxResult *))pagingCallBack{
    [self post:dataView url:URLString parameters:dicParam pagingCallBack:pagingCallBack];
    self.isPost = NO;
    return self;
}

-(instancetype)post:(UIScrollView *)dataView url:(NSString *)URLString parameters:(NSDictionary *)dicParam pagingCallBack:(void (^)(BOOL, NSMutableArray *,AjaxResult *))pagingCallBack{
    self.isPost = YES;
    self.param = [NSMutableDictionary dictionary];
    self.urlString = URLString;
    [self.param setDictionary:dicParam];
    self.pagingCallBack = pagingCallBack;
    self.pageSizeKey = @"size";
    self.pageKey = @"page";
    self.totalCountKey = @"totalCount";
    
    return [self initWithDataView:dataView];
}

-(instancetype)post:(UIScrollView *)dataView url:(NSString *)URLString parameters:(NSDictionary *)dicParam refreshCallBack:(void (^)(BOOL, id,AjaxResult *))refreshCallBack{
    self.isPost = YES;
    self.param = [NSMutableDictionary dictionary];
    self.urlString = URLString;
    [self.param setDictionary:dicParam];
    self.refreshCallBack = refreshCallBack;
    SilencePageView *pageView = [self initWithDataView:dataView];
    [pageView setIsNeedPage:NO];
    return pageView;
}

-(instancetype)initWithDataView:(UIScrollView *)dataView{
    self = [super init];
    if (self) {
        self.instance = self;
        self.datas = [NSMutableArray array];
        self.pageIndex = 1;
        self.pageSize = 10;
        self.isLoding = NO;
        self.isLastPage = NO;
        self.isNeedPage =YES;
        self.dataView = dataView;
        [self createHeaderView];
        [self createFooterView];
    }
    return self;
}

-(void)setParamdDic:(NSDictionary *)param{
    self.param = [NSMutableDictionary dictionary];
    [self.param setDictionary:param];
}
-(NSDictionary *)getParam{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:self.param];
    [param removeObjectForKey:self.pageKey];
    [param removeObjectForKey:self.pageSizeKey];
    return param;
}

-(void)setIsNeedPage:(BOOL)isNeedPage{
    _isNeedPage = isNeedPage;
    if (!isNeedPage) {
        self.dataView.mj_footer = nil;
    }
}



#pragma mark - 创建头部和底部
-(void)createHeaderView{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 马上进入刷新状态
    //    [header beginRefreshing];
    
    // 设置header
    self.dataView.mj_header = header;
    
}

-(void)createFooterView{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    //自定义上拉
    MJCustomFooter *footer = [MJCustomFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 自动加载
    footer.automaticallyRefresh = YES;
    self.dataView.backgroundColor = [UIColor clearColor];
    // 设置footer
    self.dataView.mj_footer = footer;
}

-(void)setNoMoreDataTipText:(NSString *)noMoreDataTipText{
    [(MJRefreshAutoNormalFooter *)self.dataView.mj_footer setTitle:noMoreDataTipText forState:MJRefreshStateNoMoreData];
}


#pragma mark - 加载数据

//下拉刷新
- (void)downRefresh{

    [self.dataView.mj_header beginRefreshing];
}

//加载当前数据
-(void)reload{

    [self.datas removeAllObjects];
    self.pageIndex = 1;
    self.pageSize = self.dataCount * 10;
    [self loadData];
}

#pragma mark 下拉刷新
- (void)loadNewData
{
    // 拿到当前的上拉刷新控件，结束刷新状态
    [self.dataView.mj_footer endRefreshing];
    // 重置为第一页
    self.pageIndex = 1;
    self.dataCount = self.pageIndex;
    self.pageSize = 10;
    self.isLastPage = NO;
    self.hasmore = YES;
    [self.datas removeAllObjects];
    [self loadData];
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    if (self.isLoding || self.isLastPage) {
        return;
    }
    // 加一页
    self.pageIndex ++;
    self.dataCount = self.pageIndex;
    self.pageSize = 10;
    self.isPullRefresh = NO;
    [self loadData];
}

#pragma mark - 加载数据
-(void)loadData{
    if (KUserId) {
        if([[self.param allKeys] containsObject:@"userId"]){

            [self.param setObject:KUserId forKey:@"userId"];
        }
    }else{
        [self.param removeObjectForKey:@"userId"];
    }
    // 仅仅是刷新模式
    if (self.refreshCallBack) {
        if (_isPost) {
            [APPRequest POST:self.urlString parameters:self.param  finished:^(AjaxResult *result) {
                [self handleRefreshCallBack:result];
            }];
        }else{
            [APPRequest GET:self.urlString parameters:self.param  finished:^(AjaxResult *result) {
                [self handleRefreshCallBack:result];
            }];
        }
    }
    // 上下拉，返回数据为数组类型
    else{
        self.isLoding = YES;
        [self.param setObject:@(_pageIndex) forKey:self.pageKey];
        [self.param setObject:@(_pageSize) forKey:self.pageSizeKey];
        if (_isPost) {
            [APPRequest POST:self.urlString parameters:self.param finished:^(AjaxResult *result) {
                [self handlePagingCallBack:result];
            }];
        }else{
            [APPRequest GET:self.urlString parameters:self.param finished:^(AjaxResult *result) {
                [self handlePagingCallBack:result];
            }];
        }
    }
}

// 处理刷新结果集
-(void)handleRefreshCallBack:(AjaxResult *)result{
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.dataView.mj_header endRefreshing];
    self.isPullRefresh = YES;
    if (result.code == AjaxResultStateSuccess) {
        self.refreshCallBack(YES,result.data,result);
    }else{
        self.refreshCallBack(NO,result.data,result);
    }
}

//处理分页结果集
-(void)handlePagingCallBack:(AjaxResult *)result{
    self.isLoding = NO;
    
    if (result) {
        if (result.code == AjaxResultStateSuccess) {
            
            NSArray *array = @[];
            if ([self.urlString isEqualToString:@"/lives"]) {
                
                array = result.data[@"data"];
            }else{
                
                array = result.data[@"list"];
            }
            
            if (self.listKey != nil) {
                array = result.data[self.listKey];
            }
            
            if (self.pageIndex == 1) { // 这种情况属于下拉刷新
                // 拿到当前的下拉刷新控件，结束刷新状态
                [self.dataView.mj_header endRefreshing];
                self.isPullRefresh = YES;
                //最后一页
                if (![self pageHasMore:result]) {
                    self.isLastPage = YES;
                    // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                    [self.dataView.mj_footer endRefreshingWithNoMoreData];
                    //                self.noMoreDataTipText = @"";
                    
                    //判断虽然是最后一页，但是还有数据的情况
                    if (array != nil && array.count > 0){
                        [self.datas addObjectsFromArray:array];
                    }
                    self.pagingCallBack(YES,self.datas,result);
                }else{
                    if (self.pagingCallBack) {
                        [self.datas addObjectsFromArray:array];
                        self.pagingCallBack(YES,self.datas,result);
                    }
                }
            }
            // 上推加载更多
            else{
                //最后一页
                if (![self pageHasMore:result]) {
                    self.isLastPage = YES;
                    // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                    [self.dataView.mj_footer endRefreshingWithNoMoreData];
                    //                self.noMoreDataTipText = @"";
                    //判断虽然是最后一页，但是还有数据的情况
                    if (array != nil && array.count > 0){
                        [self.datas addObjectsFromArray:array];
                    }
                    self.pagingCallBack(YES,self.datas,result);
                }else{
                    // 拿到当前的上拉刷新控件，结束刷新状态
                    [self.dataView.mj_footer endRefreshing];
                    [self.datas addObjectsFromArray:array];
                    if (self.pagingCallBack) {
                        self.pagingCallBack(YES,self.datas,result);
                    }
                }
            }
        }else {// 失败
            [self.dataView.mj_header endRefreshing];
            if (self.pagingCallBack) {
                self.pagingCallBack(NO,self.datas,result);
            }
        }
    }else{// 失败
        [self.dataView.mj_header endRefreshing];
        if (self.pagingCallBack) {
            self.pagingCallBack(NO,self.datas,result);
        }
    }
}


-(BOOL)pageHasMore:(AjaxResult *)result{
    // 特殊需求
    if (self.listKey != nil && self.totalCountKey != nil) {
        return self.datas.count < [result.data[self.totalCountKey] integerValue];
    }
    
    else{
        NSArray *array = result.data[@"list"];
        self.hasmore = YES;
        if (array == nil || array.count == 0 || array.count < self.pageSize) {
            self.hasmore = NO;
        }
        return self.hasmore;
    }
}

@end
