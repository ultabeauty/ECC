//
//  ResourceCell.swift
//  ECC
//
//  Created by Nicholas Eby on 3/28/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

class ResourceCell: UITableViewCell
{
    // MARK: - Properties
    @IBOutlet weak var resourceImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        // Initialization code
        resourceImageView.layer.cornerRadius = resourceImageView.frame.size.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
