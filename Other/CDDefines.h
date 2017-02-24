//
//  CDDefines.h
//  CDBaseDemoOC
//
//  Created by 陈浩 on 16/7/26.
//  Copyright © 2016年 CD. All rights reserved.
//

#ifndef CDDefines_h
#define CDDefines_h

#ifdef DEBUG

#define CDLog(...) NSLog(__VA_ARGS__)
#else

#define CDLog(...)
#endif

#import "UIColor+HexColor.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#define WEAK  @weakify(self);
#define STRONG  @strongify(self);

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

#define kGlobalColor               [UIColor colorWithHex:@"9DC216"]//
#define kGlobalPageColor           [UIColor colorWithHex:@"F6F6F8"]
#define kHalfAlphaColor            [UIColor colorWithHex:@"D3E497"]//

#define kClearColor                [UIColor clearColor]
#define kWhiteColor                [UIColor whiteColor]
#define kBaseTextColor             [UIColor colorWithHex:@"#282828"]
#pragma mark - 文字颜色
#define kTextColor_47              [UIColor colorWithHex:@"474747"]//
#define kTextColor_FF              [UIColor colorWithHex:@"FF8019"]//
#define kTextColor_92              [UIColor colorWithHex:@"929292"]//
#define kTextColor_BA              [UIColor colorWithHex:@"BABABA"]//
#define kTextColor_90              [UIColor colorWithHex:@"909090"]//
#define kTextColor_C6              [UIColor colorWithHex:@"C6C6C6"]
#define kTextColor_E5              [UIColor colorWithHex:@"E5E5E5"]//

#endif /* CDDefines_h */
