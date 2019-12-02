//
//  SDTableView.m
//  SuperDeer
//
//  Created by liulei on 2019/1/9.
//  Copyright © 2019年 NHN. All rights reserved.
//

#import "SDTableView.h"
#import "MJRefresh.h"
#import "SDUIHelpers.h"
#import "NSString+SDExtension.h"

@interface SDTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *heightArray;
@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, assign) NSInteger page;

@end

@implementation SDTableView

#pragma mark - Lifecycle

- (instancetype)initWithCellClass:(nullable Class)cellClass
{
    self = [super init];
    if (self) {
        
        _models = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor whiteColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        _cellIdentifier = NSStringFromClass(cellClass);
        [self registerClass:cellClass forCellReuseIdentifier:_cellIdentifier];
        
        self.row = 10;
        self.noDataTipsText = @"暂无数据";
        _page = 1;
        [self requestWithPage:_page];
    }
    return self;
}

- (instancetype)initWithNib:(nullable UINib *)nib forCellReuseIdentifier:(NSString *)identifier {
    
    self = [super init];
    if (self) {
        
        _models = [[NSMutableArray alloc] init];
        _cellIdentifier = identifier;
        self.delegate = self;
        self.dataSource = self;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }

        [self registerNib:nib forCellReuseIdentifier:_cellIdentifier];
        
        self.row = 10;
        self.noDataTipsText = @"暂无数据";
        _page = 1;
        [self requestWithPage:_page];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier
                                                            forIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id model = [self modelsAtIndexPath:indexPath];
    if(self.cellConfigure && model) {
        self.cellConfigure(cell, model, indexPath);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id model = [self modelsAtIndexPath:indexPath];
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    
    if(self.cellDidSelect && model) {
        self.cellDidSelect(cell, model, indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_heightArray && _heightArray.count > indexPath.row) {
        return [_heightArray[indexPath.row] doubleValue];
    }
    else {
        return self.cellHeight;
    }
}

#pragma mark - Private

- (void)requestWithPage:(NSInteger)page {
    
    if (self.sdDelegate && [self.sdDelegate respondsToSelector:@selector(sdTableView:requestDataWithPage:)]) {
        [self.sdDelegate sdTableView:self requestDataWithPage:page];
    }
}

- (void)loadMoreData {
    
    _page++;
    [self requestWithPage:_page];
}

- (void)endRefreshing {
    
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
}

- (void)endRefreshingWithNoMoreData {
    
    if (_models.count >= self.row) {
        self.mj_footer.hidden = NO;
    }
    else {
        self.mj_footer.hidden = YES;
    }
    
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }
}

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath {
    return _models.count > indexPath.row ? _models[indexPath.row] : nil;
}

#pragma mark - Public

- (void)addModels:(NSArray *)models {
    
    if(!models) {
        if (_models.count == 0) {
            // 解决刷新页面无返回时，顶部存在下拉的问题
            self.mj_footer.hidden = YES;
        }
        return;
    }
    
    if (self.hasRefreshFooter) {
        [_models addObjectsFromArray:models];
    }
    else {
        _models = [NSMutableArray arrayWithArray:models];
    }
    
    if (models && [models isKindOfClass:[NSArray class]] && _models.count > 0) {
        
        self.mj_footer.hidden = NO;
        if (models.count < self.row) {
            [self endRefreshingWithNoMoreData];
            if (models.count > 0) {
                // 无数据不刷新
                [self reloadData];
            }
        }
        else {
            [self endRefreshing];
            [self reloadData];
        }
        
        if (_noDataView) {
            _noDataView.hidden = YES;
            if (!_hasRefreshGifHeader) {
                self.scrollEnabled = YES;
            }
        }
    }
    else {
        
        self.noDataView.hidden = NO;
        if (!_hasRefreshGifHeader) {
            self.scrollEnabled = NO;
        }
        
        // 无数据也需要刷新tableview，保证contentSize的正确性
        if (!_models) {
            _models = [[NSMutableArray alloc] init];
        }
        
        [self reloadData];
    }
    
    
    if ([self.mj_header isRefreshing]) {
        
        _page = 1;
        [self.mj_header endRefreshing];
    }
}

- (void)addCellHeights:(NSArray *)heightArray {
    
    if (!_heightArray) {
        _heightArray = [[NSMutableArray alloc] init];
    }
    
    if (self.hasRefreshFooter) {
        [_heightArray addObjectsFromArray:heightArray];
    }
    else {
        _heightArray = [NSMutableArray arrayWithArray:heightArray];
    }
}

- (void)removeAllModels {
    
    [_models removeAllObjects];
    if (_heightArray) {
        [_heightArray removeAllObjects];
    }
    if (_hasRefreshFooter) {
        [self.mj_footer resetNoMoreData];
        self.mj_footer.hidden = YES;
    }
    
    if (_noDataView) {
        _noDataView.hidden = YES;
        if (!_hasRefreshGifHeader) {
            self.scrollEnabled = YES;
        }
    }
    
    _page = 1;
    [self reloadData];
}

#pragma mark - Get

- (UIView *)noDataView {
    
    if (!_noDataView) {
        if (_noDataType == SDTableViewNoDataTypeOnlyWord) {
            
            _noDataView = [[UIView alloc] initWithFrame:self.bounds];
            [self addSubview:_noDataView];
            
            UILabel *label = [SDUIHelpers initLabelWithFontSize:14
                                                      textColor:[UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1.00]
                                                  textAlignment:NSTextAlignmentCenter addToView:_noDataView];
            label.numberOfLines = 0;
            label.text = self.noDataTipsText;
            [label sizeToFit];
            label.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        }
        else {
            
            if ([NSString isEmpty:self.noDataImageName]) {
                _noDataView = [SDUIHelpers initNoDataViewFromView:self withText:self.noDataTipsText];
            }
            else {
                _noDataView = [SDUIHelpers initNoDataViewFromView:self withText:self.noDataTipsText frame:self.bounds imageName:self.noDataImageName];
            }
        }
    }
    
    return _noDataView;
}

#pragma mark - Set

- (void)setHasRefreshGifHeader:(BOOL)hasRefreshGifHeader {
    
    if (hasRefreshGifHeader) {
        
        MJRefreshGifHeader *header = [SDUIHelpers initMJRefreshGifHeaderWithWithRefreshingBlock:^{
            
            if (self.sdDelegate && [self.sdDelegate respondsToSelector:@selector(sdTableViewStartRefresh:)]) {
                [self.sdDelegate sdTableViewStartRefresh:self];
            }
            [self removeAllModels];
        }];
        
        self.mj_header = header;
    }
    
    _hasRefreshGifHeader = hasRefreshGifHeader;
}

- (void)setHasRefreshFooter:(BOOL)hasRefreshFooter {
    
    if (hasRefreshFooter) {
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self loadMoreData];
        }];
        footer.triggerAutomaticallyRefreshPercent = 0.5;
        self.mj_footer = footer;
        self.mj_footer.hidden = YES;
    }
    
    _hasRefreshFooter = hasRefreshFooter;
}

@end
