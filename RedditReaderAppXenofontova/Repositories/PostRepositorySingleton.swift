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
  
    var navItemTitle : String = ""
    
    static let shared = PostRepositorySingleton()
    private init() {}
    
    
    func readSavedPostsFrom(){
        
        print("READ \(path)")
        do{
            let data = try Foundation.Data(contentsOf: self.path)
            self.savedPosts = try JSONDecoder().decode([Post].self, from: data)
            
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






