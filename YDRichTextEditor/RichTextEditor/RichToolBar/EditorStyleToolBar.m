//
//  EditorStyleToolBar.m
//  YDRichTextEditor
//
//  Created by Liu on 2020/4/30.
//  Copyright © 2020 Sida Liu. All rights reserved.
//

#import "EditorStyleToolBar.h"
#import "UIControl+KWButtonExtension.h"

#define COLOR(r,g,b,a) ([UIColor colorWithRed:(float)r/255.f green:(float)g/255.f blue:(float)b/255.f alpha:a])

//最右边按钮宽度
#define KWRightButton_Width 44

//所有按钮宽度
#define KWItems_Width 40

@interface EditorStyleToolBar()<UIScrollViewDelegate>

@property (nonatomic, assign) CGFloat arrowX;
@property (nonatomic, assign) CGFloat kArrowHeight;

@property (nonatomic,strong) UIScrollView *scroBarView;
@property (nonatomic,strong) NSArray *items;

@end

@implementation EditorStyleToolBar

+ (instancetype)show:(CGFloat)y arrowX:(CGFloat)x height:(CGFloat)height {
    EditorStyleToolBar *toolBar = [[EditorStyleToolBar alloc] init];
    toolBar.arrowX = x;
    [toolBar setup:y arrowX:x height:height];
    return toolBar;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.kArrowHeight = 10;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)setup:(CGFloat)y arrowX:(CGFloat)x height:(CGFloat)height {
    self.arrowX = x;
    self.frame = CGRectMake(40, y, KWToolBar_Width, height);
    [self setupViews:self.frame];
}

- (void)updateLayout:(CGRect)frame {
    self.frame = frame;
}

- (void)show {
    [UIView animateWithDuration:0.3 animations:^{
        self.hidden = NO;
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.hidden = YES;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (UIScrollView *)scroBarView{
    if (!_scroBarView) {
        _scroBarView = [[UIScrollView alloc] init];
        _scroBarView.delegate = self;
        _scroBarView.showsVerticalScrollIndicator = NO;
        _scroBarView.showsHorizontalScrollIndicator = NO;
    }
    return _scroBarView;
}

- (void)setupViews:(CGRect)frame{

    self.scroBarView.frame = CGRectMake(0,0, frame.size.width, 40);
    
    [self addSubview:self.scroBarView];
    
    self.items = @[
                   self.boldItem,
                   self.italicItem,
                   self.headingItem,
                   self.blockquoteItem,
                   self.orderlistItem,
                   self.unorderlistItem,
                   self.hrItem,
                ];
    
    NSInteger itemsCount = self.items.count;
    CGFloat itemWidth = KWToolBar_Width / itemsCount;
    for (int i = 0; i < itemsCount; i++) {
        UIButton *button = self.items[i];
        button.frame = CGRectMake(i*itemWidth,0, itemWidth,frame.size.height - 10);
        button.tag = i;
        [self.scroBarView addSubview:button];

    }
    self.scroBarView.contentSize = CGSizeMake(itemsCount*itemWidth, 0);
}

- (UIButton *)boldItem{
    if (!_boldItem) {
        _boldItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_boldItem setImage:[UIImage imageNamed:@"bold_normal_icon"] forState:UIControlStateNormal];
        [_boldItem setImage:[UIImage imageNamed:@"bold_select_icon"] forState:UIControlStateSelected];
        _boldItem.orderTag = @"bold";
        [_boldItem addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _boldItem;
}

- (UIButton *)italicItem{
    if (!_italicItem) {
        _italicItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_italicItem setImage:[UIImage imageNamed:@"italic_normal_icon"] forState:UIControlStateNormal];
        [_italicItem setImage:[UIImage imageNamed:@"italic_select_icon"] forState:UIControlStateSelected];
        _italicItem.orderTag = @"italic";
        [_italicItem addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _italicItem;
}

- (UIButton *)headingItem{
    if (!_headingItem) {//18
        _headingItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_headingItem setImage:[UIImage imageNamed:@"header_normal_icon"] forState:UIControlStateNormal];
        [_headingItem setImage:[UIImage imageNamed:@"header_select_icon"] forState:UIControlStateSelected];
        _headingItem.orderTag = @"4";
        [_headingItem addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headingItem;
}

- (UIButton *)blockquoteItem{
    if (!_blockquoteItem) {
        _blockquoteItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_blockquoteItem setImage:[UIImage imageNamed:@"blockquote_normal_icon"] forState:UIControlStateNormal];
        [_blockquoteItem setImage:[UIImage imageNamed:@"blockquote_select_icon"] forState:UIControlStateSelected];
        _blockquoteItem.orderTag = @"blockquote";
        [_blockquoteItem addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _blockquoteItem; 
}

- (UIButton *)orderlistItem{
    if (!_orderlistItem) {
        _orderlistItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_orderlistItem setImage:[UIImage imageNamed:@"ordered_normal_icon"] forState:UIControlStateNormal];
        [_orderlistItem setImage:[UIImage imageNamed:@"ordered_select_icon"] forState:UIControlStateSelected];
        _orderlistItem.orderTag = @"orderlist";
        [_orderlistItem addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderlistItem;
}

- (UIButton *)unorderlistItem{
    if (!_unorderlistItem) {
        _unorderlistItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_unorderlistItem setImage:[UIImage imageNamed:@"unordered_normal_icon"] forState:UIControlStateNormal];
             [_unorderlistItem setImage:[UIImage imageNamed:@"unordered_select_icon"] forState:UIControlStateSelected];
        _unorderlistItem.orderTag = @"unorderedList";
            [_unorderlistItem addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _unorderlistItem;
}

- (UIButton *)hrItem{
    if (!_hrItem) {
        _hrItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hrItem setImage:[UIImage imageNamed:@"inserthr_icon"] forState:UIControlStateNormal];
        [_hrItem setImage:[UIImage imageNamed:@"inserthr_icon"] forState:UIControlStateSelected];
        _hrItem.orderTag = @"hr";
        [_hrItem addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hrItem;
}

#pragma mark -items
- (void)clickButton:(UIButton *)button{

    if ([self.delegate respondsToSelector:@selector(toolBar:didClickBtn:)]) {
        [self.delegate toolBar:self didClickBtn:button];
    }
}

- (void)updateFontBarWithButtonName:(NSString *)name{
    
     NSLog(@"name = %@",name);
    
    NSArray *itemNames = [name componentsSeparatedByString:@","];
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSString *orderTag in itemNames) {
        for (UIButton *btn in self.items) {
            if (![tempArr containsObject:btn] && btn.orderTag.length > 0) {
                if ([btn.orderTag isEqualToString:orderTag]) {
                    btn.selected = YES;
                     [tempArr addObject:btn];
                }
                else{
                    btn.selected = NO;
                }
            }
        }
    }
    
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawInContext:context];
    self.layer.shadowColor = [UIColor clearColor].CGColor;
    self.layer.shadowOpacity = 0.0;
    self.layer.shadowOffset = CGSizeMake(0, 0);
}

- (void)drawInContext:(CGContextRef) context {
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [[UIColor blackColor] colorWithAlphaComponent:0.7].CGColor);
    [self drawPath:context];
    CGContextFillPath(context);
}

- (void) drawPath:(CGContextRef) context {
    CGFloat radius = 6.0;
    CGFloat minX = CGRectGetMinX(self.bounds);
    CGFloat maxX = CGRectGetMaxX(self.bounds);
    CGFloat midX = self.arrowX;
    CGFloat minY = CGRectGetMinY(self.bounds);
    CGFloat maxY = CGRectGetMaxY(self.bounds) - self.kArrowHeight;
    
    CGContextMoveToPoint(context, midX + self.kArrowHeight, maxY);
    CGContextAddLineToPoint(context, midX, maxY + self.kArrowHeight);
    CGContextAddLineToPoint(context, midX - _kArrowHeight, maxY);
    
    CGContextAddArcToPoint(context, minX, maxY, minX, minY, radius);
    
    CGContextAddArcToPoint(context, minX, minY, maxX, minY, radius);
    CGContextAddArcToPoint(context, maxX, minY, maxX, maxY, radius);
    CGContextAddArcToPoint(context, maxX, maxY, minX, maxY, radius);
    CGContextClosePath(context);
}


@end
