//
//  ViewController2.swift
//  whatIsThis
//
//  Created by Hüdahan Altun on 12.02.2023.
//

import UIKit

class ViewController2: UIViewController {

    
    @IBOutlet weak var objectImageView: UIImageView!
    
    @IBOutlet weak var objectNameLabel: UILabel!
    @IBOutlet weak var objectInformationTextView: UITextView!
    
    var detectedObject:detectedObject?// object comes from VC1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let object = detectedObject{ //optional binding 
            
            objectNameLabel.text = object.getObjectName()
            objectImageView.image = UIImage(ciImage: object.getObjectImage()!)
        }
        
    }
    

}
