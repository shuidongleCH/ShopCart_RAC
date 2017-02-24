//
//  CDShoppingTableViewCell.h
//  CDBaseDemoOC
//
//  Created by 陈浩 on 16/7/31.
//  Copyright © 2016年 CD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDCartModel,CDNumberCountView;

@interface CDShoppingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectShopGoodsButton;
@property (weak, nonatomic) IBOutlet  CDNumberCountView*nummberCount;
@property (nonatomic, strong) CDCartModel *model;
+ (CGFloat)getCartCellHeight;
@end
