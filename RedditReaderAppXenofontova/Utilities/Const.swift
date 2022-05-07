//
//  Const.swift
//  RedditReaderAppXenofontova
//
//  Created by Софія Ксенофонтова  on 18.02.2022.
//

import Foundation

struct Const{
    
    static let cellReuseId = "post_cell"
    static let segueFromPostsToOneDetailed = "seg_detailed"
    static let utcKyiv = 10
    static let defaultGlybaImageUrl = "50-0.jpg"
    static var after : String? = ""
    static let numOfPortion = 10
    static let fileName = "posts.json"
    
    //https://www.reddit.com/r/ios/top.json?limit=1&after=t3_sshfj2
    //https://www.reddit.com/r/ios/top.json?limit=7&after=t3_sshfj2
    static let baseUrl = "\(Url)/r/ios/top.json?limit=\(Const.numOfPortion)"
   
    static let Url = "https://www.reddit.com"

}
