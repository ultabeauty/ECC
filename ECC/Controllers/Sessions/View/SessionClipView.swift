//
//  SessionCell.swift
//  ECC
//
//  Created by Nicholas Eby on 3/24/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

@IBDesignable

class SessionClipView: UIView
{
    // MARK: - Properties

    override func awakeFromNib()
    {
        super.awakeFromNib()

        clipsToBounds = true

    }
    
    @IBInspectable var cornerRadius: CGFloat = 0
        {
        didSet
        {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
}
