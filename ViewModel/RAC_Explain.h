//
//  RAC_Explain.h
//  CDBaseDemoOC
//
//  Created by 陈浩 on 17/2/24.
//  Copyright © 2017年 Ben. All rights reserved.
//

/**
 *  - takeUntil:(RACSignal *) : 当给定的signal完成前一直取值
 *  rac_prepareForReuseSignal : Cell复用时的清理
    说到UITableView，再说一下UITableViewCell，RAC给UITableViewCell提供了一个方法：rac_prepareForReuseSignal，它的作用是当Cell即将要被重用时，告诉Cell。想象Cell上有多个button，Cell在初始化时给每个button都addTarget:action:forControlEvents，被重用时需要先移除这些target
 */




















