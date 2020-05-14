//
//  EditorSettingBar.h
//  YDRichTextEditor
//
//  Created by Liu on 2020/5/5.
//  Copyright © 2020 Sida Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SettingBar_Width 100
#define SettingBar_Height 100

@class EditorSettingBar;
@protocol EditorSettingBarDelegate <NSObject>

- (void)settingBar:(EditorSettingBar *)settingBar didClickBtn:(UIButton *)button;

@end

@interface EditorSettingBar : UIView

@property (nonatomic,weak) id<EditorSettingBarDelegate> delegate;

@property (nonatomic,strong) UIButton *removeItem;
@property (nonatomic,strong) UIButton *saveItem;

+ (instancetype)show:(CGFloat)y arrowX:(CGFloat)x height:(CGFloat)height;

@end

