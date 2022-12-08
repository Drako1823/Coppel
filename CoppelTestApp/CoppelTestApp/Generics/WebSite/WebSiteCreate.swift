//
//  WebSiteCreate.swift
//  coppelTestApp
//
//  Created by El Reymon . on 08/12/22.
//

import UIKit
import WebKit

class WebSiteViewController: UIViewController {
    
    // MARK: - Properties
    var webView: WKWebView!
    var urlLoad:String?
    var strTitle:String?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createBtnClose()
        createTitle()
        createWebView()
        loadUrl()
    }
    
    // MARK: - Functions
    func createWebView(){
        webView = WKWebView(frame: CGRect(x: 0, y: 50, width: self.view.frame.size.width, height: self.view.frame.size.height))
        webView.navigationDelegate = self
        self.view.addSubview(webView)
    }
    
    func createBtnClose(){
        let btnClose = UIButton(frame: CGRect(x: self.view.frame.size.width - 45, y: 10, width: 40, height: 40))
        btnClose.setImage(UIImage(named: "imgClose"), for: .normal)
        btnClose.addTarget(self, action: #selector(self.tapClose(_:)), for: .touchUpInside)
        self.view.addSubview(btnClose)
        self.view.backgroundColor = .white
    }
    
    func createTitle(){
        let lblTitle = UILabel(frame: CGRect(x:self.view.frame.size.width / 2 - 50, y: 10, width: 100 , height: 30 ))
        lblTitle.text = strTitle
        lblTitle.textColor = .black
        lblTitle.textAlignment = .center
        self.view.addSubview(lblTitle)
    }
    
    func loadUrl() {
        if let strUrl = urlLoad,let url = URL(string: strUrl){
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
    
    // MARK: - Actions
    @objc func tapClose(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - Extension WebView
extension WebSiteViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        ProgressView.showHUDAddedToWindow()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ProgressView.hideHUDAddedToWindow()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        ProgressView.hideHUDAddedToWindow()
    }
}
