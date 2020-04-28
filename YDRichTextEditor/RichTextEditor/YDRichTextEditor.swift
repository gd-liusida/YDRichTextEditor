//
//  YDRichTextEditor.swift
//  YDRichTextEditor
//
//  Created by Liu on 2020/4/28.
//  Copyright © 2020 Sida Liu. All rights reserved.
//

import UIKit
import WebKit

class YDRichTextEditor: UIView {

    lazy var editorView: WKWebView = {
        let config: WKWebViewConfiguration = WKWebViewConfiguration.init()
        let userCon: WKUserContentController = WKUserContentController.init()
        config.userContentController = userCon
        let editorView: WKWebView = WKWebView.init(frame: CGRect.zero, configuration: config)
        userCon.add(self, name: "column")
        editorView.navigationDelegate = self
        editorView.uiDelegate = self
        editorView.hidesInputAccessoryView = true
        editorView.scrollView.bounces = false
        editorView.backgroundColor = UIColor.white
//        editorView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
        return editorView
    }()
    
    /// <#Description#>
    var formatHTML: Bool = false
    var receiveEditorDidChangeEvents: Bool = false
    var placeholder: String = ""
    
    /// BOOL for holding if the resources are loaded or not
    var resourcesLoaded: Bool = false
    var internalHTML: String = ""
    var editorLoaded: Bool = false
    
    init() {
        super.init(frame: CGRect.zero)
        initConfig()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initConfig()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initConfig()
    }
    
    func initConfig() {
        self.addSubview(self.editorView)
        self.editorView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        if !self.resourcesLoaded {
            self.loadResources()
        }
    }
    
    func loadResources() {
        var htmlString = ""
        // Create a string with the contents of editor.html
        if let filePath = Bundle.main.path(forResource: "editor", ofType: "html") {
            if let htmlData = NSData(contentsOfFile: filePath) {
                if let htmlStr = String.init(data: htmlData as Data, encoding: .utf8) {
                    htmlString = htmlStr
                }
            }
        }
        // Add jQuery.js to the html file
        if let jquery = Bundle.main.path(forResource: "jQuery", ofType: "js") {
            if let jsData = NSData(contentsOfFile: jquery) {
                if let jqueryStr = String.init(data: jsData as Data, encoding: .utf8) {
                    htmlString = htmlString.replacingOccurrences(of: "<!-- jQuery -->", with: jqueryStr)
                }
            }
        }
        // Add JSBeautifier.js to the html file
        if let beautifier = Bundle.main.path(forResource: "JSBeautifier", ofType: "js") {
            if let jsData = NSData(contentsOfFile: beautifier) {
                if let beautifierStr = String.init(data: jsData as Data, encoding: .utf8) {
                    htmlString = htmlString.replacingOccurrences(of: "<!-- jsbeautifier -->", with: beautifierStr)
                }
            }
        }
        // Add ZSSRichTextEditor.js to the html file
        if let source = Bundle.main.path(forResource: "ZSSRichTextEditor", ofType: "js") {
            if let jsData = NSData(contentsOfFile: source) {
                if let jsStr = String.init(data: jsData as Data, encoding: .utf8) {
                    htmlString = htmlString.replacingOccurrences(of: "<!--editor-->", with: jsStr)
                }
            }
        }
        let basePath = Bundle.main.bundlePath
        let baseURL = URL.init(fileURLWithPath: basePath)
        self.editorView.loadHTMLString(htmlString, baseURL: baseURL)
        
        self.resourcesLoaded = true
        
    }
    
    func setPlaceholderText() {
        if self.placeholder.count > 0 {
            self.editorView.setPlaceholderTextWith(self.placeholder)
        }
    }
    
    func setHTML(_ html: String) {
        self.internalHTML = html
        if self.editorLoaded {
            self.updateHTML()
        }
    }
    
    func updateHTML() {
        let html = self.internalHTML
        let cleanedHTML = self.removeQuotesFromHTML(html)
        self.editorView.setHTML(cleanedHTML)
    }
    
    func getHTML(_ complete: CallBack?) {
        self.editorView.getHTML { (html) in
            if let htmlStr = html as? String {
                let htmlString = self.removeQuotesFromHTML(htmlStr)
                self.tidyHTML(htmlString) { (obj) in
                    complete?(obj)
                }
            }
        }
    }
    
    func insertHTML(_ html: String) {
        let cleanedHTML = self.removeQuotesFromHTML(html)
        self.editorView.insertHTML(cleanedHTML)
    }
    
    func getText(_ complete: CallBack?) {
        self.editorView.getText(complete)
    }
    
    func setBold() {
        self.editorView.setBold()
    }
    
    func setItalic() {
        self.editorView.setItalic()
    }
    
    func removeFormat() {
        self.editorView.removeFormating()
    }
    
    func insertLink() {
        self.editorView.prepareInsertImage()
    }
    
    func insertLink(_ link: String, title: String) {
        self.editorView.insertLink(link, title: title)
    }
    
    func insertImage() {
        self.editorView.prepareInsertImage()
    }
    
    func insertImageLink(_ link: String, alt: String) {
        self.editorView.prepareInsertImage()
        self.editorView.insertImage(link, alt: alt)
    }
    
    func insertImage(_ base64String: String, alt: String) {
        self.editorView.prepareInsertImage()
        self.editorView.insertImageBase64String(base64String, alt: alt)
    }
    
    func removeQuotesFromHTML(_ html: String) -> String {
        var htmlStr = html
        htmlStr = htmlStr.replacingOccurrences(of: "\"", with: "\\\"")
        htmlStr = htmlStr.replacingOccurrences(of: "“", with: "&quot;")
        htmlStr = htmlStr.replacingOccurrences(of: "”", with: "&quot;")
        htmlStr = htmlStr.replacingOccurrences(of: "\r", with: "\\r")
        htmlStr = htmlStr.replacingOccurrences(of: "\n", with: "\\n")
        return htmlStr
    }
    
    func tidyHTML(_ html: String, complete: CallBack?) {
        var htmlStr = html
        htmlStr = htmlStr.replacingOccurrences(of: "<br>", with: "<br />")
        htmlStr = htmlStr.replacingOccurrences(of: "<hr>", with: "<hr />")
        if self.formatHTML {
            self.editorView.getStyleHTML(htmlStr) { (obj) in
                complete?(obj)
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "URL" {
            if let url = self.editorView.url {
                let urlStr = url.absoluteString
                self.handleEvent(urlStr)
            }
        }
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
    }
    
    func handleEvent(_ urlStr: String) {
        if urlStr.hasPrefix("state-title://") || urlStr.hasPrefix("state-abstract-title://") {
            
        } else if (urlStr as NSString).range(of: "callback://0/").location != NSNotFound {
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension YDRichTextEditor: WKUIDelegate, WKScriptMessageHandler, WKNavigationDelegate {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.editorLoaded = true
        if self.internalHTML != "" {
            self.internalHTML = ""
        }
        self.updateHTML()
        if self.placeholder != "" {
            self.setPlaceholderText()
        }
    }
    
}
