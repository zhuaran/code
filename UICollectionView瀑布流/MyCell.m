//
//  MyCell.m
//  UICollectionView瀑布流
//
//  Created by huangdl on 14-9-24.
//  Copyright (c) 2014年 1000phone. All rights reserved.
//

#import "MyCell.h"
#import "UIImageView+WebCache.h"
@implementation MyCell
{
    UIImageView *_imgv;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self uiConfig];
    }
    return self;
}
-(void)uiConfig
{
    _imgv = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, self.contentView.frame.size.width - 10, self.contentView.frame.size.height - 10)];
    [self.contentView addSubview:_imgv];
}

-(void)setModel:(MyModel *)model
{
    _imgv.frame = CGRectMake(5, 5, self.contentView.frame.size.width - 10, self.contentView.frame.size.height - 10);
    [_imgv setImageWithURL:[NSURL URLWithString:model.imgUrl]];
    _imgv.backgroundColor = [UIColor colorWithRed:0.1*(arc4random()%10) green:0.1*(arc4random()%10) blue:0.1*(arc4random()%10) alpha:1];
}


@end








