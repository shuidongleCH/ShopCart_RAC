//
//  CDCartUIService.h
//  CDBaseDemoOC
//
//  Created by 陈浩 on 17/1/22.
//  Copyright © 2017年 Ben. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CDCartViewModel;

@interface CDCartUIService : NSObject<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) CDCartViewModel *viewModel;
@end
