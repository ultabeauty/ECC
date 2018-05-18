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

        //Defaults
        accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        resourceImageView?.tintColor = UIColor.white
        resourceImageView?.layer.cornerRadius = resourceImageView.frame.size.height / 2
    }
    
    var resource: Resource?
    {
        didSet
        {
            //Image
            resourceImageView?.backgroundColor = UIColor.init(named: (resource?.color)!)
            resourceImageView?.image = UIImage.init(named: (resource?.imageURL)!)
            
            //Title
            titleLabel?.text = resource?.title
            
            //Source
            sourceLabel?.text = "Source: " + (resource?.source)!
            
            //Short Description
            descriptionLabel?.text = resource?.shortDescription
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool)
    {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted
        {
            resourceImageView?.backgroundColor = UIColor.darkGray
        }
        else
        {
            resourceImageView?.backgroundColor = UIColor.init(named: (resource?.color)!)
        }
    }
}
