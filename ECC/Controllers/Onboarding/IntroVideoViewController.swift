//
//  IntroViewController.swift
//  ECC
//
//  Created by Eby, Nicholas on 5/10/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit
import WebKit

class IntroVideoViewController: UIViewController, WKScriptMessageHandler
{
    
    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        webView.isOpaque = false;
        webView.backgroundColor = UIColor.black
        self.webView.scrollView.isScrollEnabled = false
        
    }

    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        
        do
        {
            guard let filePath = Bundle.main.path(forResource: "video", ofType: "html")
                else
            {
                    // File Error
                    print ("File reading error")
                    return
            }
            
            var contents =  try String(contentsOfFile: filePath, encoding: .utf8)
            
            //
            contents = contents.replacingOccurrences(of: "%%height%%", with: String(format: "%f", webView.frame.size.height-44))
            contents = contents.replacingOccurrences(of: "%%width%%", with: String(format: "%f", webView.frame.size.width))

            let baseUrl = URL(fileURLWithPath: filePath)
            
            webView.loadHTMLString(contents as String, baseURL: baseUrl)
        }
        catch
        {
            print ("File HTML error")
        }
        
        
        let contentController = WKUserContentController()
        contentController.add(self, name: "callbackHandler")
        
        let configuration = webView.configuration
        configuration.userContentController = contentController
        
        webView.configuration.userContentController.add(self, name: "callbackHandler")

        
        print(webView.configuration.userContentController)
        
    }

    
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        
        webView.load(URLRequest(url: URL(string:"about:blank")!))
        
    }
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage)
    {
        if (message.name == "callbackHandler"){
            print("\(message.body)")
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()

    }

}

