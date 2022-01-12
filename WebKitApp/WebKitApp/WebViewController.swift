//
//  WebViewController.swift
//  WebKitApp
//
//  Created by Ufuk Canlı on 12.01.2022.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWebView()
        loadWebView()
    }
}

private extension WebViewController {
    
    func loadWebView() {
        let urlString = "https://ufukcanli.com"
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    func configureWebView() {
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
}

extension WebViewController: WKUIDelegate {}

extension WebViewController: WKNavigationDelegate {}
