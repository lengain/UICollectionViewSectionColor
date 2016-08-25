//
//  YLCollectionViewFlowLayout.m
//  UICollectionViewSectionColor
//
//  Created by 橙子 on 16/8/25.
//  Copyright © 2016年 . All rights reserved.
//

#import "YLCollectionViewFlowLayoutSectionColor.h"

static NSString * kDecorationReuseIdentifier = @"DecorationReuseIdentifier";

@implementation YLCollectionViewLayoutAttributes

+ (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind withIndexPath:(NSIndexPath *)indexPath {
    YLCollectionViewLayoutAttributes *layoutAttributes = [super layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
    return layoutAttributes;
}

- (id)copyWithZone:(NSZone *)zone {
    YLCollectionViewLayoutAttributes *newAttributes = [super copyWithZone:zone];
    newAttributes.color = [self.color copyWithZone:zone];
    return newAttributes;
}

@end


@implementation YLCollectionReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    YLCollectionViewLayoutAttributes *ylLayoutAttributes = (YLCollectionViewLayoutAttributes*)layoutAttributes;
    self.backgroundColor = ylLayoutAttributes.color;
}

@end


@implementation YLCollectionViewFlowLayoutSectionColor

+ (Class)layoutAttributesClass
{
    return [YLCollectionViewLayoutAttributes class];
}

- (void)prepareLayout {
    [super prepareLayout];
    [self registerClass:[YLCollectionReusableView class] forDecorationViewOfKind:kDecorationReuseIdentifier];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *allAttributes = [NSMutableArray arrayWithArray:attributes];
    
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        
        // Look for the first item in a row
        
        BOOL needSectionColor = NO;
        if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:needSectionColorInSection:)]) {
            needSectionColor = [((id <YLCollectionViewFlowLayoutSectionColorDelegate>) self.collectionView.delegate) collectionView:self.collectionView layout:self needSectionColorInSection:attribute.indexPath.section];
        }
        if (needSectionColor) {
            if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
                self.sectionInset = [((id <UICollectionViewDelegateFlowLayout>) self.collectionView.delegate)
                                     collectionView:self.collectionView layout:self insetForSectionAtIndex:attribute.indexPath.section];
            }
            if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
                self.minimumLineSpacing = [((id <UICollectionViewDelegateFlowLayout>) self.collectionView.delegate) collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:attribute.indexPath.section];
            }
            if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
                self.itemSize = [((id <UICollectionViewDelegateFlowLayout>) self.collectionView.delegate) collectionView:self.collectionView layout:self sizeForItemAtIndexPath:attribute.indexPath];
            }
            if (attribute.representedElementKind == UICollectionElementCategoryCell
                && roundl(attribute.frame.origin.x) == roundl(self.sectionInset.left)) {
                // Create decoration attributes
                YLCollectionViewLayoutAttributes *decorationAttributes =
                [YLCollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:kDecorationReuseIdentifier
                                                                            withIndexPath:attribute.indexPath];
                decorationAttributes.frame =
                CGRectMake(0,
                           attribute.frame.origin.y-(self.sectionInset.top),
                           self.collectionViewContentSize.width,
                           self.itemSize.height+(self.minimumLineSpacing+self.sectionInset.top+ self.sectionInset.bottom));
                
                // Set the zIndex to be behind the item
                decorationAttributes.zIndex = attribute.zIndex-1;
                decorationAttributes.color = [((id <YLCollectionViewFlowLayoutSectionColorDelegate>) self.collectionView.delegate) collectionView:self.collectionView layout:self sectionColor:attribute.indexPath.section];
                // Add the attribute to the list
                [allAttributes addObject:decorationAttributes];
                
            }
        }
    }
    return allAttributes;
}


@end
