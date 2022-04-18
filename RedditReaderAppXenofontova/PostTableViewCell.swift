//
//  PostTableViewCell.swift
//  RedditReaderAppXenofontova
//
//  Created by Софія Ксенофонтова  on 18.02.2022.
//

import UIKit
import SDWebImage


class PostTableViewCell: UITableViewCell{
    
    
    
    // MARK: IBOutlets
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var timePassedLabel: UILabel!
    @IBOutlet private weak var domainLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var imagePost: UIImageView!
    @IBOutlet weak var bookmark: UIButton!
    
    @IBAction func shareAction(_ sender: Any) {
        
        self.delegate?.sharePost(url: self.selectedPostUrl)
    }
    
    
    @IBAction func savePostAction(_ sender: Any) {
        
        //        Utilities.savePostAction(post: &self.post, bookmark: self.bookmark )
        
        
        self.delegate?.savePost(post: &self.post, bookmark: self.bookmark)
  
    }
    
    
    
    // MARK: Properties
    private var selectedPostUrl: String = ""
    weak var delegate : PostTableViewCellDelegate?
    private var post: Post = Post()
    
    
    
    // MARK: Cell configuration
    func config(from post: Post){
        

        self.post = post
    
        self.usernameLabel.text = post.username
        self.domainLabel.text = post.domain
        self.titleLabel.text = post.title
        self.timePassedLabel.text = post.timePassed
        self.ratingLabel.text = String(post.rating)
        self.bookmark = Utilities.drawBookmark(bookmark: &self.bookmark, post: self.post)
        self.imagePost.sd_setImage(with: URL(string: post.imageUrl), placeholderImage: UIImage(named: "50-0.jpg"))
        self.selectedPostUrl = post.postUrl
        
        
        
        
        
        
        
    }
    
}
