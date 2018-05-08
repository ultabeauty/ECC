//
//  SessionBackgroundView.swift
//  ECC
//
//  Created by Nicholas Eby on 3/26/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

@IBDesignable

class SessionBadgeView: UIView
{
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!

    @IBInspectable var cornerRadius: CGFloat = 0
    {
        didSet
        {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable var badgeType: NSInteger = 0
    {
        didSet
        {
            if(self.badgeType == 0)
            {
                self.titleLabel?.text = "UI"
                self.backgroundColor = UIColor.red
            }
            else if(self.badgeType == 1)
            {
                self.titleLabel?.text = "UX"
                self.backgroundColor = UIColor.blue
            }
            else if(self.badgeType == 2)
            {
                self.titleLabel?.text = "DEV"
                self.backgroundColor = UIColor.green
            }
            else if(self.badgeType == 3)
            {
                self.titleLabel?.text = "DEV"
                self.backgroundColor = UIColor.orange
            }            
        }
    }
}
