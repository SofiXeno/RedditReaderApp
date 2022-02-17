//
//  Post.swift
//  RedditReaderAppXenofontova
//
//  Created by Софія Ксенофонтова  on 11.02.2022.
//

import Foundation

let utcKyiv = 2

struct Post {
    
    
    let username: String
    let domain: String
    let timePassed: Int
    let title: String
    let imageUrl: String
    let numOfComments: Int
    let rating : Double
    let saved: Bool
    
    init(json: PostDto){
        
        let childData = json.data.children[0].data
        let calendar = Calendar.current
        self.username = "@" + childData.username
        self.domain = childData.domain
        self.timePassed = calendar.component(.hour, from: Date(timeIntervalSince1970: childData.created)) - utcKyiv
        self.title = childData.title
        self.imageUrl = childData.preview?.images[0].source.url.replacingOccurrences(of: "amp;", with: "") ?? "https://uk.xn----7sbiewaowdbfdjyt.pp.ua/storage/big/3683862.jpg"
        self.numOfComments = childData.numOfComments
        self.rating = childData.ups + childData.downs
        self.saved = childData.saved
        
        
        
    }

    
}


