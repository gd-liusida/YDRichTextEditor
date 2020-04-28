//
//  WKWebView+Tool.swift
//  YDRichTextEditor
//
//  Created by Liu on 2020/4/28.
//  Copyright © 2020 Sida Liu. All rights reserved.
//

import Foundation
import WebKit
import UIKit

typealias CallBack = (_ html: Any?) -> Void

extension WKWebView {
    
    /// 设置 placeholder
    func setPlaceholderTextWith(_ text: String) {
        let trigger = String(format: "zss_editor.setPlaceholder(\"%@\");", text)
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 设置HTML
    func setHTML(_ html: String) {
        let trigger = String(format: "zss_editor.setHTML(\"%@\");", html)
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 获取HTML
    func getHTML(_ complete: CallBack?) {
        self.evaluateJavaScript("zss_editor.getHTML();") { (html, error) in
            if error != nil {
                print("HTML Parsing Error: \(String(describing: error))")
            } else {
                complete?(html)
            }
        }
    }
    
    func getStyleHTML(_ html: String, complete: CallBack?) {
        let trigger = String(format: "style_html(\"%@\");", html)
        self.evaluateJavaScript(trigger) { (obj, error) in
            if error != nil {
                print("HTML Parsing Error: \(String(describing: error))")
            } else {
                complete?(obj)
            }
        }
    }
    
    /// 插入HTML
    func insertHTML(_ html: String) {
        let trigger = String(format: "zss_editor.insertHTML(\"%@\");", html)
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 获取文本
    func getText(_ complete: CallBack?) {
        self.evaluateJavaScript("zss_editor.getText();") { (html, error) in
            if error != nil {
                print("HTML Parsing Error: \(String(describing: error))")
            } else {
                complete?(html)
            }
        }
    }
    
    /// 清除文本
    func removeFormating() {
        self.evaluateJavaScript("zss_editor.removeFormating();", completionHandler: nil)
    }
    
    /// 后退
    func undo() {
        self.evaluateJavaScript("zss_editor.undo();", completionHandler: nil)
    }
    
    /// 前进
    func redo() {
        self.evaluateJavaScript("zss_editor.redo();", completionHandler: nil)
    }
    
    /// 插入链接
    /// - Parameters:
    ///   - url: 链接
    ///   - title: 标题
    func insertLink(_ url: String, title: String) {
        let trigger = String(format: "zss_editor.insertLink(\"%@\", \"%@\");", url, title)
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 更新链接
    /// - Parameters:
    ///   - url: 链接
    ///   - title: 标题
    func updateLink(_ url: String, title: String) {
        let trigger = String(format: "zss_editor.updateLink(\"%@\", \"%@\");", url, title)
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 加粗
    func setBold() {
        let trigger = "zss_editor.setBold();"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 下划线
    func setUnderline() {
        let trigger = "zss_editor.setUnderline();"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 斜体
    func setItalic() {
        let trigger = "zss_editor.setItalic();"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 设置字体标题
    func heading2() {
        let trigger = "zss_editor.setHeading('h2');"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    /// 设置字体标题
    func heading3() {
        let trigger = "zss_editor.setHeading('h3');"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    /// 设置字体标题
    func heading4() {
        let trigger = "zss_editor.setHeading('h4');"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    /// 设置字体标题
    func heading5() {
        let trigger = "zss_editor.setHeading('h5');"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    /// 设置字体标题
    func heading6() {
        let trigger = "zss_editor.setHeading('h6');"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 设置字体大小
    func setFontSize(_ size: String) {
        let trigger = String(format: "zss_editor.setFontSize(\"%@\");", size)
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 对齐方式 左
    func alignLeft() {
        let trigger = "zss_editor.setJustifyLeft();"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 对齐方式 中
    func alignCenter() {
        let trigger = "zss_editor.setJustifyCenter();"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 对齐方式 中
    func alignRight() {
        let trigger = "zss_editor.setJustifyRight();"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 无序
    func setUnorderedList() {
        let trigger = "zss_editor.setUnorderedList();"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 缩进
    func setIndent() {
        let trigger = "zss_editor.setIndent();"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 缩进
    func setOutdent() {
        let trigger = "zss_editor.setOutdent();"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 准备插入图片
    func prepareInsertImage() {
        let trigger = "zss_editor.prepareInsert();"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 插入 url 图片
    func insertImage(_ url: String, alt: String) {
        let trigger = "zss_editor.priInsertImage();"
        self.evaluateJavaScript(trigger, completionHandler: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.prepareInsertImage()
            let trigger = String(format: "zss_editor.insertImage(\"%@\", \"%@\");", url, alt)
            self.evaluateJavaScript(trigger, completionHandler: nil)
        }
    }
    /// 插入本地图片
    func insertImageBase64String(_ imageBase64String: String, alt: String) {
        let trigger = String(format: "zss_editor.insertImageBase64String(\"%@\", \"%@\");", imageBase64String, alt)
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 插入本地图片
    func updateImageBase64String(_ imageBase64String: String, alt: String) {
        let trigger = String(format: "zss_editor.updateImageBase64String(\"%@\", \"%@\");", imageBase64String, alt)
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 聚焦内容
    func showKeyboardContent() {
        self.allowDisplayingKeyboardWithoutUserAction()
        let trigger = "document.getElementById(\"zss_editor_content\").focus()"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 退出键盘
    func hiddenKeyboard() {
        self.allowDisplayingKeyboardWithoutUserAction()
        let trigger = "document.activeElement.blur()"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 设置内容高度
    func setContentHeight(_ contentHeight: Float) {
        let trigger = String(format: "zss_editor.contentHeight = %f;", contentHeight)
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 唤起键盘
    func focusTextEditor() {
        self.allowDisplayingKeyboardWithoutUserAction()
        let trigger = "zss_editor.focusEditor();"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    /// 收起键盘
    func blurTextEditor() {
        let trigger = "zss_editor.blurEditor();"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    func hideHTMLTitle() {
        let trigger = "zss_editor.vj_hideHTMLTitle();"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    func hideHTMLAbstract() {
        let trigger = "zss_editor.vj_hideHTMLAbstract();"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    func hideColumn() {
        let trigger = "zss_editor.vj_hideColumn();"
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    func vj_getHTMLTitle(_ block: CallBack?) {
        let trigger = "zss_editor.vj_getHTMLTitle();"
        self.evaluateJavaScript(trigger) { (html, error) in
            block?(html)
        }
    }
    
    func vj_getHTMLAbstract(_ block: CallBack?) {
        let trigger = "zss_editor.vj_getHTMLAbstract();"
        self.evaluateJavaScript(trigger) { (html, error) in
            block?(html)
        }
    }
    
    func setColumnTextWithText(_ text: String) {
        let trigger = String(format: "zss_editor.vj_setColumnContent(\"%@\");", text)
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
    func setFooterHeight(_ footerHeight: Float) {
        let trigger = String(format: "zss_editor.setFooterHeight(\"%f\");", footerHeight)
        self.evaluateJavaScript(trigger, completionHandler: nil)
    }
    
}
