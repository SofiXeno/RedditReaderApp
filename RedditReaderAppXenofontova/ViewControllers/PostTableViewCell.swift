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
        
        self.delegate?.savePost(post: &self.post, bookmark: self.bookmark)
        
    }
    
    
    
    // MARK: Properties
    private var selectedPostUrl: String = ""
    weak var delegate : PostTableViewCellDelegate?
    weak var delegateVC : PostListViewController?
    private var post: Post = Post()
    private var animatedBookmark: UIView?
    
    // MARK: Cell configuration
    func config(from post: Post){
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.bookmarkAnimation))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delaysTouchesBegan = true

       // self.imagePost.gestureRecognizers?.forEach{self.imagePost.removeGestureRecognizer($0)}
        self.imagePost.addGestureRecognizer(doubleTap)
        self.imagePost.isUserInteractionEnabled = true

        self.post = post
        
        self.usernameLabel.text = post.username
        self.domainLabel.text = post.domain
        self.titleLabel.text = post.title
        self.timePassedLabel.text = post.timePassed
        self.ratingLabel.text = String(post.rating)
        self.bookmark = Utilities.drawBookmark(bookmark: &self.bookmark, post: self.post)
        self.imagePost.sd_setImage(with: URL(string: post.imageUrl), placeholderImage: UIImage(named: Const.defaultGlybaImageUrl))
        self.selectedPostUrl = post.postUrl
        
        //-------------------------
       // self.imagePost.layer.sublayers?.forEach { $0.removeFromSuperlayer() }

        self.animatedBookmark = Utilities.drawBookmark(in: self.imagePost, post: self.post)

        self.imagePost.addSubview(self.animatedBookmark!)
    
 
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imagePost.gestureRecognizers?.forEach{self.imagePost.removeGestureRecognizer($0)}
        self.imagePost.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }
    

    @objc func bookmarkAnimation(){

    
        self.animatedBookmark = Utilities.drawBookmark(in: self.imagePost, post: self.post)
        
        self.imagePost.addSubview(self.animatedBookmark!)

        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIView.transition(
                with: (self.delegateVC?.view)!,
                duration: 1.5,
                options: .transitionCrossDissolve
            ) {
                self.animatedBookmark?.isHidden = false

                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    UIView.transition(
                        with: (self.delegateVC?.view)!,
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
