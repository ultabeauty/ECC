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
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var favoriteAppLabel: UILabel!

    override func awakeFromNib()
    {
        super.awakeFromNib()

        //Create Circle
        //backgroundColor and clipsToBounds set in IB
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
