//
//  YCRecommendViewController.m
//  BaseTrunk
//
//  Created by King on 2018/12/11.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "RecommendViewController.h"
#import "YCRecommedGridCell.h"
#import "YCRecommedListCell.h"
#import "WYCollectionViewGridLayout.h"
#import "YCVideoListObject.h"

@interface RecommendViewController ()

@property (nonatomic, assign) ShowType showType;
@property (nonatomic, strong) WYCollectionViewGridLayout *collectionlayout;

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.showType = ShowTypeGrid;
    [self.collectionView reloadData];
}

- (Class)cellClass
{
    if (self.showType == ShowTypeList) {
        return [YCRecommedListCell class];
    }
    return [YCRecommedGridCell class];
}

- (UICollectionViewLayout *)layout
{
    if (!_collectionlayout) {
        _collectionlayout = [[WYCollectionViewGridLayout alloc] init];
    }
    if (self.showType == ShowTypeList) {
        _collectionlayout.numberOfItemsPerLine = 1;
        _collectionlayout.aspectRatio = ScreenWidth / ScreenHeight;
        _collectionlayout.sectionInset = UIEdgeInsetsZero;
        _collectionlayout.interitemSpacing = 0;
        _collectionlayout.lineSpacing = 0;
    } else {
        _collectionlayout.numberOfItemsPerLine = 3;
        _collectionlayout.aspectRatio = 1;
        _collectionlayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _collectionlayout.interitemSpacing = 10;
        _collectionlayout.lineSpacing = 10;
    }
    return _collectionlayout;
}

- (id)paramsObject:(BOOL)more
{
    YCVideoListObject *videoListObejct = [YCVideoListObject new];
    videoListObejct.pageSize = 20;
    if (more) {
//        videoListObejct.page = last + 1;
    } else {
//        [self setReset];
//        if ([YCAppDelegate sharedAppDelegate].didFinishLaunching) {
//            videoListObejct.page = 1; //启动app
//            [YCAppDelegate sharedAppDelegate].didFinishLaunching = NO;
//        } else {
            videoListObejct.page = 0; //手动刷新
//        }
    }
    return videoListObejct;
}

- (void)changeShowType:(ShowType)showType
{
    self.showType = showType;
    [self.collectionView registerClass:[self cellClass] forCellWithReuseIdentifier:NSStringFromClass([self cellClass])];
    [self.collectionView setCollectionViewLayout:[self layout]];
    [self.collectionView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
