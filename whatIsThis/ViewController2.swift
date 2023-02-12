//
//  ViewController2.swift
//  whatIsThis
//
//  Created by Hüdahan Altun on 12.02.2023.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController2: UIViewController {

    
    @IBOutlet weak var objectImageView: UIImageView!
    
    @IBOutlet weak var objectNameLabel: UILabel!
    @IBOutlet weak var objectInformationTextView: UITextView!
    
    let wikiURL = "https://en.wikipedia.org/w/api.php?" //wiki url
    
    var detectedObject:detectedObject?// object comes from VC1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        objectNameLabel.textColor = .black
        objectInformationTextView.isEditable = false
        objectInformationTextView.textColor = .black
        
        if let object = detectedObject{ //optional binding 
            
            objectNameLabel.text = object.getObjectName()
            objectImageView.image = UIImage(ciImage: object.getObjectImage()!)
            requestInfo(objectName: object.getObjectName()!)
        }
        
    }
    

}
extension ViewController2{
    
    
    func requestInfo(objectName:String){
        
        //url keys
        let parameters:[String:String] = [
            "format":"json",
            "action":"query",
            "prop":"extracts",
            "exintro":"",
            "explaintext":"",
            "titles":objectName,
            "indexpageids":"",
            "redirects":"1"
        
        
        ]
        
        //create alamofire request to get data from wikipedia
        AF.request(wikiURL,method: .get,parameters: parameters).response{
            
            response in
    
            if response.error != nil{
                
                print("internet bağlantı hatası.")
            }
            
            guard let data = response.data else{
                
                fatalError("data is not found")
            }
            
            let objectJSON:JSON = JSON(data)//JSON Parse
            
            let pageID = objectJSON["query"]["pageids"][0].stringValue
            
            let objectDescription = objectJSON["query"]["pages"][pageID]["extract"].stringValue
           
            
          
            self.objectInformationTextView.text = objectDescription

        }
    }
}
