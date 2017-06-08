//
//  ADScrollPages.m
//  Day13-ScrollPages
//
//  Created by Naibin on 16/4/7.
//  Copyright © 2016年 Naibin. All rights reserved.
//

#import "ZJHScrollPages.h"
#import "ScrollPageCell.h"

#define VIEW_SIZE self.bounds.size

@interface ZJHScrollPages () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
/** 选中cell */
@property (nonatomic ,strong) ScrollPageCell * selectedCell;
///** 按钮标题 */
@property (nonatomic, strong) NSMutableArray * titles;
/** 头部视图 */
@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic,assign) NSInteger  itemWidth;
@end

@implementation ZJHScrollPages

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles andCallBack:(void (^)(UIView * addView, NSInteger index))callBack {
    if (self = [super initWithFrame:frame]) {
        self.callBack = callBack;
        [self.titles setArray:titles];
        //创建滚动视图
        [self addCollectionView];
        // 2.创建滚动视图
        [self createScrollView];
        // 3.调用callback
        dispatch_async(dispatch_get_main_queue(), ^{
            [self didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        });
    }
    return self;
}
#pragma mark - 按钮相关 

- (void)addCollectionView {
    
        //初始化一个布局
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width,50) collectionViewLayout:layout];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.bounces = NO;

    if (self.titles.count * 85 > self.bounds.size.width) {
        self.itemWidth = 85;
    
    }else {
        self.itemWidth = self.bounds.size.width / self.titles.count;
    }
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"ScrollPageCell" bundle:nil] forCellWithReuseIdentifier:@"ScrollPageCell"];

    self.collectionView.backgroundColor = [UIColor clearColor];
    //隐藏滚动线
    self.collectionView.showsHorizontalScrollIndicator = NO;
  
    [self addSubview:self.collectionView];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
          return self.titles.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    //获取复用的cell
    ScrollPageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ScrollPageCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.titles[indexPath.item];
    cell.lineView.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedCell.titleLabel.textColor = [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.00f];
    self.selectedCell.lineView.backgroundColor = [UIColor clearColor];
    ScrollPageCell * cell = (ScrollPageCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    self.selectedCell = cell;
    cell.titleLabel.textColor = [UIColor colorWithRed:0.29f green:0.58f blue:0.92f alpha:1.00f];
    cell.lineView.backgroundColor = [UIColor colorWithRed:0.29f green:0.58f blue:0.92f alpha:1.00f];
        // 4.填充子视图
    self.callBack(self.addView,indexPath.item);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 每个元素的大小
       return CGSizeMake(self.itemWidth, self.collectionView.bounds.size.height);
}
/*titles*/
- (NSMutableArray*)titles {
    
    if (_titles == nil) {
        _titles = [[NSMutableArray alloc]init];
    }
    return _titles;
}

#pragma mark - 滚动视图相关
- (void)createScrollView {
    self.addView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.collectionView.frame), self.bounds.size.width, self.frame.size.height - CGRectGetMaxY(self.collectionView.frame))];
    [self addSubview:self.addView];
}


- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
      dispatch_async(dispatch_get_main_queue(), ^{
    
           [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
      });
}



@end

