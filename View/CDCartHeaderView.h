//
//  CDCartHeaderView.h
//  CDBaseDemoOC
//
//  Created by 陈浩 on 17/1/22.
//  Copyright © 2017年 Ben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDCartHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIButton *selectStoreGoodsButton;

+ (CGFloat)getCartHeaderHeight;


@end
