//
//  ViewController.h
//  UICollectionViewSectionColor
//
//  Created by 橙子 on 16/8/25.
//  Copyright © 2016年 jiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLCollectionViewFlowLayoutSectionColor.h"

@interface ViewController : UIViewController <UICollectionViewDataSource,YLCollectionViewFlowLayoutSectionColorDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

