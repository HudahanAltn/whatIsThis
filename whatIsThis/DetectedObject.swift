//
//  DetectedObject.swift
//  whatIsThis
//
//  Created by Hüdahan Altun on 12.02.2023.
//


import UIKit

class detectedObject{
    
    private var name:String?
    private var image:CIImage?
    
    init(name:String,image:CIImage){
        
        self.name = name
        self.image = image
    }
    
    func getObjectName()->String?{
        
        return name
    }
    func getObjectImage()->CIImage?{
        return image
    }
}
