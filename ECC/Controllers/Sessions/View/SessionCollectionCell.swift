//
//  SessionCell.swift
//  ECC
//
//  Created by Nicholas Eby on 3/24/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

@IBDesignable

class SessionCollectionCell: UICollectionViewCell
{
    // MARK: - Properties
    @IBOutlet weak var sessionImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var sessionImageViewWidth: NSLayoutConstraint!

    
    override func awakeFromNib()
    {
        super.awakeFromNib()

        //Create Circle
        sessionImageView?.layer.cornerRadius = sessionImageView.frame.size.height / 2
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
            layer.borderColor = UIColor.init(white: 0.92, alpha: 1.0).cgColor
            layer.borderWidth = 1.0
        }
    }
    
    
    
    
    var session: Session?
    {
        didSet
        {
            if(session?.type == 0) //video card
            {
                //Image
                sessionImageView?.image = UIImage.init(named: (session?.smallImageURL!)!)
            }
            else
            {
                //Image
                if(session?.smallImageURL != nil)
                {
                    sessionImageViewWidth?.constant = 96
                    sessionImageView?.image = UIImage.init(named: (session?.smallImageURL!)!)
                }
                else
                {
                    sessionImageViewWidth?.constant = 0
                    sessionImageView?.image = nil
                }
                
                //Category
                categoryLabel?.text = session?.category
                
                //Title
                titleLabel?.text = session?.title
                
                //Date
                if(session?.start_timestamp != nil)
                {
                    dateLabel?.text = session?.dateToDisplayString()
                }
                else
                {
                    dateLabel?.text = session?.altText
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override var isHighlighted: Bool
        {
            didSet
            {
                if(self.isHighlighted)
                {
                    UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                        self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        self.superview?.layoutIfNeeded()
                    }, completion: { (finished) -> Void in
                        // ....
                    })
                }
                else
                {
                    UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                        self.transform = CGAffineTransform.identity
                        self.superview?.layoutIfNeeded()
                    }, completion: { (finished) -> Void in
                        // ....
                    })
                }
            }
    }
    
    
}
