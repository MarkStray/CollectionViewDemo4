//
//  ZZCollectionViewLayout.m
//  CollectionViewDemo4
//
//  Created by user on 16/3/14.
//  Copyright © 2016年 user. All rights reserved.
//


/* 自定义 动态layout */

#import "ZZCollectionViewLayout.h"

@implementation ZZCollectionViewLayout {
    UIDynamicAnimator *_animator;
    NSMutableSet *_visibleIndexPaths;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    CGSize contentSize = self.collectionView.contentSize;
    NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0.0f, 0.0f, contentSize.width, contentSize.height)];
    if (_animator.behaviors.count == 0) {
        [items enumerateObjectsUsingBlock:^(id<UIDynamicItem> obj, NSUInteger idx, BOOL *stop) {
            UIAttachmentBehavior *behaviour = [[UIAttachmentBehavior alloc] initWithItem:obj
                                                                        attachedToAnchor:[obj center]];
            
            behaviour.length = 0.0f;
            behaviour.damping = 0.8f;
            behaviour.frequency = 1.0f;
            
            [_animator addBehavior:behaviour];
        }];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [_animator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_animator layoutAttributesForCellAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    UIScrollView *scrollView = self.collectionView;
    
    CGFloat delta = newBounds.origin.y - scrollView.bounds.origin.y;
    
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    [_animator.behaviors enumerateObjectsUsingBlock:^(UIAttachmentBehavior *springBehaviour, NSUInteger idx, BOOL *stop) {
        CGFloat yDistanceFromTouch = fabs(touchLocation.y - springBehaviour.anchorPoint.y);
        
        CGFloat scrollResistance = yDistanceFromTouch / 1500.0f;
        
        UICollectionViewLayoutAttributes *item = (UICollectionViewLayoutAttributes *)springBehaviour.items.firstObject;
        CGPoint center = item.center;
        
        NSLog(@"delta -> %f, coff -> %f, yDIS -> %f",delta, delta * scrollResistance,yDistanceFromTouch);

        
        if (delta < 0) {
            center.y += MAX(delta, delta*scrollResistance);
        }
        else {
            center.y += MIN(delta, delta*scrollResistance);
        }
        item.center = center;
        
        [_animator updateItemUsingCurrentState:item];
    }];
    
    return NO;
}




@end
