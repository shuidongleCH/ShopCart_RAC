//
//  CDCartFooterView.h
//  CDBaseDemoOC
//
//  Created by 陈浩 on 17/1/22.
//  Copyright © 2017年 Ben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDCartFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) NSMutableArray *shopGoodsArray;

+ (CGFloat)getCartFooterHeight;

@end
