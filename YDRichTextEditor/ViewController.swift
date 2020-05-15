//
//  ViewController.swift
//  YDRichTextEditor
//
//  Created by Liu on 2020/4/28.
//  Copyright © 2020 Sida Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var textEditor: ZSSRichTextEditor = {
        let textEditor: ZSSRichTextEditor = ZSSRichTextEditor.init()
        textEditor.vj_hideColumn = true
        textEditor.vj_hideHTMLAbstract = true
        textEditor.isHideFooter = true
        textEditor.isHideContentNumber = true
        textEditor.isHideTitleNumber = true
        return textEditor
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.setTitleNumberWithText("0/100")
//        isHideTitleNumber = true
//        vj_hideColumn = true
//        vj_hideHTMLAbstract = true
        let height = UIScreen.main.bounds.height - 88
        self.textEditor.updateLayoutFrame(CGRect.init(x: 0, y: 88, width: UIScreen.main.bounds.width, height: height))
        self.addChildVC(textEditor)
        
        // Do any additional setup after loading the view.
    }
    
    func addChildVC(_ viewController: UIViewController) {
        
        self.addChild(viewController)
        self.didMove(toParent: viewController)
        let height = UIScreen.main.bounds.height - 88
//        viewController.view.frame = CGRect.init(x: 0, y: 88, width: UIScreen.main.bounds.width, height: height)
        self.view.addSubview(viewController.view)
        
    }
    
}

