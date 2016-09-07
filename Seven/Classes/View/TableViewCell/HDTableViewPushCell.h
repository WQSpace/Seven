//
//  HDTableViewPushCell.h
//  PortableTreasure
//
//  Created by HeDong on 15/3/17.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import "HDTableViewBaseCell.h"

@class HDTableViewPushModel;

@interface HDTableViewPushCell : HDTableViewBaseCell

/** TableView推送模型 */
@property (nonatomic, strong) HDTableViewPushModel *tableViewPushModel;


/**
 *  快速创建重用HDTableViewPushCell对象
 */
+ (__kindof HDTableViewPushCell *)tableViewPushCellWithTableView:(UITableView *)tableView;

@end
