//
//  PostListViewController.swift
//  RedditReaderAppXenofontova
//
//  Created by Софія Ксенофонтова  on 18.02.2022.
//

import UIKit

class PostListViewController: UIViewController {


    // MARK: IBOutlets
    @IBOutlet private weak var navItem: UINavigationItem!
    @IBOutlet private weak var postsListTableView: UITableView!
    
    // MARK: Properties
    private var postsList : [Post] = []
    var selectedPost: Post = Post()
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {

    
        var request = Request(str: Const.baseUrl)
        
        request.fetchPostData { (posts) in

            DispatchQueue.main.async {
                
                if (!posts.isEmpty) {
                    self.navItem.title = posts[0].subredditNamePrefixed
                }
                
                self.postsList = posts
                self.postsListTableView.reloadData()
 
            }
        }
 
        super.viewDidLoad()
   
        self.postsListTableView.dataSource = self
        self.postsListTableView.delegate = self
        
    }
    
    // MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let desrinationVC = segue.destination as! PostDetailsViewController
        
        desrinationVC.post = self.selectedPost
        
    }
 
}



// MARK: UITableViewDataSource
extension PostListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.postsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellReuseId, for: indexPath) as! PostTableViewCell

        cell.selectionStyle = .none
        cell.config(from: self.postsList[indexPath.row])
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedPost = postsList[indexPath.row]
   
        self.performSegue(withIdentifier: Const.segueFromPostsToOneDetailed, sender: self)
        
    }
    }

