//
//  ViewController.m
//  UICollectionViewSectionColor
//
//  Created by 橙子 on 16/8/25.
//  Copyright © 2016年 jiayu. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    YLCollectionViewFlowLayoutSectionColor *flowLayout= [[YLCollectionViewFlowLayoutSectionColor alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
    [self.collectionView reloadData];
    
}



#pragma mark - UICollectionViewDelegate FlowLayout

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.view.frame.size.width - 60)/2, 150);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 20, 20, 20);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ViewController *view = [[ViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}

- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(YLCollectionViewFlowLayoutSectionColor *)layout sectionColor:(NSInteger)section {
    if (section%2 == 0) {
        return [UIColor orangeColor];
    }else {
        return [UIColor blueColor];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView layout:(YLCollectionViewFlowLayoutSectionColor *)layout needSectionColorInSection:(NSInteger)section {
    if (section == 2) {
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%@ has been dealloced",self);
}

@end
