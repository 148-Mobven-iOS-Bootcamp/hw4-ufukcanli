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
    @IBOutlet weak var toolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureActivityIndicator()
        configureWebView()
        loadWebView()
    }
    
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        if keyPath == "loading" {
            if webView.isLoading {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }
    
    @IBAction func toolbarButtonDidTap(_ sender: UIBarButtonItem) {
        switch sender.title {
        case "back":
            webView.goBack()
        case "forward":
            webView.goForward()
        case "refresh":
            webView.reload()
        case "safari":
            openWithSafari()
        default: return
        }
    }    
}

private extension WebViewController {
    
    func openWithSafari() {
        if let url = webView.url {
            UIApplication.shared.open(url)
        }
    }
    
    func loadWebView() {
        let urlString = "https://ufukcanli.com"
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    func configureWebView() {
        webView.addObserver(
            self,
            forKeyPath: #keyPath(WKWebView.isLoading),
            options: .new,
            context: nil
        )
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
