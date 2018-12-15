//
//  MZRecommendViewController.m
//  BaseTrunk
//
//  Created by King on 2018/12/11.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "MZRecommendViewController.h"
#import "MZRecommedGridCell.h"
#import "MZRecommedListCell.h"
#import "MZVideoListObject.h"
#import "MZCollectionViewGridLayout.h"

@interface MZRecommendViewController ()

{
    NSInteger last;
}

@property (nonatomic, assign) ShowType showType;
@property (nonatomic, strong) MZCollectionViewGridLayout *collectionlayout;

@end

@implementation MZRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionView.backgroundColor = [UIColor appBgColor];
    self.collectionView.showsVerticalScrollIndicator = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.showType = ShowTypeGrid;
    [self.collectionView reloadData];
}

- (Class)cellClass
{
    if (self.showType == ShowTypeList) {
        return [MZRecommedListCell class];
    }
    return [MZRecommedGridCell class];
}

- (UICollectionViewLayout *)layout
{
    if (!_collectionlayout) {
        _collectionlayout = [[MZCollectionViewGridLayout alloc] init];
    }
    
    if (self.showType == ShowTypeList) {
        _collectionlayout.numberOfItemsPerLine = 1;
        _collectionlayout.aspectRatio = ScreenWidth / ScreenHeight;
        _collectionlayout.sectionInset = UIEdgeInsetsZero;
        _collectionlayout.interitemSpacing = 0;
        _collectionlayout.lineSpacing = 0;
    } else {
        _collectionlayout.numberOfItemsPerLine = 3;
        _collectionlayout.aspectRatio = 105. / 130.;
        _collectionlayout.sectionInset = UIEdgeInsetsMake(5., 15., 0., 15.);
        _collectionlayout.interitemSpacing = 15;
        _collectionlayout.lineSpacing = 15;
    }
    return _collectionlayout;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (void)requestDidFinishLoad:(id)data
{
    [super requestDidFinishLoad:data];
    if(data && [data isKindOfClass:[NSDictionary class]])
    {
        if ([data containsObjectForKey:@"last"]) {
            last = [data intValueForKey:@"last" default:0];
        }
    }
}

- (id)paramsObject:(BOOL)more
{
    MZVideoListObject *videoListObejct = [MZVideoListObject new];
    videoListObejct.pageSize = 20;
    if (more) {
        videoListObejct.page = last + 1;
    } else {
        videoListObejct.page = 0; //手动刷新
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
