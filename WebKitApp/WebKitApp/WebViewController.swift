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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureActivityIndicator()
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
    
    func configureActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.color = .darkGray
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
}

extension WebViewController: WKUIDelegate {}

extension WebViewController: WKNavigationDelegate {}
