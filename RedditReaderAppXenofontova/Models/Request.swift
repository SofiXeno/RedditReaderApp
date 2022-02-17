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
    
    init(str: String){
        self.session = URLSession(configuration: .default)
        self.url = URL(string: str)!
    }


    func fetchPostData(completionHandler: @escaping (Post) -> Void ) {
   
        let dataTask = self.session.dataTask(with: url) { data, response, error in

           guard let data = data
           else {return}
           do{
               let postDto = try JSONDecoder().decode(PostDto.self, from: data)
               completionHandler(Post(json: postDto))
           }
            catch {
                let error = error
                print(error.localizedDescription)
            }
 
        }.resume()
        }
    
}
