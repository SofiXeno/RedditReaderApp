//
//  ViewController.swift
//  RedditReaderAppXenofontova
//
//  Created by Софія Ксенофонтова  on 10.02.2022.
//

import UIKit
import SDWebImage


class PostDetailsViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var timePassedLabel: UILabel!
    @IBOutlet private weak var domainLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var bookmark: UIButton!
    
    // MARK: IBActions
    @IBAction private func share(_ sender: Any) {
        Utilities.sharePost(url: self.post.postUrl, vc: self)
        
        
        }
        
    @IBAction private func savePostAction(_ sender: Any) {

//        Utilities.savePostActionDetailedView(post: &self.post, bookmark: self.bookmark)
//
 
        post.saved.toggle()
        
        if post.saved {
            bookmark.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            Utilities.savePost(post: post)
        } else {
            bookmark.setImage(UIImage(systemName: "bookmark"), for: .normal)
            Utilities.deletePost(post: post) }
        
        
        if self.state {
            PostRepositorySingleton.shared.currentPosts = PostRepositorySingleton.shared.savedPosts
            }
        
        self.delegateTable?.reloadData()
        
        }
   
        
        
        //print("AAAAAAA   \(PostRepositorySingleton.shared.savedPosts)")
        
      
        
        //print("BBBBB   \(PostRepositorySingleton.shared.allPosts)")
       
        
        //print("@@@@@@@@    \(PostRepositorySingleton.shared.savedPosts)")
        //print("vvvvv2    \(self.post.saved)")

    
    
    // MARK: Properties
    var post: Post = Post()
    weak var delegateTable: UITableView?
    var state = false
        
    
    // MARK: Lifecycle
    override func viewDidLoad() {

   
        self.usernameLabel.text = post.username
        self.domainLabel.text = post.domain
        self.titleLabel.text = post.title
        self.timePassedLabel.text = post.timePassed
        self.ratingLabel.text = String(post.rating)
        self.bookmark = Utilities.drawBookmark(bookmark: &self.bookmark, post: self.post)

        self.image.sd_setImage(with: URL(string: post.imageUrl), placeholderImage: UIImage(named: "50-0.jpg"))
    
        super.viewDidLoad()
    
    }
    

}



