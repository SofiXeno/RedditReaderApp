//
//  Utilities.swift
//  RedditReaderAppXenofontova
//
//  Created by Софія Ксенофонтова  on 19.02.2022.
//

import Foundation
import UIKit

struct Utilities{
    
    static func drawBookmark(bookmark: inout UIButton, post: Post) -> UIButton {
        
        post.saved ? bookmark.setImage(UIImage(systemName: "bookmark.fill"), for: .normal) : bookmark.setImage(UIImage(systemName: "bookmark"), for: .normal)
        
        return bookmark
    }
    
    
    static func calcDate(created: Double) -> String {
        
        var resNum : Int
        var res: String = ""
        
        let calendar = Calendar.current
        let hoursViaKyiv = (calendar.component(.hour, from: Date(timeIntervalSince1970: created)) - Const.utcKyiv)
        
        
        if hoursViaKyiv <= 0 {
            
            resNum =  calendar.component(.minute, from: Date(timeIntervalSince1970: created))
            res.append(String(resNum))
            res.append(" m.")
        }
        else{
            
            resNum = hoursViaKyiv
            res.append(String(resNum))
            res.append(" h.")
        }
        
        
        return res
        
    }
    
    
    static func sharePost(url: String, vc: UIViewController){
        
        if let postUrl = URL(string: "\(Const.Url)\(url)") {
            let objectsToShare: [Any] = [postUrl]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            vc.present(activityVC, animated: true, completion: nil)
            
        }
        
    }
//    
//    static func savePostAction(post: inout Post, bookmark: UIButton) {
//
//        if !post.saved {
//            bookmark.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
//            Utilities.savePost(post: &post)
//        } else {
//            Utilities.deletePost(post: &post)
//            bookmark.setImage(UIImage(systemName: "bookmark"), for: .normal)
//        }
//        print("Save state CELL    \(post.saved)")
//
//        post.saved.toggle()
//
//    }
    


    static func savePost(post: Post){
        if !PostRepositorySingleton.shared.savedPosts.contains(post) {
            PostRepositorySingleton.shared.savedPosts.append(post)
       
            Utilities.updatePostIsSavedValue(post: post, value: true)

        }
    }
    
    
    static func deletePost(post: Post){
        
            for (index, element) in PostRepositorySingleton.shared.savedPosts.enumerated() {
                if (post.id == element.id) {
        
                    PostRepositorySingleton.shared.savedPosts.remove(at: index)
                }
            }

        Utilities.updatePostIsSavedValue(post: post, value: false)

    }
    
    
    static func updatePostIsSavedValue(post: Post, value: Bool){
            PostRepositorySingleton.shared.allPosts = PostRepositorySingleton.shared.allPosts.map { elem in

                var tempPost = elem

                if(tempPost.id == post.id) {
                    tempPost.saved = value
                }
                return tempPost
            }
            
            PostRepositorySingleton.shared.currentPosts = PostRepositorySingleton.shared.currentPosts.map { elem in
                
                var tempPost = elem
                
                if(tempPost.id == post.id) {
                    tempPost.saved = value
                }
                return tempPost
            }
    
            }
    
    
    
    
        }
    
    



