//
//  CommentsVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/22.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "CommentsVC.h"
#import "SilenceAutoHeightTableViewUtil.h"
#import "SilencePageView.h"
#import "CommentsCell.h"
#import "CommentsFootModel.h"
#import "CommentView.h"
#import "IQKeyboardManager.h"

@interface CommentsVC ()

@property (nonatomic, strong) SilencePageView *pageView;

@property (nonatomic, strong) NSMutableArray<CommentsFootModel *> *dataSource;

@property (nonatomic, strong) SilenceAutoHeightTableViewUtil *tableUtil;

@end

@implementation CommentsVC

#pragma mark - yy类注释逻辑
//placeholder_method_impl//

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //写入这个方法后,这个页面将没有这种效果
    [IQKeyboardManager sharedManager].enable = NO;
}
//placeholder_method_impl//

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //placeholder_method_call//

    //最后还设置回来,不要影响其他页面的效果
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //placeholder_method_call//

    self.title = @"评论";
    
    self.dataSource = [NSMutableArray array];
    
    [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-KSafeAreaHeight)];
    [self.tableView registerNib:[UINib nibWithNibName:@"ReplyMessageCell" bundle:nil] forCellReuseIdentifier:@"ReplyMessageCell"];
    
    self.tableUtil = [[SilenceAutoHeightTableViewUtil alloc] initWithTableView:self.tableView dataSource:self.dataSource identifier:@"CommentsCell" estimatedHeight:100 cellConfig:^(CommentsCell *cell, NSIndexPath *indexPath, id data) {
        
        CommentsFootModel *model = self.dataSource[indexPath.row];
        
        cell.model = self.dataSource[indexPath.row];
        [cell.btnCommentsNum addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {

            [APPRequest POST:@"/niceComment" parameters:@{@"comment_id":model.id,@"cid":self.courseId,} finished:^(AjaxResult *result) {

                if (result.code == AjaxResultStateSuccess) {

                    if ([result.message isEqualToString:@"点赞成功"]) {

                        model.is_like = @"1";
                        model.supnum = [NSString stringWithFormat:@"%ld",[model.supnum integerValue] + 1];
                    }else if([result.message isEqualToString:@"取消点赞成功"]){

                        model.is_like = @"0";
                        model.supnum = [NSString stringWithFormat:@"%ld",[model.supnum integerValue] - 1];
                    }
                    [self.dataSource replaceObjectAtIndex:indexPath.row withObject:model];
                    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                }
            }];
        }];
        
    } didSelectedRow:^(NSIndexPath *indexPath, id data) {
        
    }];
    WS(weakself);
    self.tableUtil.scrollViewDidScrollBlock = ^(UIScrollView *scrollView) {
        
        [weakself setFootViewoffset:scrollView];
    };
    self.additionalHeight = -50;
    [self addDefaultFootView];
    //placeholder_method_call//

    self.pageView = [[SilencePageView alloc] get:self.tableView url:@"/courseComment" parameters:@{@"id":self.courseId,} pagingCallBack:^(BOOL isOk, NSMutableArray *datas, AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            if (datas.count == 0) {
                
                [self showEmptyView:EmptyViewTypeComments eventBlock:^(EmptyViewEventType eventType) {
                    
                }];
            }else{
                
                [self hideEmptyView];
            }
            
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:[CommentsFootModel mj_objectArrayWithKeyValuesArray:datas]];
            [self.tableView reloadData];
            
            if (self.isBuy) {

                if ([result.data[@"is_comment"] integerValue] == 0) {

                    [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-50-KSafeAreaHeight)];
                    [self createCommentsView];
                }else{

                    UIView *view = [self.view viewWithTag:999];
                    [view removeFromSuperview];
                    [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-KSafeAreaHeight)];
                }
            }
        }
    }];
    
    [self loadData];
}
//placeholder_method_impl//

#pragma mark - 代理

#pragma mark 系统代理

#pragma mark 自定义代理

#pragma mark - 事件

#pragma mark - 公开方法

- (void)loadData{
    
    [self.pageView downRefresh];
}

- (void)createCommentsView{
    
    UIView *view = [[UIView alloc] init];
    view.tag = 999;
    [view addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        CommentView *view = [[[NSBundle mainBundle] loadNibNamed:@"CommentView" owner:nil options:nil] lastObject];
        view.frame = self.view.bounds;
        view.BlockReleasClick = ^(NSString * _Nonnull content) {
          
            [APPRequest POST:@"/publishComment" parameters:@{@"content":content,@"cid":self.courseId,} finished:^(AjaxResult *result) {
               
                if (result.code == AjaxResultStateSuccess) {
                    
                    if (self.BlockReloadClick) {
                        self.BlockReloadClick();
                    }
                    [self.pageView downRefresh];
                }
            }];
        };
        [self.view addSubview:view];
    }];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.mas_equalTo(self.view);
        make.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(self.view).offset(-KSafeAreaHeight);
    }];
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = @"发表你的评论～";
    lbl.font = [UIFont systemFontOfSize:16.0];
    lbl.textColor = RGB(153, 153, 153);
    [view addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.mas_equalTo(12);
        make.centerY.mas_equalTo(view);
    }];
    //placeholder_method_call//

    UILabel *lbl1 = [[UILabel alloc] init];
    lbl1.text = @"发布";
    lbl1.textColor = [UIColor colorWithHex:0x479298];
    lbl1.font = [UIFont systemFontOfSize:16.0];
    [view addSubview:lbl1];
    [lbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.trailing.mas_equalTo(view.mas_trailing).offset(-12);
        make.centerY.mas_equalTo(view);
    }];
    
//    view.backgroundColor = [UIColor colorWithHex:0xf8f8f8];

    view.backgroundColor = [UIColor colorWithHex:0xf8f8f8];
}

#pragma mark - 私有方法

#pragma mark - get set
//placeholder_method_impl//

@end
