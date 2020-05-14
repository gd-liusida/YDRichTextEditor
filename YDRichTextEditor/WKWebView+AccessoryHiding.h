//
//  WKWebView+AccessoryHiding.h
//  YDRichTextEditor
//
//  Created by Liu on 2020/5/11.
//  Copyright © 2020 Sida Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WKWebView (AccessoryHiding)

@property (nonatomic, strong, nullable) UIView *sd_inputAccessoryView;

@end
