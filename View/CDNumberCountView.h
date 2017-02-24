//
//  CDNumberCountView.h
//  CDBaseDemoOC
//
//  Created by 陈浩 on 17/1/22.
//  Copyright © 2017年 Ben. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JSNumberChangeBlock)(NSInteger count);

@interface CDNumberCountView : UIView
/**
 *  总数
 */
@property (nonatomic, assign) NSInteger           totalNum;
/**
 *  当前显示价格
 */
@property (nonatomic, assign) NSInteger           currentCountNumber;
/**
 *  数量改变回调
 */
@property (nonatomic, copy  ) JSNumberChangeBlock NumberChangeBlock;

@end
