//
//  BaseRequest.swift
//  RedditReaderAppXenofontova
//
//  Created by Софія Ксенофонтова  on 11.02.2022.
//

import Foundation

struct Request{

    let session: URLSession
    let url : URL
    
    init?(str: String){
        
        guard let url = URL(string: str)
        else { return nil }
        
        self.session = URLSession(configuration: .default)
        self.url = url
    }


    func fetchPostData(completionHandler: @escaping ([Post]) -> Void ) {
   
        let dataTask = self.session.dataTask(with: url) { data, response, error in
          
           guard let data = data
           else { return }
           do{
               let postDto = try JSONDecoder().decode(PostDto.self, from: data)
               Const.after = postDto.data.after
               completionHandler(postDto.data.children.map{ x in
                   return Post(childData: x.data)
               })
           }
            catch {
                let error = error
                print(error.localizedDescription)
            }
 
        }.resume()
        }
    
}
