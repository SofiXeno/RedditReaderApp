//
//  PostRepository.swift
//  RedditReaderAppXenofontova
//
//  Created by Софія Ксенофонтова  on 13.04.2022.
//

import Foundation


class PostRepositorySingleton{
    
    var allPosts: [Post] = []
    
    var savedPosts: [Post] = []
    
    var currentPosts: [Post] = []
    
    var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(Const.fileName)
    
    let requestMain = Request(str: Const.baseUrl)
    
    var after: String? = ""
    
    var reloadUrl = ""
    // let requestLoadMore = Request(str: "https://www.reddit.com/r/ios/top.json?limit=\(Const.numOfPortion)&after=\(Const.after)")
    
    var navItemTitle : String = ""
    
    static let shared = PostRepositorySingleton()
    private init() {}
    
    
//    func checkSaved(posts: [Post] ){
//
//        self.currentPosts = posts.map{ post in
//
//            for savedPost in self.savedPosts{
//
//                if (savedPost == post) {
//                    post.saved = true
//                }
//            }
//            return post
//        }
//        self.allPosts.append(contentsOf: self.currentPosts)
//
//
//    }
    
    
    
//    func firstLoad(update: @escaping () -> Void) {
//
//
//        guard let request = requestMain else{
//            return
//        }
//
//        request.fetchPostData { posts in
//
//            DispatchQueue.main.async {
//
//                if (!posts.isEmpty) {
//                    self.navItemTitle = posts[0].subredditNamePrefixed
//                    print("self.navItemTitle \(self.navItemTitle)")
//                }
//
//                self.currentPosts = posts.map{ post in
//                    var postTemp = post
//                    for savedPost in self.savedPosts{
//
//                        if (savedPost == post) {
//                            postTemp.saved = true
//                        }
//                    }
//                    return post
//                }
//                self.allPosts.append(contentsOf: self.currentPosts)
//                update()
//
////                                    PostRepositorySingleton.shared.allPosts = posts
////                                    PostRepositorySingleton.shared.currentPosts = PostRepositorySingleton.shared.allPosts
////
////                                    self.postsListTableView.reloadData()
//
//            }
//        }
//    }

    
//    func loadMore(after: String){
//        
//        //self.after = Const.after
//        self.reloadUrl = "https://www.reddit.com/r/ios/top.json?limit=\(Const.numOfPortion)&after=\(after)"
//        
//        if let request = Request(str: self.reloadUrl) {
//            request.fetchPostData { posts in
//                
//                DispatchQueue.main.async {
//                    
//        
//                    self.allPosts = posts.map{ post in
//                        var postTemp = post
//                        for savedPost in self.savedPosts{
//                            
//                            if (savedPost == post) {
//                                postTemp.saved = true
//                            }
//                        }
//                        return post
//                    }
//                    self.currentPosts.append(contentsOf: self.allPosts)
//
//                    
//                   
//           
//                }
//            }
//        }
//   
//    }
    
    func readSavedPostsFrom(){
        
        print("READ \(path)")
        do{
            let data = try Foundation.Data(contentsOf: self.path)
            self.savedPosts = try JSONDecoder().decode([Post].self, from: data)
            // print("------------------ \(self.allPosts)")
            
        }
        catch {
            print("Failed to read JSON data: \(error.localizedDescription)")
        }
    }
    
    
    func writeSavedPostsTo(){
        
        print("WRITE \(self.path)")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        if let data = try? encoder.encode(self.savedPosts){
            do {
                try String(data: data, encoding: .utf8)?.write(to: self.path, atomically: true, encoding: .utf8)
            } catch {
                print("Failed to write JSON data: \(error.localizedDescription)")
            }
            
        }
    }
}






