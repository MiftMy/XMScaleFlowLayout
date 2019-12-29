//
//  XMCenterFlowLayout.m
//  XMScaleFlowLayout
//
//  Created by 梁小迷 on 2019/12/29.
//  Copyright © 2019 mifit. All rights reserved.
//

#import "XMCenterFlowLayout.h"

@interface XMCenterFlowLayout ()
@property (nonatomic, assign) CGFloat centerPosition;
@end

@implementation XMCenterFlowLayout
- (instancetype)init{
    if (self = [super init]) {
        self.scrollDirection  = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 10;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *layoutList = [super layoutAttributesForElementsInRect:rect];
    self.centerPosition = (self.leftPoint + self.rightPoint) / 2;
    CGFloat offsetX = self.collectionView.contentOffset.x;
    CGSize size = self.itemSize;
    CGFloat itemSpace = self.minimumInteritemSpacing;
    CGFloat leftVal = offsetX + self.leftPoint;
    CGFloat rightVal = offsetX + self.rightPoint;
    for (UICollectionViewLayoutAttributes *layout in layoutList) {
        CGFloat curItemLeft = layout.indexPath.row * (itemSpace + size.width);
        CGFloat curItemCenter = curItemLeft + size.width / 2;
        if (leftVal < curItemCenter && curItemCenter < rightVal) {
            CGFloat screenCenter = offsetX + self.centerPosition;
            CGFloat offsetScale = self.maxScale - 1;
            CGFloat curOffScale = (1-fabs(screenCenter - curItemCenter) / (self.centerPosition - self.leftPoint)) * offsetScale + 1;
            layout.transform3D = CATransform3DMakeScale(curOffScale, curOffScale, 1);
            layout.zIndex = 0;
        } else {
            layout.zIndex = -1;
        }
    }
    return layoutList;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end
