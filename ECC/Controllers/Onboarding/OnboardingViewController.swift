//
//  OnboardingViewController.swift
//  ECC
//
//  Created by Eby, Nicholas on 4/19/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, SchoolSelectionViewDelegate
{
    @IBOutlet weak var lakeView: SchoolSelectionView!
    @IBOutlet weak var micheleClark: SchoolSelectionView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Override the Global colors
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.init(named: "Dark_Color") ?? UIColor.black]
        navigationController?.navigationBar.barStyle = UIBarStyle.default
        
        initSchools()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()

    }
    
    
    
    func initSchools()
    {
        //Set Delegates
        lakeView.delegate = self
        micheleClark.delegate = self
        
        //Update Checkmarks
        if(UserDefaults.standard.string(forKey: "kSchoolSelection") != nil)
        {
            let school = UserDefaults.standard.string(forKey: "kSchoolSelection")
            
            if(school == "LakeView")
            {
                lakeView.checkMark.isHidden = false
            }
            else
            {
                micheleClark.checkMark.isHidden = false
            }
        }
    }
    
    
    
    func didSelectSchool(school: Int)
    {
        if(school == 0)
        {
            print("school 1")
            micheleClark.checkMark.isHidden = true

            UINavigationBar.appearance().barTintColor = UIColor.init(named: "Lake_View")
            UITabBar.appearance().tintColor = UIColor.init(named: "Lake_View")

            UserDefaults.standard.set("LakeView", forKey: "kSchoolSelection")
        }
        else
        {
            print("school 2")
            lakeView.checkMark.isHidden = true

            UINavigationBar.appearance().barTintColor = UIColor.init(named: "Michele_Clark")
            UITabBar.appearance().tintColor = UIColor.init(named: "Michele_Clark")
            
            UserDefaults.standard.set("MicheleClark", forKey: "kSchoolSelection")
        }
        
        //Global
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        changeIcon(school: school)
    }
    
    
    
    func changeIcon(school:NSInteger)
    {
        if UIApplication.shared.supportsAlternateIcons
        {
            let schoolName = (school == 0) ? "LakeView" : "MicheleClark"
            
            UIApplication.shared.setAlternateIconName(schoolName)
            {
                error in
                
                if let error = error
                {
                    print(error.localizedDescription)
                }
                else
                {
                    print("Done!")
                }
                
                //self.dismiss(animated: true, completion: nil)
                
                self.performSegue(withIdentifier: "IntroSegue", sender: self)
            }
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
