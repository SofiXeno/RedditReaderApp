//
//  Utilities.swift
//  RedditReaderAppXenofontova
//
//  Created by Софія Ксенофонтова  on 19.02.2022.
//

import Foundation
import UIKit

struct Utilities{
    
    static func savePost(toSave: Bool, bookmark: UIImageView){
        
        if toSave {
            bookmark.image = UIImage(systemName: "bookmark.fill")?.withTintColor(.systemOrange)
        }
    }
    
    static func calcDate(created: Double) -> String {
       
       var resNum : Int
       var res: String = ""
       
       let calendar = Calendar.current
       let hoursViaKyiv = (calendar.component(.hour, from: Date(timeIntervalSince1970: created)) - Const.utcKyiv)
       

       if hoursViaKyiv <= 0 {

           resNum =  calendar.component(.minute, from: Date(timeIntervalSince1970: created))
           res.append(String(resNum))
           res.append(" m.")
       }
       else{
           
           resNum = hoursViaKyiv
           res.append(String(resNum))
           res.append(" h.")
       }
       

       return res
       
   }
    
 
    
}

protocol PostTableViewCellDelegate: AnyObject {
    func share(url: String)
}



extension UIViewController : PostTableViewCellDelegate {
    
    func share(url: String){
        
        if let postUrl = URL(string: "\(Const.Url)\(url)") {
            let objectsToShare: [Any] = [postUrl]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            
//                activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
            
            print("AAAAAAAAAAAA: \(postUrl)")
            }
    }
        
        
    }

