//
//  SchoolSelectionView.swift
//  ECC
//
//  Created by Nicholas Eby on 4/24/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

@IBDesignable

class SchoolSelectionView: UIView
{
    
    @IBOutlet weak var checkMark: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    weak var delegate:SchoolSelectionViewDelegate?

    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        //Defaults
        checkMark?.isHidden = true
        checkMark?.tintColor = UIColor.init(named: "Selection_Green")
    }
    

    @IBInspectable var cornerRadius: CGFloat = 0
        {
        didSet
        {
            self.layer.cornerRadius = self.cornerRadius
            
            layer.shadowColor = UIColor.init(white: 0.90, alpha: 1.0).cgColor
            layer.shadowOffset = CGSize.init(width: 0, height: 16)
            layer.shadowRadius = 10.0
            layer.shadowOpacity = 1.0
            layer.borderColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0).cgColor
            layer.borderWidth = 1.0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.superview?.layoutIfNeeded()
        }, completion: { (finished) -> Void in
            // ....
        })
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        checkMark?.isHidden = false

        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        self.superview?.layoutIfNeeded()
        }, completion: { (finished) -> Void in
            // ....
        })
        
        delegate?.didSelectSchool(school: self.tag)
    }
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        checkMark?.isHidden = true
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            self.transform = CGAffineTransform.identity
            self.superview?.layoutIfNeeded()
        }, completion: { (finished) -> Void in
            // ....
        })
    }
}
protocol SchoolSelectionViewDelegate: AnyObject
{
    func didSelectSchool(school: Int)
}
