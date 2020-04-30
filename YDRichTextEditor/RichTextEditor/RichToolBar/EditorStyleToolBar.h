//
//  EditorStyleToolBar.h
//  YDRichTextEditor
//
//  Created by Liu on 2020/4/30.
//  Copyright © 2020 Sida Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

//当前view高度
#define KWToolBar_Width 300
//当前view高度
#define KWToolBar_Height 50

@class EditorStyleToolBar;
@protocol EditorStyleToolBarDelegate<NSObject>
- (void)toolBar:(EditorStyleToolBar *)toolBar didClickBtn:(UIButton *)button;
@end

@interface EditorStyleToolBar : UIView

@property (nonatomic,weak) id<EditorStyleToolBarDelegate> delegate;

@property (nonatomic,strong) UIButton *boldItem;
@property (nonatomic,strong) UIButton *italicItem;
@property (nonatomic,strong) UIButton *headingItem;
@property (nonatomic,strong) UIButton *blockquoteItem;
@property (nonatomic,strong) UIButton *orderlistItem;
@property (nonatomic,strong) UIButton *unorderlistItem;
@property (nonatomic,strong) UIButton *hrItem;

+ (instancetype)show:(CGFloat)y arrowX:(CGFloat)x height:(CGFloat) height;
- (void)updateLayout:(CGRect)frame;
- (void)show;
- (void)hide;
- (void)updateFontBarWithButtonName:(NSString *)name;

@end

