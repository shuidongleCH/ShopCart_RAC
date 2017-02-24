//
//  CDCartFooterView.m
//  CDBaseDemoOC
//
//  Created by 陈浩 on 17/1/22.
//  Copyright © 2017年 Ben. All rights reserved.
//

#import "CDCartFooterView.h"
#import "CDCartModel.h"

@interface CDCartFooterView ()

@property (nonatomic, retain) UILabel *priceLabel;

@end

@implementation CDCartFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self initCartFooterView];
    }
    return self;
}

- (void)initCartFooterView{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.text = @"小记:￥15.80";
    _priceLabel.textColor = [UIColor redColor];
    
    [self addSubview:_priceLabel];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    _priceLabel.frame = CGRectMake(10, 0.5, SCREEN_WIDTH-20, 30);
    
}

- (void)setShopGoodsArray:(NSMutableArray *)shopGoodsArray{
    
    _shopGoodsArray = shopGoodsArray;
    /*  计算尾部视图的价格标签  */
    NSArray* pricesArr = [[[[_shopGoodsArray rac_sequence]
                            filter:^BOOL(CDCartModel* model) {
                                return model.isSelect;
                            }]
                           map:^id(CDCartModel* model) {
                               return @(model.p_price * model.p_quantity);
                           }] array];
    
    float shopPrice = 0;
    for (NSNumber* prices in pricesArr){
        shopPrice += prices.floatValue;
    }
    _priceLabel.text = [NSString stringWithFormat:@"小记:￥%.2f",shopPrice];
}


+ (CGFloat)getCartFooterHeight{
    
    return 30;
}


@end
