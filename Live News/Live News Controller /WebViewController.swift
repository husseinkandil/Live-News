////
////  WebViewController.swift
////  Live News
////
////  Created by jaber on 18/02/2022.
////
//
//import UIKit
//import WebKit
//
//class WebViewController: UIViewController, WKNavigationDelegate {
//    var webView: WKWebView!
//    var news: NewsData?
//
//    override func loadView() {
//        super.loadView()
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        view = webView
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let url = URL(string: (news?.url))
//        webView.load(URLRequest(url: url))
//    }
//}
