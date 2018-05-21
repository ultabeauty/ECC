//
//  UIStackView+BackgroundColor.swift
//  ECC
//
//  Created by NEBY on 5/7/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

extension UIStackView
{
    func addBackground(color: UIColor)
    {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
    
}
