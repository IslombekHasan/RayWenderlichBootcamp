//
//  AboutViewController.swift
//  ColorPikka
//
//  Created by Islombek Hasanov on 6/1/20.
//  Copyright © 2020 Islombek Khasanov. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.youtube.com/embed/dQw4w9WgXcQ")!
        let request = URLRequest(url: url)
        webView.load(request)
    }

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
