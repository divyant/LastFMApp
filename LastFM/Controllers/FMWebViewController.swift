//
//  FMWebViewController.swift
//  LastFM
//
//  Created by Divyant Srivastava on 22/12/19.
//  Copyright © 2019 Divyant Srivastava. All rights reserved.
//

import UIKit
import WebKit

/// View Controller to handle web view
class FMWebViewController: UIViewController {

    /// webView Object to load album url
    @IBOutlet weak var webView: WKWebView!

    /// web view url string
    var webViewUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: webViewUrl ?? "https://www.last.fm/home")!
        //Load webview with url
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
