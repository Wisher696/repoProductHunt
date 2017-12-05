//
//  WebViewViewController.swift
//  ProductHuntClient
//
//  Created by Oleg Aleutdinov on 04.12.2017.
//  Copyright © 2017 Oleg Aleutdinov. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController {
    var redirectURL: String = ""
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: URL(string: redirectURL)!))
    }
}
