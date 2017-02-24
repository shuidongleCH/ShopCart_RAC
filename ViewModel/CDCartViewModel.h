//
//  CDCartViewModel.h
//  CDBaseDemoOC
//
//  Created by 陈浩 on 17/1/22.
//  Copyright © 2017年 Ben. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CDViewController;

@interface CDCartViewModel : NSObject

@property (nonatomic, weak  ) CDViewController *cartVC;
@property (nonatomic, strong) NSMutableArray       *cartData;
@property (nonatomic, weak  ) UITableView          *cartTableView;
/**
 *  存放店铺选中,相当于UITableView的每组section,存放bool值
 */
@property (nonatomic, strong) NSMutableArray       *shopSelectArray;
/**
 *  carbar 观察所有商品的价格变化
 */
@property (nonatomic, assign) float                 allPrices;
/**
 *  carbar 底部按钮全选的状态
 */
@property (nonatomic, assign) BOOL                  isSelectAll;
/**
 *  购物车商品数量
 */
@property (nonatomic, assign) NSInteger             cartGoodsCount;
/**
 *  当前所选商品数量
 */
@property (nonatomic, assign) NSInteger             currentSelectCartGoodsCount;

//获取数据
- (void)getData;

//全选
- (void)selectAll:(BOOL)isSelect;

//row select
- (void)rowSelect:(BOOL)isSelect
        IndexPath:(NSIndexPath *)indexPath;

//row 改变某件商品的数量
- (void)rowChangeQuantity:(NSInteger)quantity
                indexPath:(NSIndexPath *)indexPath;

//获取价格
- (float)getAllPrices;

//左滑删除商品
- (void)deleteGoodsBySingleSlide:(NSIndexPath *)path;

//选中删除
- (void)deleteGoodsBySelect;


@end
