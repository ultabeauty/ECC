//
//  SessionCell.swift
//  ECC
//
//  Created by Nicholas Eby on 3/24/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

class SessionCell: UITableViewCell
{
    // MARK: - Properties
    @IBOutlet weak var sessionImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var badge: SessionBadgeView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!

    override func awakeFromNib()
    {
        super.awakeFromNib()

        //Create Circle
        //backgroundColor and clipsToBounds set in IB
        sessionImageView.layer.cornerRadius = sessionImageView.frame.size.height / 2

    }
}
