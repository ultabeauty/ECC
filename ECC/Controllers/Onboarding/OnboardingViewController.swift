//
//  OnboardingViewController.swift
//  ECC
//
//  Created by NEBY on 4/19/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, SchoolSelectionViewDelegate
{
    // MARK: - Outlets
    @IBOutlet weak var lakeView: SchoolSelectionView!
    @IBOutlet weak var micheleClark: SchoolSelectionView!

    
    // MARK: - Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Navigation
        self.navigationItem.hidesBackButton = true
        
        initSchools()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()

    }
    
    
    // MARK: - School Selection
    func initSchools()
    {
        //Set Delegates
        lakeView.delegate = self
        micheleClark.delegate = self
        
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
            UserDefaults.standard.set("LakeView", forKey: "kSchoolSelection")
        }
        else
        {
            UserDefaults.standard.set("MicheleClark", forKey: "kSchoolSelection")
        }
  
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
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    // MARK: - User Actions
    @IBAction func skip(_ sender:Any)
    {
        UserDefaults.standard.set("Other", forKey: "kSchoolSelection")

        self.dismiss(animated: true, completion: nil)
    }


}
