//
//  ZJHCycleView.m
//  ZJH
//
//  Created by Apple on 2017/6/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ZJHCycleView.h"
#define CellSNumber  10000
#define CellReuseIdentifier @"CellReuseIdentifier"
#import "UIImageView+WebCache.h"
#import "ZJHCycleViewCell.h"
@interface ZJHCycleView ()<UICollectionViewDelegate,UICollectionViewDataSource,ZJHCycleViewCellDelegate>
@property(nonatomic ,strong) NSMutableArray * bannerImages;
@property(nonatomic ,strong) NSMutableArray * imageTitles;
@property(nonatomic ,strong) UIPageControl * pageControll;
@property(nonatomic ,strong) NSTimer * timer;
@property (nonatomic ,assign) BOOL timeState;
@property (nonatomic ,assign) BOOL urlbool;
@property (nonatomic ,strong) UIImage * ploceholderImage;
/** 是否自动滚动 */
@property (nonatomic ,assign) BOOL autoScrolled;
/** 滚动次数 */
@property (nonatomic ,assign) int scrollNum;

@property (nonatomic ,strong) UICollectionViewFlowLayout * flowLayout;

@end
@implementation ZJHCycleView

/**bannerImages*/
- (NSMutableArray *)bannerImages {
    if (_bannerImages == nil) {
        _bannerImages = [[NSMutableArray alloc]init];
    }
    return _bannerImages;
}

/**imageTitles*/
- (NSMutableArray *)imageTitles {
    
    if (_imageTitles == nil) {
        _imageTitles = [[NSMutableArray alloc]init];
    }
    return _imageTitles;
}


- (void)ZJHCycleViewCellDelegateTapsNumber:(NSInteger)tapCount withZJHCycleViewCell:(ZJHCycleViewCell *)cycleViewCell andTapGesture:(UIGestureRecognizer *)tapGesture {
    
    switch (tapCount) {
        case 0:
        {
            if (self.autoScrolled && self.bannerImages.count > 1) {
                [self.timer invalidate];
                self.timer = nil;
                self.timeState = NO;
            }
            /**警告弹出*/
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"保存图片到相册" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //保存图片到相册
                UIImageWriteToSavedPhotosAlbum(cycleViewCell.imagesView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            }];
            UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if (self.autoScrolled && self.bannerImages.count > 1) {
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
                    self.timeState = YES;
                }
            }];
            [alert addAction:action1];
            [alert addAction:action];
            [[CALayer getCurrentController] presentViewController:alert animated:YES completion:nil];
        }
            
            break;
        case 1:
        {
            if ([self.delegate respondsToSelector:@selector(ZJHCycleViewDelegateCollectionView:didSelectItemAtIndexPath:)]) {
                [self.delegate ZJHCycleViewDelegateCollectionView:self.collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:(((NSIndexPath *)cycleViewCell.parameterId).row % self.bannerImages.count) inSection:0]];
            }

        }
            break;
        case 2:
        {
            cycleViewCell.titleLabel.hidden = !cycleViewCell.titleLabel.hidden;
        }
            break;
        case 3:
        {
            if (self.autoScrolled && self.bannerImages.count > 1) {
                [self.timer invalidate];
                self.timer = nil;
                self.timeState = NO;
            }
            if (self.collectionView.zoomScale == self.collectionView.minimumZoomScale) {
                CGPoint point = [tapGesture locationInView:self];
                [self.collectionView zoomToRect:CGRectMake(point.x - 24, point.y - 24 , 48, 48) animated:YES];
            }else {
                [self.collectionView setZoomScale:1.0f animated:YES];
            }

        }
            
            break;
        default:
            break;
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != NULL){
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appName = [infoDictionary objectForKey:@"CFBundleName"];
        /**警告弹出*/
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"保存图片被阻止了" message:[NSString stringWithFormat:@"请到系统->“设置”->“隐私”->“照片”中开启“%@”访问权限",appName] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (self.autoScrolled && self.bannerImages.count > 1) {
                self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
                self.timeState = YES;
            }
        }];
        [alert addAction:action];
        [[CALayer getCurrentController] presentViewController:alert animated:YES completion:nil];
    } else {
        /**警告弹出*/
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"保存图片成功" message:@"已保存至相册" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (self.autoScrolled && self.bannerImages.count > 1) {
                self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
                self.timeState = YES;
            }
        }];
        [alert addAction:action];
        [[CALayer getCurrentController] presentViewController:alert animated:YES completion:nil];
    }
}

- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate imageUrlArray:(NSArray *) imageUrls placeholderImageName:(UIImage *)image orLocalImageNameArray:(NSArray *)imageNames andImageTitles:(NSArray *)imageTitles autoScroll:(BOOL)autoScroll {
    
    if (self = [super initWithFrame:frame]) {
        self.delegate = delegate;
        self.ploceholderImage = image;
        self.autoScrolled = autoScroll;
        //比例
        self.collectionView.minimumZoomScale = 1.0f;
        self.collectionView.maximumZoomScale = 3.0f;
        if (imageUrls.count) {
            self.urlbool = YES;
            self.bannerImages = [NSMutableArray arrayWithArray:imageUrls];
            [self addCollectionView];
        }else if (imageNames.count) {
            self.urlbool = NO;
            self.bannerImages = [NSMutableArray arrayWithArray:imageNames];
            [self addCollectionView];
        }
        self.imageTitles = [NSMutableArray arrayWithArray:imageTitles];
        self.scrollNum = CellSNumber;
    }
    return self;
}

- (void)setImageUrlArray:(NSArray<NSString *> * )imageUrls {
    self.urlbool = YES;
    self.bannerImages = [NSMutableArray arrayWithArray:imageUrls];
    if (!self.collectionView) {
        [self addCollectionView];
    }else {
        [self.collectionView reloadData];
        if (self.autoScrolled && self.bannerImages.count > 1 && !self.timeState) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
            self.timeState = YES;
        }
    }
}

- (void)setLocalImageNameArray:(NSArray<NSString *> * )imageNames {
    self.urlbool = NO;
    self.bannerImages = [NSMutableArray arrayWithArray:imageNames];
    if (!self.collectionView) {
        [self addCollectionView];
    }else {
        [self.collectionView reloadData];
        if (self.autoScrolled && self.bannerImages.count > 1 && !self.timeState) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
            self.timeState = YES;
        }
    }
}

- (void)setImageTitlesArray:(NSArray<NSString *> * )imageTitles {
    self.imageTitles = [NSMutableArray arrayWithArray:imageTitles];
    [self.collectionView reloadData];
}

- (void)setCycleViewReapeatAlways:(BOOL)reapeat {
    if (reapeat) {
        self.scrollNum = CellSNumber;
        self.collectionView.bounces = YES;
    }else {
        self.scrollNum = (int)self.bannerImages.count;
        self.collectionView.bounces = NO;
    }
    [self.collectionView reloadData];
}

- (void)addCollectionView {
    
    //初始化一个布局
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //滚动方向
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.itemSize = self.frame.size;
    //item之间的间隔
    self.flowLayout.minimumLineSpacing = 0;
    //创建CollectionView
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
    //翻页模式
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerNib:[UINib nibWithNibName:@"ZJHCycleViewCell" bundle:nil] forCellWithReuseIdentifier:CellReuseIdentifier];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    self.pageControll.numberOfPages = self.bannerImages.count;
    if (self.autoScrolled  && self.bannerImages.count > 1) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
        self.timeState = YES;
    }
}

- (UIPageControl *)pageControll {
    
    if (!_pageControll) {
        _pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.height - 20, self.width, 20)];
        //指示器颜色
        _pageControll.pageIndicatorTintColor = [UIColor  grayColor];
        //当前点的颜色
        _pageControll.currentPageIndicatorTintColor = [UIColor greenColor];
        _pageControll.hidesForSinglePage = YES;
        [_pageControll addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_pageControll];
    }
    return _pageControll;
}

-(void)valueChange:(UIPageControl *)sender{
    
    NSInteger currentPage = sender.currentPage;
    //得到当前item的indexPath
    NSIndexPath * currentItem = self.collectionView.indexPathsForVisibleItems[0];
    //当前行
    NSInteger item = currentItem.item;
    if (currentPage > item % self.bannerImages.count) {
        //向右
        item++;
    }else {
        item--;
    }
    //下一行的indexpath
    NSIndexPath * nextPath = [NSIndexPath indexPathForItem:item inSection:0];
    [self.collectionView scrollToItemAtIndexPath:nextPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.bannerImages.count > 0) {
        return self.scrollNum;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZJHCycleViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    NSInteger index = indexPath.item % self.bannerImages.count;
    //给imagesview赋值
    if (self.urlbool) {
        [cell.imagesView sd_setImageWithURL:[NSURL URLWithString:self.bannerImages[index]] placeholderImage:self.ploceholderImage];
    }else {
        [cell.imagesView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:self.bannerImages[index] ofType:@""]]];
    }
    if (self.imageTitles && self.imageTitles.count > index) {
        cell.titleLabel.text = self.imageTitles[index];
    }else {
        cell.titleLabel.text = @"";
    }
    cell.titleLabel.hidden = NO;
    cell.delegate = self;
    cell.parameterId = indexPath;
    return cell;
}

#pragma mark----NSTimer----
- (void)autoScroll {
    //得到collectionview当前行currentRow
    NSIndexPath * currentPath = self.collectionView.indexPathsForVisibleItems[0];
    NSInteger row = currentPath.item;
    row++;
    if (row > CellSNumber) {
        row = 0;
        NSIndexPath *nextPath = [NSIndexPath indexPathForItem:row inSection:0];
        [self.collectionView scrollToItemAtIndexPath:nextPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }else {
        NSIndexPath *nextPath = [NSIndexPath indexPathForItem:row inSection:0];
        [self.collectionView scrollToItemAtIndexPath:nextPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

- (int)currentIndex {
    if (self.collectionView.width == 0 || self.collectionView.height == 0) {
        return 0;
    }
    int index = 0;
    if (self.flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (self.collectionView.contentOffset.x + self.flowLayout.itemSize.width * 0.5) / self.flowLayout.itemSize.width;
    } else {
        index = (self.collectionView.contentOffset.y + self.flowLayout.itemSize.height * 0.5) / self.flowLayout.itemSize.height;
    }
    return MAX(0, index);
}

//拖动时
- (void)dragScroll {
    //得到collectionview当前行currentRow
    int row = [self currentIndex];
    if (row == 0 && self.collectionView.contentOffset.x < - 20) {
        self.pageControll.currentPage = self.bannerImages.count - 1;
        NSIndexPath * nextPath = [NSIndexPath indexPathForItem:self.bannerImages.count * 2 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:nextPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }else {
        self.pageControll.currentPage = row % self.bannerImages.count;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.autoScrolled && self.bannerImages.count > 1) {
        [self.timer invalidate];
        self.timer = nil;
        self.timeState = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self dragScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.autoScrolled && self.bannerImages.count > 1) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
        self.timeState = YES;
    }
}

//当前手动滚动的页面
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(ZJHCycleViewDelegateCollectionView:didScrollItemAtIndexPath:)]) {
        //代理
        [self.delegate ZJHCycleViewDelegateCollectionView:(UICollectionView *)scrollView didScrollItemAtIndexPath:[NSIndexPath indexPathForItem:self.pageControll.currentPage inSection:0]];
    }
}

//当前自动滚动的页面
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    //代理
    if ([self.delegate respondsToSelector:@selector(ZJHCycleViewDelegateCollectionView:didScrollItemAtIndexPath:)]) {
        [self.delegate ZJHCycleViewDelegateCollectionView:(UICollectionView *)scrollView didScrollItemAtIndexPath:[NSIndexPath indexPathForItem:self.pageControll.currentPage inSection:0]];
    }
}

//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
            self.timeState = NO;
        }
    }
}

//进入或离开当前页面时
- (void)willMoveToWindow:(UIWindow *)newWindow {
    static int count = 0;
    if (self.autoScrolled && count % 2 && self.bannerImages.count > 1) {
        if (self.timeState) {
            [self.timer invalidate];
            self.timer = nil;
            self.timeState = NO;
        }else {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
            self.timeState = YES;
        }
    }
    count++;
}

-(void)dealloc {
    NSLog(@"ZJHCycleView释放了");
}





@end
