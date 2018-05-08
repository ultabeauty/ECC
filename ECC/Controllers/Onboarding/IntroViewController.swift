//
//  IntroViewController.swift
//  ECC
//
//  Created by Eby, Nicholas on 5/7/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.init(named: "Dark_Grey")

        self.navigationItem.hidesBackButton = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func done(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
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
