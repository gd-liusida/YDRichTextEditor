//
//  ViewController.swift
//  YDRichTextEditor
//
//  Created by Liu on 2020/4/28.
//  Copyright © 2020 Sida Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var editorView: YDRichTextEditor!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.editorView.setHTML("这是一个测试")
        // Do any additional setup after loading the view.
    }

    @IBAction func didOnBoldTapped(_ sender: Any) {
        self.editorView.setBold()
    }
    
    @IBAction func didOnItalicTapped(_ sender: Any) {
        self.editorView.setItalic()
    }
    
}

