//
//  Session.swift
//  ECC
//
//  Created by Nicholas Eby on 3/24/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

class Sessions: Codable
{
    // MARK: - Properties
    let sessions: [Session]
    
    // MARK: - Initializers
    init(sessions: [Session])
    {
        self.sessions = sessions;
    }
}

class Session: Codable
{
    // MARK: - Properties
    let title: String
    let timestamp: String
    let category: Int
    let shortDescription: String
    let longDescription: String
    let authors: [Profile]
    let imageURL: String?
    let takeaways: [String]?
    
    // MARK: - Initializers
    init(title: String, timestamp: String, category: Int, shortDescription: String, longDescription: String, authors: [Profile], imageURL:String, takeaways:[String])
    {
        self.title = title
        self.timestamp = timestamp
        self.category = category
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.authors = authors
        self.imageURL = imageURL
        self.takeaways = takeaways
    }
    
    public func dateToDisplayString() -> String
    {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.calendar = Calendar(identifier: .iso8601)
        dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        let date: Date? = dateFormatterGet.date(from: timestamp)
        
        return dateFormatter.string(from: date!)
    }
    
    func authorsToDisplayString() -> String
    {
        if(self.authors.count > 0)
        {
            var names = "Speakers: "
            
            var count = 0
            
            for author in self.authors
            {
                names += author.name
                
                count += 1
                
                if(count < self.authors.count)
                {
                    names += ", "
                }
            }
            
            return names
        }
        else
        {
            return ""
        }
    }
    
    
    func categoryToDisplayString() -> String
    {
        if(self.category == 0)
        {
            return "General"
        }
        else if(self.category == 1)
        {
            return "Business"
        }
        else if(self.category == 2)
        {
            return "UX"
        }
        else if(self.category == 3)
        {
            return "UI"
        }
        else if(self.category == 4)
        {
            return "QA"
        }
        else if(self.category == 5)
        {
            return "Dev"
        }
        else if(self.category == 9)
        {
            return "Break"
        }
        return "General"
    }
    
    
    
    
    
    
}

