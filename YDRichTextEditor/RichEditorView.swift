//
//  RichEditorView.swift
//  YDRichTextEditor
//
//  Created by Liu on 2020/5/11.
//  Copyright © 2020 Sida Liu. All rights reserved.
//

import UIKit
import WebKit

class RichEditorView: UIView {

    /*
     *  WKWebView for writing/editing/displaying the content
     */
    lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration.init()
        let userCon = WKUserContentController.init()
        userCon.add(self, name: "column")
        userCon.add(self, name: "coverImage")
        config.userContentController = userCon
        let webView:WKWebView = WKWebView.init(frame: CGRect.zero, configuration: config)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.scrollView.bounces = false
        webView.backgroundColor = UIColor.white
        webView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
        return webView
    }()
    
    /// Input accessory view to display over they keyboard.
    /// Defaults to nil
    open override var inputAccessoryView: UIView? {
        get {return webView.sd_inputAccessoryView}
        set {webView.sd_inputAccessoryView = newValue}
    }
    
    ///Whether or not scroll is enabled on the view.
    open var isScrollEnabled: Bool = true {
        didSet {
            webView.scrollView.isScrollEnabled = isScrollEnabled
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        webView.frame = bounds
        self.addSubview(webView)
        if let filePath = Bundle(for: RichEditorView.self).path(forResource: "rich_editor", ofType: "html") {
            let file_url = URL.init(fileURLWithPath: filePath, isDirectory: false)
            let request = URLRequest(url: file_url)
            webView.load(request)
        }
    }
    
    func runJS(_ js: String, completionHandler: ((Any?, Error?) -> Void)?) {
        webView.evaluateJavaScript(js, completionHandler: completionHandler)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension RichEditorView: WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    
}
