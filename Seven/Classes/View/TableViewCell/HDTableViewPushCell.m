//
//  HDTableViewPushCell.m
//  PortableTreasure
//
//  Created by HeDong on 15/3/17.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import "HDTableViewPushCell.h"
#import "HDTableViewPushModel.h"

@implementation HDTableViewPushCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return self;
}

+ (__kindof HDTableViewPushCell *)tableViewPushCellWithTableView:(UITableView *)tableView {
    return [super tableViewBaseCellWithTableView:tableView];
}

- (void)setTableViewPushModel:(HDTableViewPushModel *)tableViewPushModel {
    [super setTableViewBaseModel:tableViewPushModel];
    
    _tableViewPushModel = tableViewPushModel;
    [self setUpPushData];
}

/**
 *  设置推送数据
 */
- (void)setUpPushData {
    
}

@end
