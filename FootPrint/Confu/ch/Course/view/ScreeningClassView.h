//
//  ScreeningClassView.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/21.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseClassFootModel.h"
#import "InformationfootModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScreeningClassView : UIView

@property (nonatomic, strong)UITableView *tableview;
//placeholder_property//
@property (nonatomic, strong)UIButton *btnOne;

@property (nonatomic, strong)UIButton *btnTow;
//placeholder_property//
@property (nonatomic, strong)UIButton *btnThree;
//placeholder_property//
@property (nonatomic, strong) NSMutableArray<CourseClassFootModel *> *dataSource;
// 单元格选中 index
@property (nonatomic, assign) NSInteger cellSelectIdx;
//placeholder_property//
// 储存第一级别的选中index,如果回退，可以找到
@property (nonatomic,assign) NSInteger levelSelectIndex1;
// 储存第二级别的选中index,如果回退，可以找到

@property (nonatomic,assign) NSInteger levelSelectIndex2;

// 分三个级别来显示， showData 是放第一个层级的数据
@property (nonatomic, strong) NSMutableArray<CourseClassFootModel *> *showData;
//placeholder_property//
// 存放第一个层级的选中索引  默认 为0 ，选中第一个
@property (nonatomic,assign) NSInteger selectLevelModelIndex;
//placeholder_property//

// OldshowData2，  这个是存放第二层级的旧数据，
@property (nonatomic, strong) NSMutableArray<CourseClassFootModel *> *OldshowData2;
// OldSelectLevelModelIndex2 存放第二层级的选中索引 默认为-1 （未选中）
@property (nonatomic,assign) NSInteger OldSelectLevelModelIndex2;

// showData2 当前第二层级的数据
@property (nonatomic, strong) NSMutableArray<CourseClassFootModel *> *showData2;
//selectLevelModelIndex2 当前第二数据的选中索引
@property (nonatomic,assign) NSInteger selectLevelModelIndex2;
//placeholder_property//
// showData3 为第三层的数据
@property (nonatomic, strong) NSMutableArray<CourseClassFootModel *> *showData3;
// selectLevelModelIndex3 为第三个索引的选中
@property (nonatomic,assign) NSInteger selectLevelModelIndex3;
//placeholder_property//

// OldshowData3，  这个是存放第三层级的旧数据，
@property (nonatomic, strong) NSMutableArray<CourseClassFootModel *> *OldshowData3;
// OldSelectLevelModelIndex3 存放第三层级的选中索引 默认为-1 （未选中）
@property (nonatomic,assign) NSInteger OldSelectLevelModelIndex3;
//placeholder_property//


@property (nonatomic,assign) NSInteger currentLevel; // 定义 当前级别 



- (void)setDataSource:(NSMutableArray<CourseClassFootModel *> *)DataSource;
//placeholder_property//
@property (nonatomic, copy) void (^BlocScreeningkClick)(CourseClassFootModel *selectModel);

- (void)initView;
//placeholder_property//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//


@end

NS_ASSUME_NONNULL_END
