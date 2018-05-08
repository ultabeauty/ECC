//
//  Resource.swift
//  ECC
//
//  Created by Nicholas Eby on 3/27/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

class Resources: Codable
{
    // MARK: - Properties
    let resources: [Resource]
    
    // MARK: - Initializers
    init(resources: [Resource])
    {
        self.resources = resources;
    }
}

class Resource: Codable
{
    // MARK: - Properties
    let title: String
    let shortDescription: String
    let link: String
    let source: String
    let imageURL: String
    let type : Int
    
    // MARK: - Initializers
    init(title: String, shortDescription: String, link: String, source: String, imageURL:String, type:Int)
    {
        self.title = title
        self.shortDescription = shortDescription
        self.link = link
        self.source = source
        self.imageURL = imageURL
        self.type = type
    }
}
