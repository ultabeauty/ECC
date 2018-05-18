//
//  ProfileCell.swift
//  ECC
//
//  Created by Nicholas Eby on 3/27/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell
{
    // MARK: - Properties
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var twitterViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var twitterIcon: UIImageView!
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var favoriteAppLabel: UILabel!

    override func awakeFromNib()
    {
        super.awakeFromNib()

        //Defaults
        profileImageView?.layer.cornerRadius = profileImageView.frame.size.height / 2
        twitterIcon?.tintColor = UIColor(red:0.16, green:0.66, blue:0.88, alpha:1.0)
    }
    
    var profile: Profile?
    {
        didSet
        {
            //Image
            profileImageView?.image = UIImage.init(named: (profile?.imageURL!)!)
            
            //Name
            nameLabel?.text = profile?.name
            
            //Twitter (Optional)
            twitterViewHeightConstraint.constant = profile?.twitter == nil ? 0 : 22
            twitterLabel?.text = profile?.twitter
            
            //Title
            titleLabel?.text = profile?.title
            
            //Short Description
            descriptionLabel?.text = profile?.shortDescription
            
            //Favorite App
            favoriteAppLabel?.text = "Favorite App: " +  (profile?.favorite!)!
        }
    }

}
