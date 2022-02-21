//
//  Post.swift
//  RedditReaderAppXenofontova
//
//  Created by Софія Ксенофонтова  on 11.02.2022.
//

import Foundation



struct Post {
    
    
    let username: String
    let domain: String
    let timePassed: String
    let title: String
    let imageUrl: String
    let numOfComments: Int
    let rating : Double
    let saved: Bool
    let subredditNamePrefixed: String
    
    
    
    init(){
        
        self.username = ""
        self.domain = ""
        self.timePassed = ""
        self.title = ""
        self.imageUrl = "https://uk.xn----7sbiewaowdbfdjyt.pp.ua/storage/big/3683862.jpg"
        self.numOfComments = 0
        self.rating = 0
        self.saved = true
        self.subredditNamePrefixed = ""
        
        
    }
    
    init(childData: ChildData){
        

        let calendar = Calendar.current
        self.username = "@" + childData.username
        self.domain = childData.domain
        self.timePassed = Utilities.calcDate(created: childData.created)
        self.title = childData.title
        self.imageUrl = childData.preview?.images[0].source.url.replacingOccurrences(of: "amp;", with: "") ?? Const.defaultGlybaImageUrl
        self.numOfComments = childData.numOfComments
        self.rating = childData.ups + childData.downs
        self.saved = childData.saved
        self.subredditNamePrefixed = childData.subredditNamePrefixed
        
        
        
    }

    
   
    
    
}


