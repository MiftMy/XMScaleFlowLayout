//
//  ViewController.m
//  XMScaleFlowLayout
//
//  Created by 梁小迷 on 2019/12/29.
//  Copyright © 2019 mifit. All rights reserved.
//

#import "ViewController.h"
#import "XMScaleFlowLayout.h"
#import "XMCenterFlowLayout.h"
#import "TestCell.h"

@interface ViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic, strong) UICollectionView *colView;

@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemSpace;
@property (nonatomic, assign) CGFloat leftSpace;


@property (nonatomic, assign) CGFloat leftPoint;
@property (nonatomic, assign) CGFloat rightPoint;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    self.itemWidth = 100;
    self.leftSpace = 10;
    self.itemSpace = 10;
    
    self.leftPoint = size.width / 3;
    self.rightPoint = size.width / 3 * 2;
    
    
    XMScaleFlowLayout *flowlayout = [[XMScaleFlowLayout alloc]init];
//    XMCenterFlowLayout *flowlayout = [[XMCenterFlowLayout alloc]init];
    flowlayout.itemSize = CGSizeMake(100, 100);
    flowlayout.maxScale = 1.4;
    flowlayout.minimumLineSpacing = self.itemSpace;
    
    /// XMScaleFlowLayout
    flowlayout.beginScaleVal = 40;
    flowlayout.endScaleVal = 30;
    flowlayout.leftMargin = self.leftSpace;
    
    /// XMCenterFlowLayout
//    flowlayout.leftPoint = self.leftPoint;
//    flowlayout.rightPoint = self.rightPoint;
    
    self.colView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, size.width, 150) collectionViewLayout:flowlayout];
    [self.view addSubview:self.colView];
    [self.colView registerClass:[TestCell class] forCellWithReuseIdentifier:@"TestCell"];
    self.colView.backgroundColor = [UIColor yellowColor];
    self.colView.delegate = self;
    self.colView.dataSource = self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 270;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TestCell" forIndexPath:indexPath];
    cell.centerLabel.text = [NSString stringWithFormat:@"index: %zd", indexPath.row];
    NSString *imgName = [NSString stringWithFormat:@"%zd.jpg", indexPath.row%7 + 1];
    cell.vgImage.image = [UIImage imageNamed:imgName];
    return cell;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat targetOffsetX = (*targetContentOffset).x;
    CGFloat width = self.itemWidth;
    CGFloat space = self.itemSpace;
    CGFloat leftSpace = self.leftSpace;
    NSInteger totalWidth = width + space;
    
    /// XMScaleFlowLayout
    CGFloat halfTotalWidth = totalWidth / 2;
    CGFloat page = (int)(targetOffsetX / totalWidth);
    CGFloat lestPersent = (int)targetOffsetX % totalWidth;
    CGFloat desOffsetX = targetOffsetX;
    if (lestPersent < halfTotalWidth - 15) { // 最左边item大部分见，调整参数
        desOffsetX = (page - 1) * (totalWidth) + halfTotalWidth + 15 + leftSpace;
    } else { // 最左边item大部分不见
        desOffsetX = (page) * (totalWidth) + halfTotalWidth + 15 + leftSpace;
    }
    
    /// XMCenterFlowLayout
//    CGFloat centerPoint = (self.leftPoint + self.rightPoint) / 2;
//    CGFloat page = (centerPoint + targetOffsetX) / totalWidth;
//    NSInteger minPage = page;
//    NSInteger maxPage = ceil(page);
//    CGFloat desOffsetX = (maxPage + minPage) / 2.0 * (totalWidth) - centerPoint - leftSpace;
    
    *targetContentOffset = CGPointMake(desOffsetX, 0);
    NSLog(@"targetContentOffset %.2f  %.2f", targetOffsetX, desOffsetX);
}
@end
