//
//  Utilities.swift
//  RedditReaderAppXenofontova
//
//  Created by Софія Ксенофонтова  on 19.02.2022.
//

import Foundation
import UIKit
import ObjectiveC

class Utilities{
    
    static let shared = Utilities()
    private init() {}
    
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
    
    
    static func savePostAction(post: inout Post, bookmark: UIButton) {

        post.saved.toggle()
      
        if post.saved {
            bookmark.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            Utilities.savePost(post: post)
        } else {
            bookmark.setImage(UIImage(systemName: "bookmark"), for: .normal)
            Utilities.deletePost(post: post)
        }
    }
    


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
    
    
    
    
    
    static func drawBookmark(in image: UIImageView, post: Post) -> UIView {

        let margin: CGFloat = 150
        
        let view = UIView()
        
        // create a new path
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: image.frame.midX - margin/2, y: image.frame.midY - image.frame.minY - margin))
        path.addLine(to: CGPoint(x: image.frame.midX + margin/2, y: image.frame.midY - image.frame.minY - margin))
        path.addLine(to: CGPoint(x: image.frame.midX + margin/2, y: image.frame.midY - image.frame.minY + margin))
        path.addLine(to: CGPoint(x: image.frame.midX, y: image.frame.midY - image.frame.minY + margin / 3))
        path.addLine(to: CGPoint(x: image.frame.midX - margin/2, y: image.frame.midY - image.frame.minY + margin))
        path.addLine(to: CGPoint(x: image.frame.midX - margin/2, y: image.frame.midY - image.frame.minY - margin))
        path.close()
        
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        
        shapeLayer.fillColor = post.saved ? UIColor.systemOrange.cgColor : UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.systemOrange.cgColor
        shapeLayer.lineWidth = 4
 
        shapeLayer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        
        view.layer.addSublayer(shapeLayer)
        view.isHidden = true
   
        return view
    
    }
    
    
    
//    @objc static func bookmarkAnimation(image: UIImageView, post: Post, animatedBookmark: UnsafeMutablePointer<UIView>, vc: UIViewController){
//
//        animatedBookmark = Utilities.drawBookmark(in: image, post: post)
//
//        image.addSubview(animatedBookmark)
//
//        DispatchQueue.main.asyncAfter(deadline: .now()) {
//            UIView.transition(
//                with: vc.view,
//                duration: 1.5,
//                options: .transitionCrossDissolve
//            ) {
//                animatedBookmark.isHidden = false
//
//                DispatchQueue.main.asyncAfter(deadline: .now()) {
//                    UIView.transition(
//                        with: vc.view,
//                        duration: 1.5,
//                        options: .transitionCrossDissolve
//                    ) {
//                        animatedBookmark.isHidden = true
//
//                    }
//
//                }
//            }
//
//        }
//
//  }
    
    
}


    
    



