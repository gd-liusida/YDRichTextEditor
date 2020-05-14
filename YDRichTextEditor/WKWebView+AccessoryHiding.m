//
//  WKWebView+AccessoryHiding.m
//  YDRichTextEditor
//
//  Created by Liu on 2020/5/11.
//  Copyright © 2020 Sida Liu. All rights reserved.
//

#import "WKWebView+AccessoryHiding.h"
#import <objc/runtime.h>

@implementation WKWebView (AccessoryHiding)

static const char * const hackishFixClassName = "UIWebBrowserViewMinusAccessoryView";
static Class hackishFixClass = Nil;

- (UIView *)sd_inputAccessoryView {
    return objc_getAssociatedObject(self, @selector(sd_inputAccessoryView));
}

- (void)setSd_inputAccessoryView:(UIView *)sd_inputAccessoryView {
    objc_setAssociatedObject(self, @selector(sd_inputAccessoryView), sd_inputAccessoryView, OBJC_ASSOCIATION_RETAIN);
    UIView *browserView = [self hackishlyFoundBrowserView];
    if (browserView == nil) {
        return;
    }
    [self ensureHackishSubclassExistsOfBrowserViewClass:[browserView class]];
    object_setClass(browserView, hackishFixClass);
    [browserView reloadInputViews];
}

- (UIView *)hackishlyFoundBrowserView {
    UIScrollView *scrollView = self.scrollView;
    UIView *browserView = nil;
    for (UIView *subview in scrollView.subviews) {
        NSString *className = NSStringFromClass([subview class]);
        if ([className hasPrefix:@"WKContentView"]) {
            browserView = subview;
            break;
        }
    }
    return browserView;
}

- (id)methodReturningCustomInputAccessoryView {
    UIView *view = self;
    UIView *customInputAccessoryView = nil;
    while (view && ![view isKindOfClass:[WKWebView class]]) {
        view = view.superview;
    }
    if ([view isKindOfClass:[WKWebView class]]) {
        WKWebView *webView = (WKWebView *)view;
        customInputAccessoryView = [webView sd_inputAccessoryView];
    }
    return customInputAccessoryView;
}

- (void)ensureHackishSubclassExistsOfBrowserViewClass:(Class)browserViewClass {
    if (!hackishFixClass) {
        Class newClass = objc_allocateClassPair(browserViewClass, hackishFixClassName, 0);
        IMP nilImp = [self methodForSelector:@selector(methodReturningCustomInputAccessoryView)];
        class_addMethod(newClass, @selector(inputAccessoryView), nilImp, "@@:");
        objc_registerClassPair(newClass);
        hackishFixClass = newClass;
    }
}

@end
