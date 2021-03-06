//
//  IntroViewController.swift
//  ECC
//
//  Created by NEBY on 5/7/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController
{
    
    // MARK: - Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Navigation
        self.navigationItem.hidesBackButton = true

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.darkText]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.darkText]
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.darkText
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default

    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - User Actions
    @IBAction func done(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }

}
