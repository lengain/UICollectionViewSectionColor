//
//  YLCollectionViewFlowLayout.h
//  UICollectionViewSectionColor
//
//  Created by 橙子 on 16/8/25.
//  Copyright © 2016年 jiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLCollectionViewFlowLayoutSectionColor;
@protocol YLCollectionViewFlowLayoutSectionColorDelegate <UICollectionViewDelegateFlowLayout>

- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(YLCollectionViewFlowLayoutSectionColor *)layout sectionColor:(NSInteger)section;

- (BOOL)collectionView:(UICollectionView *)collectionView layout:(YLCollectionViewFlowLayoutSectionColor *)layout needSectionColorInSection:(NSInteger)section;

@end


@interface YLCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes

@property (nonatomic, strong) UIColor *color;

@end

@interface YLCollectionReusableView : UICollectionReusableView

@end


@interface YLCollectionViewFlowLayoutSectionColor : UICollectionViewFlowLayout

@end
