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
    @IBOutlet private weak var bookmark: UIImageView!

    // MARK: IBActions
    @IBAction func share(_ sender: Any) {
        self.share(url: self.post.postUrl)
        }
        

    
    // MARK: Properties
    var post: Post = Post()

    
    
    // MARK: Lifecycle
    override func viewDidLoad() {

        Utilities.savePost(toSave: post.saved, bookmark: self.bookmark)
 
        self.usernameLabel.text = post.username
        self.domainLabel.text = post.domain
        self.titleLabel.text = post.title
        self.timePassedLabel.text = post.timePassed
        self.ratingLabel.text = String(post.rating)
        self.image.sd_setImage(with: URL(string: post.imageUrl), placeholderImage: UIImage(named: "50-0.jpg"))
    
        super.viewDidLoad()
    
    }
    

}



