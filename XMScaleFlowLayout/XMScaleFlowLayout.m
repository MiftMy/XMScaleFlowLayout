//
//  XMScaleFlowLayout.m
//  XMScaleFlowLayout
//
//  Created by 梁小迷 on 2019/12/29.
//  Copyright © 2019 mifit. All rights reserved.
//

#import "XMScaleFlowLayout.h"

@implementation XMScaleFlowLayout
- (instancetype)init{
    if (self = [super init]) {
        self.scrollDirection  = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 10;
    }
    return self;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *arr = [self copyAttributes: [super layoutAttributesForElementsInRect:rect]];
    CGSize size = self.itemSize;
    CGFloat halfWidth = size.width / 2;
    CGFloat offsetX = self.collectionView.contentOffset.x;
    CGFloat leftSpace = self.leftMargin;
    CGFloat leftScaleWidth = self.beginScaleVal;
    CGFloat endSacleWidth = self.endScaleVal;
    CGFloat offsetScale = self.maxScale - 1;
    CGFloat itemSpace = self.minimumLineSpacing;
    NSInteger idx = 0;
    //刷新cell缩放
    for (UICollectionViewLayoutAttributes *attribute in arr) {
        CGFloat minXVal  = CGRectGetMinX(attribute.frame); // item的minX
        CGFloat distance = minXVal - offsetX; // 距离View左边的距离
        if ( distance >= size.width + leftScaleWidth) { // 一个item宽度+开始放大宽度 正常显示
            // 往右移动一个间距，避免与放大那个挨一起
            attribute.transform3D = CATransform3DMakeScale(1, 1, 1.0);
            attribute.center = CGPointMake(attribute.center.x + itemSpace + leftSpace, attribute.center.y);
            
        } else if(distance >= endSacleWidth && distance < size.width + leftScaleWidth) { //大于放大宽度，不超出一个item宽度
            //                          当前可变动长度                可变动总长度
            CGFloat scale = (1 - ((distance-endSacleWidth) / (size.width + leftScaleWidth - endSacleWidth))) * offsetScale + 1;
            attribute.transform3D = CATransform3DMakeScale(scale, scale, 1.0);
            
            // 平滑过渡间距
            CGFloat offX = (distance - endSacleWidth) / (size.width + leftScaleWidth - endSacleWidth) * itemSpace;
            CGFloat desVal = attribute.center.x + offX; // 中心位置
            CGFloat leftVal = desVal - offsetX; // 中心距离左边距离
            CGFloat scaleWith = scale * size.width; // 当前item缩放后宽度
            if (leftVal < scaleWith/2) { // 中心距离不能小于半个item的宽度，确保不超出屏幕外
                desVal = offsetX + scaleWith/2;
            }
            attribute.center = CGPointMake(desVal + leftSpace, attribute.center.y);
            
        } else if (endSacleWidth > distance && distance > -(size.width)) { // 小于放大宽度，大于放大跨度+item宽
            // 缩小过度
            CGFloat scale =  self.maxScale - ( (endSacleWidth - distance) / (size.width )) * offsetScale;
            attribute.alpha = scale - offsetScale;
            attribute.transform3D = CATransform3DMakeScale(scale, scale, 1.0);
            
            // 确保距离左边位置
            CGFloat xVal = attribute.center.x;
            // 缩放导致的补偿宽度（与未缩放有差）
            CGFloat scaleWidth = scale * size.width;
            CGFloat minVal = offsetX + scaleWidth / 2;
            if (xVal < minVal) { // 保证在view内
                xVal = minVal;
            }
            attribute.center = CGPointMake(xVal + leftSpace, attribute.center.y);
            
            // z轴，右边始终在左边前面
            attribute.zIndex = - (10000 - idx);
        } else {
            attribute.size = CGSizeZero;
        }
        idx ++;
    }
    return arr;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
-(NSArray *)copyAttributes:(NSArray  *)arr{
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in arr) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}
@end
