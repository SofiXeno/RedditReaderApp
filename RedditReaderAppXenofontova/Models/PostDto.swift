//
//  PostDto.swift
//  RedditReaderAppXenofontova
//
//  Created by Софія Ксенофонтова  on 10.02.2022.
//

import Foundation


struct PostDto: Decodable {
    
    let data: Data

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try values.decode(Data.self, forKey: .data)
       
    }
    
      enum CodingKeys: String, CodingKey {
          case data = "data"
      }
}


struct Data: Decodable{
    
    let children: [Child]
    let after : String?
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.children = try values.decode([Child].self, forKey: .children)
        self.after = try values.decode(String?.self, forKey: .after)
       
    }
    
      enum CodingKeys: String, CodingKey {
          case children = "children"
          case after = "after"
      }
    
    
}


struct Child: Decodable {
    
    
    let data : ChildData

    
 
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try values.decode(ChildData.self, forKey: .data)
       
    }
    
      enum CodingKeys: String, CodingKey {
          case data = "data"
      }
    
}

struct ChildData: Decodable {
    
    let username: String
    let domain: String
    let created: Double
    let title: String
    let numOfComments: Int
    let ups : Int
    let downs: Int
    let saved: Bool
    let subredditNamePrefixed: String
    let link: String
    let preview: Preview?
    let id: String
    
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try values.decode(String.self, forKey: .username)
        self.domain = try values.decode(String.self, forKey: .domain)
        self.created = try values.decode(Double.self, forKey: .timePassed)
        self.title = try values.decode(String.self, forKey: .title)
        self.numOfComments = try values.decode(Int.self, forKey: .numOfComments)
        self.ups = try values.decode(Int.self, forKey: .ups)
        self.downs = try values.decode(Int.self, forKey: .downs)
        self.saved = try values.decode(Bool.self, forKey: .saved)
        self.subredditNamePrefixed = try values.decode(String.self, forKey: .subredditNamePrefixed)
        self.preview = try values.decodeIfPresent(Preview.self, forKey: .preview)
        self.link = try values.decode(String.self, forKey: .link)
        self.id = try values.decode(String.self, forKey: .id)
            
        
    }
    
    
      enum CodingKeys: String, CodingKey {
          case username = "author"
          case domain = "domain"
          case timePassed = "created"
          case title = "title"
          case numOfComments = "num_comments"
          case ups = "ups"
          case downs = "downs"
          case saved = "saved"
          
          case preview = "preview"
          case subredditNamePrefixed = "subreddit_name_prefixed"
          case link = "permalink"
          case id = "id"
          
      }

    
}



struct Preview: Decodable{
 
    let images: [Image]
 
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.images = try values.decode([Image].self, forKey: .images)
       
    }
    
      enum CodingKeys: String, CodingKey {
          case images = "images"
      }
    
    
    
}

struct Image: Decodable{

    let source: Source

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.source = try values.decode(Source.self, forKey: .source)
       
    }
    
      enum CodingKeys: String, CodingKey {
          case source = "source"
      }
    
    
    
}
    
    
struct Source: Decodable{
    
    let url: String

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try values.decode(String.self, forKey: .url)
       
    }
    
      enum CodingKeys: String, CodingKey {
          case url = "url"
      }
    
    
    
    
}

