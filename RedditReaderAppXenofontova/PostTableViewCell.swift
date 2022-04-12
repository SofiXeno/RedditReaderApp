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
    @IBOutlet private weak var bookmark: UIImageView!

    @IBAction func shareAction(_ sender: Any) {

        self.delegate?.share(url: self.selectedPostUrl)
    }
    
    
    // MARK: Properties
    var selectedPostUrl: String = ""
    weak var delegate : PostTableViewCellDelegate?
    
    // MARK: Cell configuration
    func config(from post: Post){
        
        //arc4random_uniform(2) == 0
        Utilities.savePost(toSave: post.saved, bookmark: self.bookmark)
 
        self.usernameLabel.text = post.username
        self.domainLabel.text = post.domain
        self.titleLabel.text = post.title
        self.timePassedLabel.text = post.timePassed
        self.ratingLabel.text = String(post.rating)
        self.imagePost.sd_setImage(with: URL(string: post.imageUrl), placeholderImage: UIImage(named: "50-0.jpg"))
        self.selectedPostUrl = post.postUrl

}

}
