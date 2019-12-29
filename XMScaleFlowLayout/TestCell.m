//
//  TestCell.m
//  XMScaleFlowLayout
//
//  Created by 梁小迷 on 2019/12/29.
//  Copyright © 2019 mifit. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:12];
        label.text = @"";
        label.textColor = [UIColor blueColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:label];
        UIImageView *imgView = [UIImageView new];
        [self.contentView addSubview:imgView];
        self.vgImage = imgView;
        self.centerLabel = label;
    }
    return self;
}

- (void)layoutSubviews {
    CGSize size = self.bounds.size;
    self.centerLabel.frame = CGRectMake(0, (size.height-20)/2, size.width, 20);
    self.vgImage.frame = self.contentView.bounds;
}
@end
