//
//  ViewController.m
//  UICollectionView瀑布流
//
//  Created by huangdl on 14-9-24.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "ViewController.h"
#import "MyLayout.h"
#import "MyCell.h"
#import "MyModel.h"
@interface ViewController ()
{
    UICollectionView *_collectionView;
    NSMutableArray *_dataArray;
    NSMutableData *_data;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self prepareData];
    
    [self uiConfig];
    
}

-(void)prepareData
{
    _dataArray = [[NSMutableArray alloc]init];
    _data = [[NSMutableData alloc]init];
//    for (int i = 0; i<30; i++) {
//        MyModel *model = [[MyModel alloc]init];
//        model.cellHeight = 30.0 + (arc4random() % 300) ;
//        [_dataArray addObject:model];
//    }
    NSString *url = @"http://i.snssdk.com/gallery/1/top/?tag=ppmm&offset=1&count=30";
    
    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] delegate:self];
}

-(void)uiConfig
{
    MyLayout *layout = [[MyLayout alloc]init];
    layout.images = _dataArray;
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[MyCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_data setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    id res = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",res);
    NSDictionary *dic = (NSDictionary *)res;
    NSArray *arr = dic[@"data"];
    for (NSDictionary *d in arr) {
        MyModel *model = [[MyModel alloc]init];
        model.imgUrl = d[@"middle_url"];
        model.imgWidth = [d[@"image_width"] floatValue];
        model.imgHeight = [d[@"image_height"] floatValue];
        [_dataArray addObject:model];
        
    }
    //计算高度,用多线程计算
    //这种方法,适用于所有的数组元素之间没有关联的,也没有次序的情况
    //这个方法后面的代码,会在所有的线程执行完成以后再继续执行
    dispatch_apply(_dataArray.count, dispatch_get_global_queue(0, 0), ^(size_t n) {
        MyModel *model = _dataArray[n];
        model.cellHeight = model.imgHeight / model.imgWidth * 160;
    });
    [_collectionView reloadData];
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
}


@end























