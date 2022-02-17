//
//  ViewController.swift
//  RedditReaderAppXenofontova
//
//  Created by Софія Ксенофонтова  on 10.02.2022.
//

import UIKit
import SDWebImage


class PostViewController: UIViewController {
    
    // MARK: IBOutlets

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timePassedLabel: UILabel!
    @IBOutlet weak var domainLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var bookmark: UIImageView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        
        overrideUserInterfaceStyle = .dark

        //https://www.reddit.com/r/ios/top.json?limit=1&after=t3_sshfj2
        //https://www.reddit.com/r/ios/top.json?limit=7&after=t3_sshfj2
        var request = Request(str: "https://www.reddit.com/r/ios/top.json?limit=8")
        
        request.fetchPostData { post in
            
            DispatchQueue.main.async {
                
                self.savePost(toSave: arc4random_uniform(2) == 0)

                self.usernameLabel.text = post.username
                self.domainLabel.text = post.domain
                self.titleLabel.text = post.title
                self.timePassedLabel.text = String(post.timePassed)
                self.timePassedLabel.text?.append(" h.")
                self.ratingLabel.text = String(post.rating)
                self.image.sd_setImage(with: URL(string: post.imageUrl), placeholderImage: UIImage(named: "50-0.jpg"))
                
            }
        }
  
        super.viewDidLoad()
    
    }
  
    // MARK: Utility functions
    func savePost(toSave: Bool){
        
        if toSave {
            bookmark.image = UIImage(systemName: "bookmark.fill")?.withTintColor(.systemOrange)
        
        }
    }
    

    
}



