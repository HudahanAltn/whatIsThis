//
//  ViewController.swift
//  whatIsThis
//
//  Created by Hüdahan Altun on 12.02.2023.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    
    @IBOutlet weak var informationLabel: UILabel!
    
    @IBOutlet weak var questionMarkImageView: UIImageView!
    
    @IBOutlet weak var takeAPictureButton: UIButton!
    
    @IBOutlet weak var chooseAPictureButton: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    

    private var imagePicker = UIImagePickerController ()
    
    var object:detectedObject?//detected object by Resnet50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        progressView.progress = 0
        informationLabel.textColor = .black
    }
    override func viewWillAppear(_ animated: Bool) {
        progressView.progress = 0
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let o = sender as? detectedObject{
            
            let VC2 = segue.destination as! ViewController2
            
            VC2.detectedObject = o
        }
    }
    
    @IBAction func takeAPicturePressed(_ sender: UIButton) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true)
    }
    
    @IBAction func chooseAPicturePressed(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
}

extension ViewController{
    
    func detectObject(image:CIImage){
        
           //we created an object from mobileNetV2 to passed testing data securely
           guard let model = try? VNCoreMLModel(for: Resnet50().model) else{
               fatalError("loading CoreML model failed.")
           }
        
           //created a request to process image
           let request = VNCoreMLRequest(model: model){
               (request,error) in
               
               
               //we got results
               guard let results = request.results as? [VNClassificationObservation] else{
                   fatalError("model failed to process image")
               }
               
               //take first result
               if let firstResult = results.first{
                   
                   //passed result to object
                   self.object = detectedObject(name:self.getOneWord(words: firstResult.identifier),image: image)
                       
                   print("tespit edilen nesne:\(firstResult.identifier)")
                   
                   
               }
           }
           
           let handler = VNImageRequestHandler(ciImage: image)
           
           do{
               
               try handler.perform([request])
               
           }catch{
               Swift.print("error request code:\(String(describing: error))")
           }
           
    }
    
    @objc func gotoVC2(){//Timer class trigger this func
        
        self.performSegue(withIdentifier: "toVC2", sender: object)
    }
    
    func getOneWord(words:String)->String{//basic algorithm to get one word from  which resnet50 detected object.
        
        var oneWord:String = ""
        
        for i in words{
            
            if i != ","{
                
                oneWord.append(i)
                
            }else{
                break
            }
        }
        
        return oneWord
    }
    
    
}

extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            //image that user picked is stored like dictionary. and we must take original photo with "original ımage" method.and we converted the incoming image to UIImage  with the "if let"
            
            
            guard let ciImage = CIImage(image: userPickedImage) else{//we have to convert ciImage to use with .mlmodel
                fatalError("could not convert UIImage into CIImage")
            }
            
        
            DispatchQueue.main.async {
                self.detectObject(image: ciImage)//passed image to our func
            }
            
            
            
            
        }
        
        imagePicker.dismiss(animated: true,completion: nil)// camera will close and main page will open
        
        UIView.animate(withDuration: 5, delay: 4, animations: {
            
            self.progressView.setProgress(1, animated: true)
            
        })
        
        _ = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(gotoVC2), userInfo: nil, repeats: false)// we got six second to pass to VC2
        
    }
    
   
    
}
