//
//  SurveyViewController.swift
//  ECC
//
//  Created by Nicholas Eby on 5/3/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit
import WebKit

class SurveyViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var completedView: UIView!
    @IBOutlet weak var progressView: UIProgressView!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        print("survey: vdl")

        //Defaults
        webView.isHidden = true
        completedView.isHidden = true
        progressView.progress = 0
        progressView.isHidden = false

        initWebView()
    }

    
    // MARK: - Lifecycle
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - WebView
    func initWebView()
    {
        webView.navigationDelegate = self
        webView.load(URLRequest.init(url: URL.init(string: "https://www.surveymonkey.com/r/WCTNVDV")!))
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    
    // MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
    {
        print(navigationAction.request.url?.absoluteString ?? "")
        
        let path = navigationAction.request.url?.path
        
        if(navigationAction.request.url?.absoluteString == "https://www.surveymonkey.com/r/WCTNVDV")
        {
            webView.isHidden = false
            completedView.isHidden = true

            decisionHandler(WKNavigationActionPolicy.allow)
        }
        else if((path?.contains("survey-closed"))! || (path?.contains("survey-thanks"))! || (path?.contains("survey-taken"))!)
        {
            webView.isHidden = true
            completedView.isHidden = false
            
            decisionHandler(WKNavigationActionPolicy.cancel)
        }
        else
        {
            decisionHandler(WKNavigationActionPolicy.allow)
        }
    }

    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    {
        progressView.isHidden = true
        
        insertContentsOfCSSFile(into: webView)
    }
    
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    // MARK: - Utility
    func insertContentsOfCSSFile(into webView: WKWebView)
    {
        // This is more of a "hack" and is not guaranteed to work / also in a commercial grade app, we would customize this at the vendor level.
        
        let colour = "#636466"
        
        let css = ".survey-page .survey-page-header .survey-title-container { background-color : \(colour); } .sm-progressbar { background-color: \(colour); } .survey-page .question-number { color: \(colour); }"
        let js = "var style = document.createElement('style'); style.innerHTML = '\(css)'; document.head.appendChild(style);"
        
        webView.evaluateJavaScript(js, completionHandler: nil)
    }
}
