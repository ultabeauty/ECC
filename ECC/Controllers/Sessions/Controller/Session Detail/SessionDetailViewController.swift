//
//  SessionDetailViewController.swift
//  ECC
//
//  Created by Nicholas Eby on 3/24/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

class SessionDetailViewController: UIViewController
{
    // MARK: - Properties
    var session : Session?

    // MARK: - Outlets
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var longDescriptionLabel: UILabel!
    @IBOutlet weak var speakersView: UIView!
    @IBOutlet weak var takeawaysStackView: UIStackView!
    @IBOutlet weak var sessionImageView: UIImageView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        sessionImageView.layer.cornerRadius = sessionImageView.frame.size.height / 2
        
        
        categoryLabel?.text = session?.categoryToDisplayString()
        titleLabel?.text = session?.title
        dateLabel?.text = session?.dateToDisplayString()
        authorLabel?.text = session?.authorsToDisplayString()
        longDescriptionLabel?.text = session?.longDescription
        
        
        
        //Speakers
        addSpeakers()
        
        
        //Takeaways
        addTakeaways()
        
        
        
        
        
        
        
        
        

        
    }
    
    
    
    func addSpeakers()
    {
        //Clean up
        for v in speakersView.subviews
        {
            v.removeFromSuperview()
        }
        
        
        var count = 0
        
        for speaker in (session?.authors)!
        {
            let view = UIView.init(frame: CGRect.init(x: ((80 + 24) * count) + 16, y: 0, width: 80, height: 110))
            
            let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 80))
            imageView.image = UIImage.init(named: speaker.imageURL!)
            imageView.backgroundColor = UIColor.init(white: 0.96, alpha: 1.0)
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
            imageView.clipsToBounds = true
            view.addSubview(imageView)
            
            let textLabel = UILabel.init(frame: CGRect.init(x: 0, y: 84, width: 80, height: 26))
            textLabel.text = speaker.name
            textLabel.textAlignment = .center
            textLabel.numberOfLines = 0;
            textLabel.font = UIFont.systemFont(ofSize: 13)
            textLabel.textColor = UIColor.init(named: "Medium_Grey")
            view.addSubview(textLabel)

            speakersView.addSubview(view)
            
            count+=1
        }
    }
    
    
    func addTakeaways()
    {
        //Clean up
        let v = takeawaysStackView.arrangedSubviews[0]
        takeawaysStackView.removeArrangedSubview(v)
        v.removeFromSuperview()
        
        var count = 1
        
        for takeaway in (session?.takeaways)!
        {
            let textLabel = UILabel()
            //textLabel.trailingAnchor.constraint(equalToConstant: 16.0).isActive = true
            //textLabel.leadingAnchor.constraint(equalToConstant: 16.0).isActive = true
            let label = String(format: "%ld. %@", count, takeaway)
            
            textLabel.text = label
            textLabel.textAlignment = .left
            textLabel.numberOfLines = 0;
            textLabel.font = UIFont.systemFont(ofSize: 15)
            textLabel.textColor = UIColor.init(named: "Medium_Grey")
            
            
            
            
            //Stack View
            let stackView = UIStackView()
            
            stackView.axis  = UILayoutConstraintAxis.horizontal
            stackView.distribution = UIStackViewDistribution.equalSpacing
            stackView.alignment = UIStackViewAlignment.leading
            stackView.spacing = 32.0
            stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            stackView.isLayoutMarginsRelativeArrangement = true
            
            stackView.addArrangedSubview(textLabel)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            takeawaysStackView.addArrangedSubview(stackView)
            
            
            
            if(count % 2 == 0)
            {
                stackView.addBackground(color: UIColor.init(white: 1.0, alpha: 1.0))
            }
            else
            {
                stackView.addBackground(color: UIColor.init(white: 0.96, alpha: 1.0))
            }
            
            
            count+=1
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func done(_ sender: Any)
    {
        performSegue(withIdentifier: "UnwindSegue", sender: self)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
