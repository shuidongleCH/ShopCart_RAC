//
//  CDCartModel.h
//  CDBaseDemoOC
//
//  Created by 陈浩 on 17/1/22.
//  Copyright © 2017年 Ben. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDCartModel : NSObject

@property (nonatomic, strong) NSString  *p_id;

@property (nonatomic, assign) float     p_price;

@property (nonatomic, assign) NSInteger p_stock;

@property (nonatomic, assign) NSInteger p_quantity;// 默认商品已购数量

@property (nonatomic, assign) BOOL      isSelect;// 商品是否被选中

@end
