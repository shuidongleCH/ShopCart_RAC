//
//  CDCartViewModel.m
//  CDBaseDemoOC
//
//  Created by 陈浩 on 17/1/22.
//  Copyright © 2017年 Ben. All rights reserved.
//

#import "CDCartViewModel.h"
#import "CDCartModel.h"

@interface CDCartViewModel (){
    
    NSArray *_shopGoodsCount;
    NSArray *_goodsPriceArray;
    NSArray *_goodsQuantityArray;
    
}
//随机获取店铺下商品数
@property (nonatomic, assign) NSInteger random;
@end

@implementation CDCartViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        //6
        _shopGoodsCount  = @[@(1),@(8),@(5),@(2),@(4),@(4)];
        _goodsPriceArray = @[@(30.45),@(120.09),@(7.8),@(11.11),@(56.1),@(12)];
        _goodsQuantityArray = @[@(12),@(21),@(1),@(10),@(3),@(5)];
    }
    return self;
}

- (NSInteger)random{
    
    NSInteger from = 0;
    NSInteger to   = 5;
    
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
    
}

#pragma mark - make data

- (void)getData{
    //数据个数
    NSInteger allCount = 20;
    NSInteger allGoodsCount = 0;
    NSMutableArray *storeArray = [NSMutableArray arrayWithCapacity:allCount];
    NSMutableArray *shopSelectAarry = [NSMutableArray arrayWithCapacity:allCount];
    //创造店铺数据
    for (int i = 0; i<allCount; i++) {
        //创造店铺下商品数据
        NSInteger goodsCount = [_shopGoodsCount[self.random] intValue];
        NSMutableArray *goodsArray = [NSMutableArray arrayWithCapacity:goodsCount];
        for (int x = 0; x<goodsCount; x++) {
            CDCartModel *cartModel = [[CDCartModel alloc] init];
            cartModel.p_id         = @"122115465400";
            cartModel.p_price      = [_goodsPriceArray[self.random] floatValue];
            cartModel.p_stock      = 22;
            cartModel.p_quantity   = [_goodsQuantityArray[self.random] integerValue];
            [goodsArray addObject:cartModel];
            allGoodsCount++;
        }
        [storeArray addObject:goodsArray];
        [shopSelectAarry addObject:@(NO)];
    }
    self.cartData = storeArray;
    self.shopSelectArray = shopSelectAarry;
    self.cartGoodsCount = allGoodsCount;
}

- (float)getAllPrices{
    
    __block float allPrices   = 0;
    NSInteger shopCount       = self.cartData.count;
    NSInteger shopSelectCount = self.shopSelectArray.count;
    if (shopSelectCount == shopCount && shopCount!=0) {
        self.isSelectAll = YES;
    }
    
    /* 计算所有选中商品的金额 */
    NSArray* pricesArray = [[[self.cartData rac_sequence] map:^id(NSMutableArray* value) {
        
        return [[[value rac_sequence] filter:^BOOL(CDCartModel* model) {
            // 只要有一个数组中的模型不是选中状态，说明还不是全部选中，底部的全选按钮为常态
            if (!model.isSelect){
                self.isSelectAll = false;
            }
            return model.isSelect;
        }] map:^id(CDCartModel* model) {
            return @(model.p_price * model.p_quantity);
        }];
        
    }] array];
    
    
    for (NSArray* pricesArr in pricesArray){
        for (NSNumber* price in pricesArr){
            allPrices += price.floatValue;
        }
    }
    
    return allPrices;
}

- (void)selectAll:(BOOL)isSelect{
    
    __block float allPrices = 0;
    
    /* RAC */
    self.shopSelectArray = [[[[self.shopSelectArray rac_sequence] map:^id(NSNumber* value) {
        return @(isSelect);
    }] array] mutableCopy];
    
    // 重置数据源
    self.cartData = [[[[self.cartData rac_sequence] map:^id(NSMutableArray* value) {
        
        // 重置数据源并计算商品总金额
        return [[[[value rac_sequence] filter:^BOOL(CDCartModel* model) {
            model.isSelect = isSelect;
            if (model.isSelect){
                allPrices += model.p_quantity * model.p_price;
            }
            return model;
        }] array] mutableCopy];
        
    }] array] mutableCopy];
    self.allPrices = allPrices;
    [self.cartTableView reloadData];
}

- (void)rowSelect:(BOOL)isSelect IndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section          = indexPath.section;
    NSInteger row              = indexPath.row;
    
    NSMutableArray *goodsArray = self.cartData[section];
    NSInteger shopCount        = goodsArray.count;
    CDCartModel *model         = goodsArray[row];
    [model setValue:@(isSelect) forKey:@"isSelect"];
    //判断是都到达足够数量
    NSInteger isSelectShopCount = 0;
    for (CDCartModel *model in goodsArray) {
        if (model.isSelect) {
            isSelectShopCount++;
        }
    }
    [self.shopSelectArray replaceObjectAtIndex:section withObject:@(isSelectShopCount==shopCount?YES:NO)];
    
    [self.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    
    /*重新计算价格*/
    self.allPrices = [self getAllPrices];
}

#pragma mark - 改变某件商品的数量
- (void)rowChangeQuantity:(NSInteger)quantity indexPath:(NSIndexPath *)indexPath{
    
    NSInteger section  = indexPath.section;
    NSInteger row      = indexPath.row;
    
    CDCartModel *model = self.cartData[section][row];
    
    [model setValue:@(quantity) forKey:@"p_quantity"];
    
    [self.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    
    /*重新计算价格*/
    self.allPrices = [self getAllPrices];
}

//左滑删除商品
- (void)deleteGoodsBySingleSlide:(NSIndexPath *)path{
    
    NSInteger section = path.section;
    NSInteger row     = path.row;
    
    NSMutableArray *shopArray = self.cartData[section];
    [shopArray removeObjectAtIndex:row];
    if (shopArray.count == 0) {
        /*1 删除数据*/
        [self.cartData removeObjectAtIndex:section];
        /*2 删除 shopSelectArray*/
        [self.shopSelectArray removeObjectAtIndex:section];
        [self.cartTableView reloadData];
    } else {
        [self.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    }
    self.cartGoodsCount-=1;
    /*重新计算价格*/
    self.allPrices = [self getAllPrices];
}

//选中删除
- (void)deleteGoodsBySelect{
    /*1 删除数据*/
    NSInteger index1 = -1;
    NSMutableIndexSet *shopSelectIndex = [NSMutableIndexSet indexSet];
    for (NSMutableArray *shopArray in self.cartData) {
        index1++;
        
        NSInteger index2 = -1;
        NSMutableIndexSet *selectIndexSet = [NSMutableIndexSet indexSet];
        for (CDCartModel *model in shopArray) {
            index2++;
            if (model.isSelect) {
                [selectIndexSet addIndex:index2];
            }
        }
        NSInteger shopCount = shopArray.count;
        NSInteger selectCount = selectIndexSet.count;
        /* 如果当前组里面选中的商品数量等于组内商品总数 */
        if (selectCount == shopCount) {
            [shopSelectIndex addIndex:index1];
            self.cartGoodsCount -= selectCount;
        }
        /* 删除组内选中的商品 */
        [shopArray removeObjectsAtIndexes:selectIndexSet];
    }
    /* 删除被全部选中的组 */
    [self.cartData removeObjectsAtIndexes:shopSelectIndex];
    /*2 删除 shopSelectArray*/
    [self.shopSelectArray removeObjectsAtIndexes:shopSelectIndex];
    [self.cartTableView reloadData];
    /*3 carbar 恢复默认*/
    self.allPrices = 0;
    /*重新计算价格*/
    self.allPrices = [self getAllPrices];
}
@end
