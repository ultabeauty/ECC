//
//  TabBarController.swift
//  ECC
//
//  Created by Eby, Nicholas on 4/24/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        let controllers = self.viewControllers
        let map_vc = controllers![3] as UIViewController
        map_vc.view.backgroundColor = UIColor.white //arbitray
        
        let survey_vc = controllers![4] as UIViewController
        survey_vc.view.backgroundColor = UIColor.white //arbitray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
