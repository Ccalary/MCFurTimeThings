//
//  TTNothingView.m
//  TimeThings
//
//  Created by caohouhong on 2018/7/23.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "LeiNothingView.h"

typedef void(^addBlock)(void);

@interface LeiNothingView()
@property (nonatomic, strong) UILabel *nothingLabel;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, copy) addBlock block;
@end

@implementation LeiNothingView
- (instancetype)initWithFrame:(CGRect)frame addAction:(void(^)(void))block{
    if (self = [super initWithFrame:frame]){
        [self lei_initView];
        if (block){
            self.block = block;
        }
    }
    return self;
}

- (void)lei_initView {
    
    _nothingLabel = [[UILabel alloc] init];
    _nothingLabel.text = @"Nothing Here, Add One Now?";
    _nothingLabel.textAlignment = NSTextAlignmentCenter;
    _nothingLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_nothingLabel];
    [_nothingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.centerY.mas_equalTo(self.mas_centerY).offset(-10);
    }];
    
    _addButton = [[UIButton alloc] init];
    _addButton.backgroundColor = [UIColor tt_themeColor];
    _addButton.layer.cornerRadius = 20;
    [_addButton setTitle:@"Add" forState:UIControlStateNormal];
    [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(Lei_addSomeThingAction) forControlEvents:UIControlEventTouchUpInside];
    _addButton.layer.masksToBounds = YES;
    [self addSubview:_addButton];
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.nothingLabel.mas_bottom).offset(15);
    }];
}

- (void)Lei_addSomeThingAction {
    if (self.block){
        self.block();
    }
}
@end
