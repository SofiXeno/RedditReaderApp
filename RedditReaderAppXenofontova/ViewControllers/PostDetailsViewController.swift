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
    @IBOutlet private weak var commentButton: UIButton!
    @IBOutlet private weak var commentLabel: UILabel!
    
    // MARK: IBActions
    @IBAction private func share(_ sender: Any) {
        Utilities.sharePost(url: self.post.postUrl, vc: self)
        
        
    }
    
    @IBAction private func savePostAction(_ sender: Any) {
        
        Utilities.savePostAction(post: &self.post, bookmark: self.bookmark)
        
        if self.state {
            PostRepositorySingleton.shared.currentPosts = PostRepositorySingleton.shared.savedPosts
        }
        
        self.delegateTable?.reloadData()
        
    }
    
    
    // MARK: Properties
    var post: Post = Post()
    weak var delegateTable: UITableView?
    var state = false
    private var animatedBookmark: UIView?
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.bookmarkAnimation))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delaysTouchesBegan = true

        self.image.gestureRecognizers?.forEach{self.image.removeGestureRecognizer($0)}
        self.image.addGestureRecognizer(doubleTap)
        self.image.isUserInteractionEnabled = true

        
        self.usernameLabel.text = post.username
        self.domainLabel.text = post.domain
        self.titleLabel.text = post.title
        self.timePassedLabel.text = post.timePassed
        self.ratingLabel.text = String(post.rating)
        self.bookmark = Utilities.drawBookmark(bookmark: &self.bookmark, post: self.post)
        
        self.image.sd_setImage(with: URL(string: post.imageUrl), placeholderImage: UIImage(named: Const.defaultGlybaImageUrl))
        self.commentLabel.text = String(post.numOfComments)
     

        
        super.viewDidLoad()
        
     
    }
    
 
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.image.layer.sublayers?.forEach { $0.removeFromSuperlayer() }

        self.animatedBookmark = Utilities.drawBookmark(in: self.image, post: self.post)

        self.image.addSubview(self.animatedBookmark!)
    
    }

    @objc func bookmarkAnimation(){

        self.animatedBookmark = Utilities.drawBookmark(in: self.image, post: self.post)
        
        self.image.addSubview(self.animatedBookmark!)

        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIView.transition(
                with: self.view,
                duration: 1.5,
                options: .transitionCrossDissolve
            ) {
                self.animatedBookmark?.isHidden = false

                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    UIView.transition(
                        with: self.view,
                        duration: 1.5,
                        options: .transitionCrossDissolve
                    ) {
                        self.animatedBookmark?.isHidden = true

                    }

                }
            }

        }
        
        self.savePostAction(self.bookmark!)
  }
    
}



