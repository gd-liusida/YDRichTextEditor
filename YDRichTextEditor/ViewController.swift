//
//  ViewController.swift
//  YDRichTextEditor
//
//  Created by Liu on 2020/4/28.
//  Copyright © 2020 Sida Liu. All rights reserved.
//

import UIKit

class ViewController: ZSSRichTextEditor {

    lazy var textEditor: ZSSRichTextEditor = {
        let textEditor: ZSSRichTextEditor = ZSSRichTextEditor.init()
        
        return textEditor
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vj_hideColumn = true
        vj_hideHTMLAbstract = true
//        self.addChildVC(textEditor)
        // Do any additional setup after loading the view.
    }
    
    func addChildVC(_ viewController: UIViewController) {
        self.addChild(viewController)
        self.didMove(toParent: viewController)
        self.view.addSubview(viewController.view)
        
        viewController.view.frame = CGRect.init(x: 0, y: 88, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 88)
    }
    
}

