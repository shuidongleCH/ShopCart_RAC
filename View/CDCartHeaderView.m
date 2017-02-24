//
//  CDCartHeaderView.m
//  CDBaseDemoOC
//
//  Created by 陈浩 on 17/1/22.
//  Copyright © 2017年 Ben. All rights reserved.
//

#import "CDCartHeaderView.h"

@interface CDCartHeaderView()

@property (nonatomic, strong) UIButton *storeNameButton;

@end

@implementation CDCartHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self setHeaderUI];
    }
    return self;
}

- (void)setHeaderUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.selectStoreGoodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectStoreGoodsButton.frame = CGRectZero;
    [self.selectStoreGoodsButton setImage:[UIImage imageNamed:@"buy_list_rb"]
                                 forState:UIControlStateNormal];
    [self.selectStoreGoodsButton setImage:[UIImage imageNamed:@"buy_list_rb_pre"]
                                 forState:UIControlStateSelected];
    self.selectStoreGoodsButton.backgroundColor=[UIColor clearColor];
    [self addSubview:self.selectStoreGoodsButton];
    
    self.storeNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.storeNameButton.frame = CGRectZero;
    [self.storeNameButton setTitle:@"店铺名字_____"
                          forState:UIControlStateNormal];
    [self.storeNameButton setTitleColor:[UIColor blackColor]
                               forState:UIControlStateNormal];
    self.storeNameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.storeNameButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.storeNameButton.titleLabel.font = [UIFont systemFontOfSize:(13)];
    [self addSubview:self.storeNameButton];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.selectStoreGoodsButton.frame = CGRectMake(0, 0, 36, 30);
    
    self.storeNameButton.frame = CGRectMake(40, 0, SCREEN_WIDTH-40, 30);
    
}

+ (CGFloat)getCartHeaderHeight{   
    return 30;
}

@end
