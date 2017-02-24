//
//  CDCartBarView.h
//  CDBaseDemoOC
//
//  Created by 陈浩 on 17/1/22.
//  Copyright © 2017年 Ben. All rights reserved.
//

/**
 *  底部视图
 */
#import <UIKit/UIKit.h>

@interface CDCartBarView : UIView

//结算
@property (nonatomic, strong) UIButton *balanceButton;
//全选
@property (nonatomic, strong) UIButton *selectAllButton;
//价格
@property (nonatomic, retain) UILabel *allMoneyLabel;
//删除
@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, assign) BOOL     isNormalState;// 当前的编辑模式

@property (nonatomic, assign) float    money;

@end
