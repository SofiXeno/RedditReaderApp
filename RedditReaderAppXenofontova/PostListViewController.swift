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
    var logger : Logger = Logger()
    

    // MARK: Lifecycle
    override func viewDidLoad() {

        self.postsListTableView.showsVerticalScrollIndicator = true
        
        if let request = Request(str: Const.baseUrl) {
        
        request.fetchPostData { (posts) in

            DispatchQueue.main.async {
                
                if (!posts.isEmpty) {
                    self.navItem.title = posts[0].subredditNamePrefixed
                }
                
                self.postsList = posts
                self.postsListTableView.reloadData()
            }
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
        
        cell.delegate = self     
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedPost = postsList[indexPath.row]
        self.performSegue(withIdentifier: Const.segueFromPostsToOneDetailed, sender: self)
        
    }
    

    private func createSpinnerFooter() -> UIView{
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        spinner.color = .cyan
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        guard let const = Const.after
        else {
            
            self.postsListTableView.tableFooterView = nil
            logger.addMessage(message: "There is no data for loading :( ")
            logger.printMessages()
            return
            
        }
        
        let reloadUrl = "https://www.reddit.com/r/ios/top.json?limit=\(Const.numOfPortion)&after=\(const)"
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        if maximumOffset - currentOffset <= 5.0 {
               
            self.postsListTableView.tableFooterView = createSpinnerFooter()
               
            if let request = Request(str: reloadUrl) {
                request.fetchPostData { (posts) in

                   DispatchQueue.main.async {
                      
                       self.postsList.append(contentsOf: posts)
                       self.postsListTableView.reloadData()
            
                   }
               }
            }
    }

}
    
    
}

