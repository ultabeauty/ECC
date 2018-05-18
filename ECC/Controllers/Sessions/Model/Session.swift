//
//  Session.swift
//  ECC
//
//  Created by Nicholas Eby on 3/24/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

enum CardType: Int
{
    case video
    case session
}

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
    let type: Int?
    let title: String?
    let start_timestamp: String?
    let end_timestamp: String?
    let category: String?
    let longDescription: String?
    let authors: [Profile]?
    let videoURL : String?
    let smallImageURL: String?
    let largeImageURL: String?
    let takeaways: [String]?
    let altText: String?
    let survey: Bool?
    
    // MARK: - Initializers
    init(type: Int, title: String, start_timestamp: String, end_timestamp: String, category: String, longDescription: String, authors: [Profile], smallImageURL:String, largeImageURL:String, videoURL:String, takeaways:[String], altText:String, survey:Bool)
    {
        self.type = type
        self.title = title
        self.start_timestamp = start_timestamp
        self.end_timestamp = end_timestamp
        self.category = category
        self.longDescription = longDescription
        self.authors = authors
        self.smallImageURL = smallImageURL
        self.largeImageURL = largeImageURL
        self.videoURL = videoURL
        self.takeaways = takeaways
        self.altText = altText
        self.survey = survey
    }
    
    public func dateToDisplayString() -> String
    {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.calendar = Calendar(identifier: .iso8601)
        dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mma"

        let start_date: Date? = dateFormatterGet.date(from: start_timestamp!)
        let end_date: Date? = dateFormatterGet.date(from: end_timestamp!)

        let start_formatter =  dateFormatter.string(from: start_date!)
        let end_formatter =  dateFormatter.string(from: end_date!)

        return start_formatter + " - " + end_formatter
    }

}

