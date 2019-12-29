//
//  XMScaleFlowLayout.h
//  XMScaleFlowLayout
//
//  Created by 梁小迷 on 2019/12/29.
//  Copyright © 2019 mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMScaleFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) CGFloat beginScaleVal;    // 开始放大的位置（以item左边算起）beginScaleVal + itemWidht > endScaleVal
@property (nonatomic, assign) CGFloat endScaleVal;      // 开始恢复（缩小）的位置（以item左边算起）
@property (nonatomic, assign) CGFloat leftMargin;       // 最左边item距离View间距
@property (nonatomic, assign) CGFloat maxScale;         // 放大系数，大于1

@end

NS_ASSUME_NONNULL_END
