//
//  Profile.swift
//  ECC
//
//  Created by Nicholas Eby on 3/27/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

class Profiles: Codable
{
    // MARK: - Properties
    let profiles: [Profile]
    
    // MARK: - Initializers
    init(profiles: [Profile])
    {
        self.profiles = profiles;
    }
    
}

class Profile: Codable
{
    // MARK: - Properties
    let name: String
    let title: String
    let shortDescription: String?
    let twitter: String?
    let imageURL: String?
    let favorite: String?
    
    // MARK: - Initializers
    init(name: String, title: String, shortDescription: String, twitter:String, imageURL:String, favorite:String)
    {
        self.name = name
        self.title = title
        self.shortDescription = shortDescription
        self.twitter = twitter
        self.imageURL = imageURL
        self.favorite = favorite
    }
}
