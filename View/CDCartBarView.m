//
//  CDCartBarView.m
//  CDBaseDemoOC
//
//  Created by 陈浩 on 17/1/22.
//  Copyright © 2017年 Ben. All rights reserved.
//


static NSInteger const BalanceButtonTag = 120;

static NSInteger const DeleteButtonTag = 121;

static NSInteger const SelectButtonTag = 122;

#import "CDCartBarView.h"

@interface UIImage (CD)

+ (UIImage *)imageWithColor:(UIColor *)color ;

@end

@implementation UIImage (CD)

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end

@interface CDCartBarView ()

@end

@implementation CDCartBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBarUI];
    }
    return self;
}

- (void)setBarUI{
    
    self.backgroundColor = [UIColor clearColor];
    /* 背景 */
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    effectView.userInteractionEnabled = NO;
    effectView.frame = self.bounds;
    [self addSubview:effectView];
    
    CGFloat wd = SCREEN_WIDTH*2/7;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor  = kTextColor_E5;
    [self addSubview:lineView];
    /* 结算 */
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
    [button setTitle:@"结算" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(SCREEN_WIDTH-wd, 0, wd, self.frame.size.height)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    button.enabled = NO;
    button.tag = BalanceButtonTag;
    [self addSubview:button];
    _balanceButton = button;
    /* 删除 */
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
    [button1 setTitle:@"删除" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [button1 setFrame:CGRectMake(SCREEN_WIDTH-wd, 0, wd, self.frame.size.height)];
    button1.enabled = NO;
    button1.hidden = YES;
    button1.tag = DeleteButtonTag;
    [self addSubview:button1];
    _deleteButton = button1;
    /* 全选 */
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"全选"
             forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor blackColor]
                  forState:UIControlStateNormal];
    [button3 setImage:[UIImage imageNamed:@"buy_list_rb"]
             forState:UIControlStateNormal];
    [button3 setImage:[UIImage imageNamed:@"buy_list_rb_pre"]
             forState:UIControlStateSelected];
    [button3 setFrame:CGRectMake(0, 0, 78, self.frame.size.height)];
    [button3 setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    button3.tag = SelectButtonTag;
    [self addSubview:button3];
    _selectAllButton = button3;
    /* 价格 */
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(wd, 0, SCREEN_WIDTH-wd*2-5, self.frame.size.height)];
    label1.text = [NSString stringWithFormat:@"总计￥:%@",@(00.00)];
    label1.textColor = [UIColor blackColor];
    label1.font = [UIFont systemFontOfSize:(15)];
    label1.textAlignment = NSTextAlignmentRight;
    [self addSubview:label1];
    _allMoneyLabel = label1;
    
    /* assign value */
    WEAK
    [RACObserve(self, money) subscribeNext:^(NSNumber* x) {
        STRONG
        CDLog(@"总计￥:%.2f",x.floatValue);
        self.allMoneyLabel.text = [NSString stringWithFormat:@"总计￥:%.2f",x.floatValue];
    }];
    
    /* RAC */
    /* 如果当前金额为0，则取消全选按钮的选中在状态，将结算和删除按钮重置为静默状态 */
    RACSignal* comBineSignal = [RACSignal combineLatest:@[RACObserve(self, money)] reduce:^id(NSNumber* money){
        if (money.floatValue == 0){
            self.selectAllButton.selected = false;
        }
        return @(money.floatValue > 0);
    }];
    /* 如果当前金额为0，则取消全选按钮的选中在状态，将结算和删除按钮重置为静默状态 */
    RAC(self.balanceButton,enabled) = comBineSignal;
    RAC(self.deleteButton,enabled) = comBineSignal;
    
    /* 当前的编辑模式 */
    [RACObserve(self, isNormalState) subscribeNext:^(NSNumber *x) {
        STRONG
        BOOL isNormal =  x.boolValue;
        self.balanceButton.hidden = !isNormal;
        self.allMoneyLabel.hidden = !isNormal;
        self.deleteButton.hidden = isNormal;
    }];
}

@end
