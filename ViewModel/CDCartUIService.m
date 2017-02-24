//
//  CDCartUIService.m
//  CDBaseDemoOC
//
//  Created by 陈浩 on 17/1/22.
//  Copyright © 2017年 Ben. All rights reserved.
//

#import "CDCartUIService.h"
#import "CDCartViewModel.h"
#import "CDShoppingTableViewCell.h"
#import "CDCartHeaderView.h"
#import "CDCartFooterView.h"
#import "CDCartModel.h"
#import "CDNumberCountView.h"

@implementation CDCartUIService

#pragma mark - UITableView Delegate/DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.cartData.count;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel.cartData[section] count];
}

#pragma mark - header view

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return [CDCartHeaderView getCartHeaderHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSMutableArray *shopArray = self.viewModel.cartData[section];
    
    CDCartHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CDCartHeaderView"];
    //店铺全选
    [[[headerView.selectStoreGoodsButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:headerView.rac_prepareForReuseSignal] subscribeNext:^(UIButton* x) {
        x.selected = !x.selected;
        BOOL isSelect = x.selected;
        [self.viewModel.shopSelectArray replaceObjectAtIndex:section withObject:@(isSelect)];
        for (CDCartModel* model in shopArray){
            [model setValue:@(isSelect) forKey:@"isSelect"];
        }
        [self.viewModel.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
        self.viewModel.allPrices = [self.viewModel getAllPrices];
    }];
    //店铺选中状态
    headerView.selectStoreGoodsButton.selected = [self.viewModel.shopSelectArray[section] boolValue];
    
    return headerView;
}

#pragma mark - footer view

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [CDCartFooterView getCartFooterHeight];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    NSMutableArray *shopArray = self.viewModel.cartData[section];
    
    CDCartFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CDCartFooterView"];
    
    footerView.shopGoodsArray = shopArray;
    
    return footerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [CDShoppingTableViewCell getCartCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CDShoppingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CDShoppingTableViewCell"
                                                       forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(CDShoppingTableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    CDCartModel *model = self.viewModel.cartData[section][row];
    //cell 选中
    WEAK
    // 选中cell按钮
    /**
     *  - takeUntil:(RACSignal *) : 当给定的signal完成前一直取值
     *  rac_prepareForReuseSignal : Cell复用时的清理
     说到UITableView，再说一下UITableViewCell，RAC给UITableViewCell提供了一个方法：rac_prepareForReuseSignal，它的作用是当Cell即将要被重用时，告诉Cell。想象Cell上有多个button，Cell在初始化时给每个button都addTarget:action:forControlEvents，被重用时需要先移除这些target
     */
    [[[cell.selectShopGoodsButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(UIButton* x) {
        STRONG
        CDLog(@"选中");
        x.selected = !x.selected;
        [self.viewModel rowSelect:x.selected IndexPath:indexPath];
    }];
    //数量改变
    cell.nummberCount.NumberChangeBlock = ^(NSInteger changeCount){
        STRONG
        CDLog(@"数量改变");
        [self.viewModel rowChangeQuantity:changeCount indexPath:indexPath];
    };
    cell.model = model;
}

#pragma mark - delete
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.viewModel deleteGoodsBySingleSlide:indexPath];
    }
}

@end
