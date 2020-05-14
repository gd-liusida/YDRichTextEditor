//
//  EditorSettingBar.m
//  YDRichTextEditor
//
//  Created by Liu on 2020/5/5.
//  Copyright © 2020 Sida Liu. All rights reserved.
//

#import "EditorSettingBar.h"

@interface EditorSettingBar()

@property (nonatomic, assign) CGFloat arrowX;
@property (nonatomic, assign) CGFloat kArrowHeight;

@property (nonatomic,strong) NSArray *items;

@end

@implementation EditorSettingBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.kArrowHeight = 10;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

+ (instancetype)show:(CGFloat)y arrowX:(CGFloat)x height:(CGFloat)height {
    EditorSettingBar *settingBar = [[EditorSettingBar alloc] init];
    [settingBar setup:y arrowX:x];
    return settingBar;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setup:(CGFloat)y arrowX:(CGFloat)x {
    self.arrowX = x;
    self.frame = CGRectMake(0, y, SettingBar_Width, SettingBar_Height);
    [self setupViews:self.frame];
}

- (void)setupViews:(CGRect)frame {
    self.items = @[
        self.removeItem,
        self.saveItem
    ];
    NSInteger itemCount = self.items.count;
    CGFloat itemHeight = (SettingBar_Height - 10) / itemCount;
    for (int i = 0; i < itemCount; i++) {
        UIButton *button = self.items[i];
        button.frame = CGRectMake(0, i * itemHeight, SettingBar_Width, itemHeight);
        button.tag = i;
        [self addSubview:button];
    }
}

- (UIButton *)removeItem {
    if (!_removeItem) {
        _removeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_removeItem setImage:[UIImage imageNamed:@"bold_normal_icon"] forState:UIControlStateNormal];
        [_removeItem setImage:[UIImage imageNamed:@"bold_select_icon"] forState:UIControlStateSelected];
        [_removeItem setTitle:@"删除" forState:UIControlStateNormal];
        [_removeItem setTitle:@"删除" forState:UIControlStateSelected];
        _removeItem.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_removeItem addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeItem;
}

- (UIButton *)saveItem {
    if (!_saveItem) {
        _saveItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveItem setImage:[UIImage imageNamed:@"bold_normal_icon"] forState:UIControlStateNormal];
        [_saveItem setImage:[UIImage imageNamed:@"bold_select_icon"] forState:UIControlStateSelected];
        [_saveItem setTitle:@"保存" forState:UIControlStateNormal];
        [_saveItem setTitle:@"保存" forState:UIControlStateSelected];
        _saveItem.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_saveItem addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveItem;
}

- (void)clickButton:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(settingBar:didClickBtn:)]) {
        [self.delegate settingBar:self didClickBtn:btn];
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
