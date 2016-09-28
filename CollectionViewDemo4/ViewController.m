//
//  ViewController.m
//  CollectionViewDemo4
//
//  Created by user on 16/3/10.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ViewController.h"

#import "THSpringyFlowLayout.h"

#import "ZZCollectionViewLayout.h"

#import "ASHSpringyCollectionViewFlowLayout.h"

@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewLayout *flowLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELLIDENTIFIER"];
    
    
    //self.flowLayout = [[THSpringyFlowLayout alloc] init];
    self.flowLayout = [[ZZCollectionViewLayout alloc] init];
    //self.flowLayout = [[ASHSpringyCollectionViewFlowLayout alloc] init];
    
    [self.collectionView setCollectionViewLayout:self.flowLayout];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 重新布局
    [self.flowLayout invalidateLayout];

}

#pragma mark - UICollectionViewDataSource & Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELLIDENTIFIER" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
