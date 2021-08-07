//
//  ScreeningClassView.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/21.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "ScreeningClassView.h"

@interface ScreeningClassView ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, assign) NSInteger selectOneIdx;

@property (nonatomic, assign) NSInteger selectTowIdx;

@property (nonatomic, assign) NSInteger selectThreeIdx;


@end

@implementation ScreeningClassView
//placeholder_method_impl//

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.showData = [NSMutableArray array];
        self.selectLevelModelIndex = 0;
        
        self.showData2 = [NSMutableArray array];
        self.selectLevelModelIndex2 = -1;
//placeholder_method_call//

        self.OldshowData2 = [NSMutableArray array];
        self.OldSelectLevelModelIndex2 = -1;
        
        self.showData3 = [NSMutableArray array];
        self.selectLevelModelIndex3 = -1;
        
        self.OldshowData3 = [NSMutableArray array];
             self.OldSelectLevelModelIndex3 = -1;
        
        
        
 
        self.dataSource = [NSMutableArray array];
        self.cellSelectIdx = 0;
        self.levelSelectIndex1 = 0;
        self.levelSelectIndex2 = 0;
        self.currentLevel = 1;
        self.backgroundColor = kColor_BG;
        [self createView];
        
    }
    return self;
}
//placeholder_method_impl//

- (void)createView{
    
    UIView *viewbg = [[UIView alloc] init];
    viewbg.backgroundColor = [UIColor whiteColor];
    [self addSubview:viewbg];
    //placeholder_method_call//

    [viewbg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.mas_equalTo(self);
        make.trailing.mas_equalTo(self);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    self.btnOne = [[UIButton alloc] init];
    self.btnOne.tag = 101;
    self.btnOne.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.btnOne.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btnOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btnOne.backgroundColor = [UIColor whiteColor];
    [self.btnOne addTarget:self action:@selector(ActionClicl:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnOne setTitle:@"分类" forState:UIControlStateNormal];
    [self.btnOne setTitleColor:RGB(0, 136, 255) forState:UIControlStateNormal];
    [viewbg addSubview:self.btnOne];
    [self.btnOne mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.mas_equalTo(16);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(50);
//        make.width.mas_greaterThanOrEqualTo(50);
    }];
    
    self.btnTow = [[UIButton alloc] init];
    self.btnTow.tag = 102;
    self.btnTow.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.btnTow.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btnTow setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btnTow.backgroundColor = [UIColor whiteColor];
    [self.btnTow addTarget:self action:@selector(ActionClicl:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:self.btnTow];
    [self.btnTow mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self.btnOne.mas_trailing).offset(24);
        make.top.mas_equalTo(self.btnOne);
        make.bottom.mas_equalTo(self.btnOne);
//        make.width.mas_greaterThanOrEqualTo(50);
    }];
    
    self.btnThree = [[UIButton alloc] init];
    self.btnThree.tag = 103;
    self.btnThree.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.btnThree.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btnThree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btnThree.backgroundColor = [UIColor whiteColor];
    [self.btnThree addTarget:self action:@selector(ActionClicl:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:self.btnThree];
    [self.btnThree mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self.btnTow.mas_trailing).offset(24);
        make.top.mas_equalTo(self.btnOne);
        make.bottom.mas_equalTo(self.btnOne);
//        make.width.mas_greaterThanOrEqualTo(50);
        make.trailing.mas_lessThanOrEqualTo(self);
    }];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(1);
        make.leading.mas_equalTo(self).offset(16);
        make.trailing.mas_equalTo(self);
        make.top.mas_equalTo(viewbg.mas_bottom);
    }];
    
    self.tableview = [[UITableView alloc] init];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self);
        make.top.mas_equalTo(51);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.mas_equalTo(self);
    }];
}
// 显示的时候看用户状态
- (void)initView{
    
   // 为-1说明用户没有选任何东西，再点击的时候，就回到最初状态
    if (self.cellSelectIdx == -1) {
        self.btnTow.hidden = YES;
         self.btnThree.hidden = YES;
        //placeholder_method_call//

        [self.btnOne setTitle:@"分类" forState:UIControlStateNormal];
        [self.btnOne setTitleColor:RGB(0, 136, 255) forState:UIControlStateNormal];

//        [self.btnTow setTitleColor:RGB(0, 136, 255) forState:UIControlStateNormal];
           self.showData = self.dataSource;
        
        self.cellSelectIdx = 0;
           [self.tableview reloadData];
       }
    
}
//placeholder_method_impl//

- (void)setDataSource:(NSMutableArray<CourseClassFootModel *> *)DataSource{
    
    _dataSource = DataSource;
    // 这个全部是针对第一级别的全部  level 为1
    CourseClassFootModel *allModel = [[CourseClassFootModel alloc] init];
    allModel.cate_name = @"全部";
    allModel.name = @"全部";
    allModel.level = @"1";
    //placeholder_method_call//

    [_dataSource insertObject:allModel atIndex:0];

    for (CourseClassFootModel *model in DataSource) {
        
        if (model.pid == nil) {
            
            continue;
        }
        model.level = @"1";
        
        if (model.child.count != 0) {
            // 这个全部是针对第二级别的全部  level 全部的话level 应该也是为1
            CourseClassFootModel *allModel = [[CourseClassFootModel alloc] init];
            allModel.cate_name = @"全部";
            allModel.name = model.cate_name;
            allModel.level = @"1";
            allModel.id = model.id;
            [model.child insertObject:allModel atIndex:0];
            
            for (CourseClassFootModel *model2 in model.child) {
                if ([model2.cate_name isEqualToString:@"全部"]) {
                    model2.level = @"1";
                } else {
                    model2.level = @"2";
                }
                
                if (model2.child.count != 0) {
                    
                    CourseClassFootModel *allModel = [[CourseClassFootModel alloc] init];
                    allModel.cate_name = @"全部";
                    allModel.level = @"1";
                    allModel.name = model2.cate_name;
                    allModel.id = model2.id;
                    [model2.child insertObject:allModel atIndex:0];

                    for (CourseClassFootModel *model3 in model2.child) {
                        if ([model3.cate_name isEqualToString:@"全部"]) {
                                           model2.level = @"2";
                                       } else {
                                           model2.level = @"3";
                                       }
                        
                           if (model3.child.count != 0) {
                                              
                                              CourseClassFootModel *allModel = [[CourseClassFootModel alloc] init];
                                              allModel.cate_name = @"全部";
                                              allModel.level = @"1";
                                              allModel.name = model3.cate_name;
                                              allModel.id = model3.id;
                                              [model3.child insertObject:allModel atIndex:0];
                           }
                        
                        
                    }
                }
#warning mark - 待删除
     /////////////////////////////////////////////////////
               // 手动模拟数据
//                if ([model2.cate_name isEqualToString:@"关于"]) {
//                    CourseClassModel *allModel = [[CourseClassModel alloc] init];
//                                      allModel.cate_name = @"模拟子类";
//                                      allModel.level = @"3";
//                                      allModel.name = model2.cate_name;
//                                      allModel.id = model2.id;
//                                      [model2.child insertObject:allModel atIndex:0];
//                }
                
               
                
     /////////////////////////////////////////////////////
                
                
                
                
            }
        }
    }
    
    self.showData = self.dataSource;
    [self.tableview reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.currentLevel == 1) {
        return self.showData.count;
    }
    if (self.currentLevel == 2) {
        return self.showData2.count;

    }
    //placeholder_method_call//

    if (self.currentLevel == 3) {
          return self.showData3.count;

      }
    
    
    return 0;
}
//placeholder_method_impl//

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return 50;
}
//placeholder_method_impl//


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    //placeholder_method_call//

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, SCREEN_WIDTH-16, 50)];
    title.font = [UIFont systemFontOfSize:14.0];
    title.numberOfLines = 0;
    title.textColor = [UIColor blackColor];

    if (self.currentLevel == 1) {
        title.text = self.showData[indexPath.row].cate_name;
        if (self.selectLevelModelIndex == indexPath.row) {
               title.textColor = RGB(0, 136, 255);
           } else {
               title.textColor = [UIColor blackColor];
           }
        
        
    }
    if (self.currentLevel == 2) {
        title.textColor = [UIColor blackColor];
           title.text = self.showData2[indexPath.row].cate_name;
        if (self.OldshowData2.count > 0) {
            // 在第二级别中有选中的并且和之前的匹配才是选中颜色
            if ([self.showData2[0].id isEqualToString:self.OldshowData2[0].id]) {
                if (self.OldSelectLevelModelIndex2 == indexPath.row) {
                    title.textColor = RGB(0, 136, 255);

                } else {
                    title.textColor = [UIColor blackColor];
                }

                
        }
        }
        
       }
    
    
    
    if (self.currentLevel == 3) {
           title.textColor = [UIColor blackColor];
              title.text = self.showData3[indexPath.row].cate_name;
           if (self.OldshowData3.count > 0) {
               // 在第二级别中有选中的并且和之前的匹配才是选中颜色
               if ([self.showData3[0].id isEqualToString:self.OldshowData3[0].id]) {
                   if (self.OldSelectLevelModelIndex3 == indexPath.row) {
                       title.textColor = RGB(0, 136, 255);

                   } else {
                       title.textColor = [UIColor blackColor];
                   }

                   
           }
           }
           
          }
    
    
    
    
    
    [cell addSubview:title];
    
    return cell;
}
//placeholder_method_impl//

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CourseClassFootModel *selectModel;

    if (self.currentLevel == 1) {
         selectModel = self.showData[indexPath.row];
//        selectLevelModelIndex
        self.selectLevelModelIndex = indexPath.row;
        [self.btnOne setTitle:selectModel.cate_name forState:UIControlStateNormal];
        self.btnTow.hidden = YES;
        if (selectModel.child.count == 0) {
            //placeholder_method_call//

         [self.btnOne setTitleColor:RGB(0, 136, 255) forState:UIControlStateNormal];
            
            if (self.BlocScreeningkClick) {
                self.BlocScreeningkClick(selectModel);
            }
        } else {
            [self.btnOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.btnTow setTitleColor:RGB(0, 136, 255) forState:UIControlStateNormal];
            [self.btnTow setTitle:@"分类" forState:UIControlStateNormal];
            self.btnTow.hidden = NO;
            self.showData2 = selectModel.child;
            self.currentLevel = 2;
        }
        

        [self.tableview reloadData];

       return;
    }
    
    if (self.currentLevel == 2) {
           selectModel = self.showData2[indexPath.row];
        self.selectLevelModelIndex2 = indexPath.row;
                     // 先记录之前的旧数据，方便后面显示
                       self.OldshowData2 = self.showData2;
                       self.OldSelectLevelModelIndex2 = self.selectLevelModelIndex2;
        [self.btnTow setTitle:selectModel.cate_name forState:UIControlStateNormal];

        if (selectModel.child.count == 0) {
             [self.btnTow setTitle:selectModel.cate_name forState:UIControlStateNormal];
            
            if (self.BlocScreeningkClick) {
            self.BlocScreeningkClick(selectModel);
            }
        } else {
            [self.btnOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                      [self.btnTow setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                 [self.btnThree setTitleColor:RGB(0, 136, 255) forState:UIControlStateNormal];
                      self.btnThree.hidden = NO;
                       [self.btnThree setTitle:@"分类" forState:UIControlStateNormal];
                      self.showData3 = selectModel.child;
                      self.currentLevel = 3;
        }
        
        [self.tableview reloadData];

        return;
      }

    
    if (self.currentLevel == 3) {
            selectModel = self.showData3[indexPath.row];
         self.selectLevelModelIndex3 = indexPath.row;
                      // 先记录之前的旧数据，方便后面显示
                        self.OldshowData3 = self.showData3;
                        self.OldSelectLevelModelIndex3 = self.selectLevelModelIndex3;
         
         if (selectModel.child.count == 0) {
              [self.btnTow setTitle:selectModel.cate_name forState:UIControlStateNormal];
             
             if (self.BlocScreeningkClick) {
             self.BlocScreeningkClick(selectModel);
             }
         }
         
         [self.tableview reloadData];

         return;
       }
    
    
    
   
}
//placeholder_method_impl//

- (void)ActionClicl:(UIButton *)sender{
    
    NSInteger level = sender.tag - 100;
    // 1级目录点击，回到1级目录
    if (level == 1) {
        self.btnTow.hidden = YES;
        [self.btnOne setTitleColor:RGB(0, 136, 255) forState:UIControlStateNormal];
        [self.btnOne setTitle:@"分类" forState:UIControlStateNormal];
        self.currentLevel = 1;
        [self.tableview reloadData];
    }
    //placeholder_method_call//

    if (level == 2) {
        self.btnThree.hidden = YES;
        [self.btnTow setTitle:@"分类" forState:UIControlStateNormal];
        [self.btnTow setTitleColor:RGB(0, 136, 255) forState:UIControlStateNormal];
        self.currentLevel = 2;
        [self.tableview reloadData];

    }
    
    
    
    
   
}
//placeholder_method_impl//

@end
