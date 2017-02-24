//
//  ViewController.m
//  ShopCart_RAC
//
//  Created by 陈浩 on 17/2/24.
//  Copyright © 2017年 Ben. All rights reserved.
//

#import "CDViewController.h"
#import "CDCartUIService.h"
#import "CDCartViewModel.h"
#import "CDCartBarView.h"

@interface CDViewController ()
{
    BOOL _isIdit;// 是否为编辑状态
    UIBarButtonItem *_editItem;// 编辑Item
    UIBarButtonItem *_makeDataItem;// 新数据Item
}
@property (nonatomic, strong) CDCartUIService *service;


@property (nonatomic, strong) CDCartViewModel *viewModel;

/**
 *  UITableView
 */
@property (nonatomic, strong) UITableView     *cartTableView;

/**
 *  底部视图
 */
@property (nonatomic, strong) CDCartBarView       *cartBar;

@end

@implementation CDViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    /*setting up*/
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.title = @"购物车";
    /*eidit button*/
    _isIdit = NO;
    _makeDataItem = [[UIBarButtonItem alloc] initWithTitle:@"新数据"
                                                     style:UIBarButtonItemStyleDone
                                                    target:self
                                                    action:@selector(makeNewData:)];
    _makeDataItem.tintColor = kGlobalColor;
    self.navigationItem.leftBarButtonItem = _makeDataItem;
    
    _editItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑"
                                                 style:UIBarButtonItemStyleDone
                                                target:self
                                                action:@selector(editClick:)];
    _editItem.tintColor = kTextColor_47;
    self.navigationItem.rightBarButtonItem = _editItem;
    /*add view*/
    [self.view addSubview:self.cartTableView];
    [self.view addSubview:self.cartBar];
    
    [self getNewData];
    
    /* RAC  */
    /* 观察最底部价格属性 */
    WEAK
    [RACObserve(self.viewModel, allPrices) subscribeNext:^(NSNumber *x) {
        STRONG
        CDLog(@"观察价格属性");
        self.cartBar.money = x.floatValue;
    }];
    
    /* 点击最底部全选按钮 */
    [[self.cartBar.selectAllButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        CDLog(@"全选");
        x.selected = !x.selected;
        [self.viewModel selectAll:x.selected];
    }];
    
    /* 全选按钮的状态根据购物车中的商品是否全部选中变动 */
    RAC(self.cartBar.selectAllButton,selected) = RACObserve(self.viewModel, isSelectAll);
    
    
    //删除
    [[self.cartBar.deleteButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton* x) {
        CDLog(@"删除");
        [self.viewModel deleteGoodsBySelect];
    }];
    //结算
    [[self.cartBar.balanceButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton* x) {
        CDLog(@"结算");
    }];
    
    /* 购物车数量 */
    [RACObserve(self.viewModel, cartGoodsCount) subscribeNext:^(NSNumber *x) {
        STRONG
        NSLog(@"购物车数量");
        if(x.integerValue == 0){
            self.title = [NSString stringWithFormat:@"购物车"];
        } else {
            self.title = [NSString stringWithFormat:@"购物车(%@)",x];
        }
    }];
}


#pragma mark - lazy load

- (CDCartViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel = [[CDCartViewModel alloc] init];
        _viewModel.cartVC = self;
        _viewModel.cartTableView  = self.cartTableView;
    }
    return _viewModel;
}


- (CDCartUIService *)service{
    
    if (!_service) {
        _service = [[CDCartUIService alloc] init];
        _service.viewModel = self.viewModel;
    }
    return _service;
}


- (UITableView *)cartTableView{
    if (!_cartTableView) {
        
        _cartTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)
                                                      style:UITableViewStyleGrouped];
        [_cartTableView registerNib:[UINib nibWithNibName:@"CDShoppingTableViewCell" bundle:nil]
             forCellReuseIdentifier:@"CDShoppingTableViewCell"];
        [_cartTableView registerClass:NSClassFromString(@"CDCartFooterView") forHeaderFooterViewReuseIdentifier:@"CDCartFooterView"];
        [_cartTableView registerClass:NSClassFromString(@"CDCartHeaderView") forHeaderFooterViewReuseIdentifier:@"CDCartHeaderView"];
        _cartTableView.dataSource = self.service;
        _cartTableView.delegate   = self.service;
        _cartTableView.backgroundColor = kGlobalPageColor;
        _cartTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    }
    return _cartTableView;
}

- (CDCartBarView *)cartBar{
    if (!_cartBar) {
        _cartBar = [[CDCartBarView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
        _cartBar.isNormalState = YES;
    }
    return _cartBar;
}

#pragma mark - method

- (void)getNewData{
    /**
     *  获取数据
     */
    [self.viewModel getData];
    [self.cartTableView reloadData];
}

- (void)editClick:(UIBarButtonItem *)item{
    _isIdit = !_isIdit;
    NSString *itemTitle = _isIdit == YES?@"完成":@"编辑";
    _editItem.title = itemTitle;
    self.cartBar.isNormalState = !_isIdit;
}

- (void)makeNewData:(UIBarButtonItem *)item{
    [self getNewData];
}

@end
