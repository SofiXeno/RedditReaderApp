//
//  Logger.swift
//  RedditReaderAppXenofontova
//
//  Created by Софія Ксенофонтова  on 20.02.2022.
//

import Foundation


struct Logger{
    
    var messages : [String]
    
    init(){
        self.messages = []
    }
    
    
    mutating func addMessage(message: String){
        self.messages.append(message)
        
    }
    
    
    func printMessages(){
        
        for elem in messages {
            print("Logging ---- ", elem)
            
        }
        
        
    }
    
    
    
    
    
    
    
    
}
