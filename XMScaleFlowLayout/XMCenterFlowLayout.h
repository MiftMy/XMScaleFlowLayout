//
//  XMCenterFlowLayout.h
//  XMScaleFlowLayout
//
//  Created by 梁小迷 on 2019/12/29.
//  Copyright © 2019 mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMCenterFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) CGFloat maxScale;         // 放大系数，大于1
@property (nonatomic, assign) CGFloat leftPoint;         // 放大系数，大于1
@property (nonatomic, assign) CGFloat rightPoint;         // 放大系数，大于1
@end

NS_ASSUME_NONNULL_END
