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

    override func viewDidLoad()
    {
        super.viewDidLoad()

        print("survey: vdl")
        
        webView.isHidden = true
        completedView.isHidden = true
        
        // Do any additional setup after loading the view.
        initWebView()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initWebView()
    {
        webView.navigationDelegate = self
        webView.load(URLRequest.init(url: URL.init(string: "https://www.surveymonkey.com/r/WCTNVDV")!))
    }
    
    
    
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


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
