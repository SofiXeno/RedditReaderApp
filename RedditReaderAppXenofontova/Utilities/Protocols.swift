//
//  Protocols.swift
//  RedditReaderAppXenofontova
//
//  Created by Софія Ксенофонтова  on 17.04.2022.
//

import Foundation
import UIKit


protocol PostTableViewCellDelegate: AnyObject {
    func sharePost(url: String)
    func savePost(post: inout Post, bookmark: UIButton)
    
}

