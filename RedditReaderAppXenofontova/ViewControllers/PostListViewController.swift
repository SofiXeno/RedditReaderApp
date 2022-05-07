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
    @IBOutlet private weak var savedPostsListButton: UIBarButtonItem!
    
    
    // MARK: IBActions
    @IBAction func showSavedPostsAction(_ sender: Any) {
        
        self.updateControllerUI()
        
    }
    
    
    func updateControllerUI(){
        
        
        self.controllerIsInSavedState.toggle()
        print("STATE",   self.controllerIsInSavedState)
        
        if self.controllerIsInSavedState{ //true
            
            self.postsListTableView.tableFooterView = nil
            PostRepositorySingleton.shared.currentPosts = PostRepositorySingleton.shared.savedPosts//saved posts
            self.savedPostsListButton.tintColor = UIColor.systemOrange
            self.searchController.searchBar.isHidden = false
            
            
        }
        else{
            PostRepositorySingleton.shared.currentPosts = PostRepositorySingleton.shared.allPosts
            self.savedPostsListButton.tintColor = UIColor.white
            self.searchController.searchBar.isHidden = true
        }
        
        print("UPDATE UI",   PostRepositorySingleton.shared.currentPosts)
        
        self.postsListTableView.reloadData()
        
        if(!PostRepositorySingleton.shared.savedPosts.isEmpty){self.postsListTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .none, animated: true)}
        
    }
    
    
    
    // MARK: Properties
    var searchController: UISearchController!
    
    private var selectedPost : Post = Post()
    private var logger : Logger = Logger()
    var controllerIsInSavedState : Bool = false
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        
        PostRepositorySingleton.shared.readSavedPostsFrom()
        if let request = Request(str: Const.baseUrl) {
            
            request.fetchPostData { (posts) in
                
                DispatchQueue.main.async {
                    
                    
                    
                    if (!posts.isEmpty) {
                        self.navItem.title = posts[0].subredditNamePrefixed
                    }
                    
                    PostRepositorySingleton.shared.currentPosts = posts.map{ post in
                        var postTemp = post
                        for savedPost in PostRepositorySingleton.shared.savedPosts{
                            
                            if (savedPost.id == post.id) {
                                postTemp.saved = true
                                
                            }
                        }
                        return postTemp
                    }
                    
                    
                    PostRepositorySingleton.shared.allPosts.append(contentsOf: PostRepositorySingleton.shared.currentPosts)
                    
                    
                    self.postsListTableView.reloadData()
                    
                }
            }
            
        }
        
        createSearchController()
        
        super.viewDidLoad()
        
        searchController.searchBar.isHidden = true
        
        self.postsListTableView.showsVerticalScrollIndicator = true
        
        self.postsListTableView.dataSource = self
        self.postsListTableView.delegate = self
        
    }
    
    
    func createSearchController(){
        
        
        self.searchController = UISearchController(searchResultsController: nil)
        
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.sizeToFit()
        self.searchController.searchBar.searchTextField.textColor = .green
        self.searchController.searchBar.barTintColor = UIColor(named: "MainColor")
        self.postsListTableView.tableHeaderView = searchController.searchBar
        
        
        self.searchController.definesPresentationContext = true
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if self.controllerIsInSavedState {
            self.postsListTableView.reloadData()
        }
        
    }
    
    
    
    // MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PostDetailsViewController
        destinationVC.post = self.selectedPost
        destinationVC.delegateTable = self.postsListTableView
        destinationVC.state = self.controllerIsInSavedState
        
        print("selectedPost   \(selectedPost)")
        
    }
    
}



// MARK: UITableViewDataSource
extension PostListViewController: UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        let filteredPosts = PostRepositorySingleton.shared.savedPosts.filter({$0.title.lowercased().contains(searchText.lowercased())})
        PostRepositorySingleton.shared.currentPosts = searchText != "" ? filteredPosts : PostRepositorySingleton.shared.savedPosts
        
        self.postsListTableView.reloadData()
        
        if !PostRepositorySingleton.shared.currentPosts.isEmpty{ self.postsListTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .none, animated: true) }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return PostRepositorySingleton.shared.currentPosts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellReuseId, for: indexPath) as! PostTableViewCell
        
        cell.selectionStyle = .none
        cell.config(from: PostRepositorySingleton.shared.currentPosts[indexPath.row])
        cell.delegate = self
        cell.delegateVC = self
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        self.selectedPost = PostRepositorySingleton.shared.currentPosts[indexPath.row]
        self.performSegue(withIdentifier: Const.segueFromPostsToOneDetailed, sender: self)
        
    }
    
    
    private func createSpinnerFooter() -> UIView {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        spinner.color = .cyan
        
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
        
    }
    
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if !self.controllerIsInSavedState { //true
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
            
            self.postsListTableView.tableFooterView = createSpinnerFooter()
            
            if maximumOffset - currentOffset <= 5.0 {
                
                if let request = Request(str: reloadUrl) {
                    request.fetchPostData { (posts) in
                        
                        DispatchQueue.main.async {
                            
                            let temp = posts.map{ post -> Post in
                                var postTemp = post
                                for savedPost in PostRepositorySingleton.shared.savedPosts{
                                    
                                    if (savedPost.id == post.id) {
                                        postTemp.saved = true
                                        
                                    }
                                }
                                return postTemp
                            }
                            
                            PostRepositorySingleton.shared.currentPosts.append(contentsOf: temp)
                            
                            PostRepositorySingleton.shared.allPosts.append(contentsOf: temp)
                            
                            self.postsListTableView.reloadData()
                            
                        }
                    }
                }
            }
            
        }
        else{
            self.postsListTableView.tableFooterView?.isHidden = true
        }
    }
    
}






extension PostListViewController : PostTableViewCellDelegate {
    
    
    func sharePost(url: String){
        Utilities.sharePost(url: url, vc: self)
    }
    
    func savePost(post: inout Post, bookmark: UIButton) {
        
        Utilities.savePostAction(post: &post, bookmark: bookmark)
        if self.controllerIsInSavedState {
            PostRepositorySingleton.shared.currentPosts = PostRepositorySingleton.shared.savedPosts
        }
        
        self.postsListTableView.reloadData()
        
        
    }
    
}
