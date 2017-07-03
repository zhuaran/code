//
//  MyLayout.m
//  UICollectionView瀑布流
//
//  Created by huangdl on 14-9-24.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "MyLayout.h"
#import "MyModel.h"

@implementation MyLayout

//返回整个collectionView的大小
-(CGSize)collectionViewContentSize
{
    float heightLeft = 0.0;
    float heightRight = 0.0;
    for (int i = 0; i<_images.count; i++) {
        MyModel *model = _images[i];
        float height = model.cellHeight;
        if (heightRight > heightLeft) {
            heightLeft += height;
        }
        else
        {
            heightRight += height;
        }
    }
    return CGSizeMake(320, heightLeft>heightRight?heightLeft:heightRight);
   
}

//返回对应indexPath的cell的属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    float heightLeft = 0.0;
    float heightRight = 0.0;
    for (int i = 0; i<indexPath.row; i++) {
        MyModel *model = _images[i];
        float height = model.cellHeight;
        if (heightRight > heightLeft) {
            heightLeft += height;
            attr.center = CGPointMake(80, heightLeft - height/2);
        }
        else
        {
            heightRight += height;
            attr.center = CGPointMake(240, heightRight - height/2);
        }
        attr.size = CGSizeMake(160, height);
    }
    
    return attr;
}

//返回所有的cell的属性的数组
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i=0; i<[self.collectionView numberOfItemsInSection:0]; i++) {
        [arr addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
    return arr;
}


@end









