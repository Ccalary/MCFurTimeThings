//
//  TNEmptyViewView.m
//  TimeNote
//
//  Created by caohouhong on 2018/8/8.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "TNEmptyViewView.h"
@interface TNEmptyViewView ()<UITableViewDelegate ,UITableViewDataSource>
@end
@implementation TNEmptyViewView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        [self lei_drawView];
    }
    return self;
}

- (void)lei_drawView {
   UITableView *_tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"Cell";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    return cell;
}


@end
