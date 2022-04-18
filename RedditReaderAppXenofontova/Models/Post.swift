//
//  Post.swift
//  RedditReaderAppXenofontova
//
//  Created by Софія Ксенофонтова  on 11.02.2022.
//

import Foundation



struct Post :  Codable, Equatable {

    
    
    
    var username: String
    var domain: String
    var timePassed: String
    var title: String
    var imageUrl: String
    var numOfComments: Int
    var rating : Double
    var saved: Bool
    var subredditNamePrefixed: String
    var postUrl: String
    var id: String
    
    
    
    init(){
        
        self.username = ""
        self.domain = ""
        self.timePassed = ""
        self.title = ""
        self.imageUrl = "https://uk.xn----7sbiewaowdbfdjyt.pp.ua/storage/big/3683862.jpg"
        self.numOfComments = 0
        self.rating = 0
        self.saved = false
        self.subredditNamePrefixed = ""
        self.postUrl = ""
        self.id = ""
        
    }
    
    init(childData: ChildData){
        

        //let calendar = Calendar.current
        self.username = "@" + childData.username
        self.domain = childData.domain
        self.timePassed = Utilities.calcDate(created: childData.created)
        self.title = childData.title
        self.imageUrl = childData.preview?.images[0].source.url.replacingOccurrences(of: "amp;", with: "") ?? Const.defaultGlybaImageUrl
        self.numOfComments = childData.numOfComments
        self.rating = childData.ups + childData.downs
        self.saved = childData.saved
        self.subredditNamePrefixed = childData.subredditNamePrefixed
        self.postUrl = childData.link
        self.id = childData.id
        
        
    }

    
    enum CodingKeys: String, CodingKey  {
        case username = "username"
        case domain = "domain"
        case timePassed = "timePassed"
        case title = "title"
        case imageUrl = "imageUrl"
        case numOfComments = "numOfComments"
        case rating = "rating"
        case saved = "saved"
        case subredditNamePrefixed = "subredditNamePrefixed"
        case postUrl = "postUrl"
        case id = "id"
        }
        
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(username, forKey: .username)
        try container.encode(domain, forKey: .domain)
        try container.encode(timePassed, forKey: .timePassed)
        try container.encode(title, forKey: .title)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(numOfComments, forKey: .numOfComments)
        try container.encode(rating, forKey: .rating)
        try container.encode(saved, forKey: .saved)
        try container.encode(subredditNamePrefixed, forKey: .subredditNamePrefixed)
        try container.encode(postUrl, forKey: .postUrl)
        try container.encode(id, forKey: .id)
            
        }

    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try values.decode(String.self, forKey: .username)
        self.domain = try values.decode(String.self, forKey: .domain)
        self.timePassed = try values.decode(String.self, forKey: .timePassed)
        self.title = try values.decode(String.self, forKey: .title)
        self.imageUrl = try values.decode(String.self, forKey: .imageUrl)
        self.numOfComments = try values.decode(Int.self, forKey: .numOfComments)
        self.rating = try values.decode(Double.self, forKey: .rating)
        self.saved = try values.decode(Bool.self, forKey: .saved)
        self.subredditNamePrefixed = try values.decode(String.self, forKey: .subredditNamePrefixed)
        self.postUrl = try values.decode(String.self, forKey: .postUrl)
        self.id = try values.decode(String.self, forKey: .id)
        
    }
    
    
    static func ==(lhs: Post, rhs: Post) -> Bool {
        return (lhs.username == rhs.username) && (lhs.domain == rhs.domain) && (lhs.timePassed == rhs.timePassed) && (lhs.title == rhs.title) && (lhs.imageUrl == rhs.imageUrl) && (lhs.numOfComments == rhs.numOfComments) && (lhs.rating == rhs.rating) && (lhs.saved == rhs.saved) && (lhs.subredditNamePrefixed == rhs.subredditNamePrefixed) && (lhs.postUrl == rhs.postUrl) && (lhs.id == rhs.id) 
        }
    
    
    
    
    }
    
    

    



