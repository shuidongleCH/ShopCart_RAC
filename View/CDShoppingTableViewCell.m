//
//  CDShoppingTableViewCell.m
//  CDBaseDemoOC
//
//  Created by 陈浩 on 16/7/31.
//  Copyright © 2016年 CD. All rights reserved.
//

#import "CDShoppingTableViewCell.h"
#import "CDNumberCountView.h"
#import "CDCartModel.h"

@interface CDShoppingTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *GoodsPricesLabel;
@end

@implementation CDShoppingTableViewCell

- (void)setModel:(CDCartModel *)model{
    self.nummberCount.totalNum           = model.p_stock;
    self.nummberCount.currentCountNumber = model.p_quantity;
    self.selectShopGoodsButton.selected  = model.isSelect;
    self.GoodsPricesLabel.text           = [NSString stringWithFormat:@"￥%.2f",model.p_price];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+ (CGFloat)getCartCellHeight{
    return 103;
}

@end
