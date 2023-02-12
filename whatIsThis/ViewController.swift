//
//  ViewController.swift
//  whatIsThis
//
//  Created by Hüdahan Altun on 12.02.2023.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var informationLabel: UILabel!
    
    @IBOutlet weak var questionMarkImageView: UIImageView!
    
    @IBOutlet weak var takeAPictureButton: UIButton!
    
    @IBOutlet weak var chooseAPictureButton: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    var imagePicker = UIImagePickerController ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        progressView.progress = 0
        
    }
    override func viewWillAppear(_ animated: Bool) {
        progressView.progress = 0
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
        
    }
    
    @objc func gotoVC2(){
        
        self.performSegue(withIdentifier: "toVC2", sender: nil)
    }
    
}

extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            //image that user picked is stored like dictionary. and we must take original photo with "original ımage" method.and we converted the incoming image to UIImage  with the "if let"
            
            
            guard let ciImage = CIImage(image: userPickedImage) else{//we have to convert ciImage to use with .mlmodel
                fatalError("could not convert UIImage into CIImage")
            }
            
        
            detectObject(image: ciImage)//passed image to our func
        }
        
       
        imagePicker.dismiss(animated: true,completion: nil)// camera will close and main page will open
        
        UIView.animate(withDuration: 5, delay: 4, animations: {
            
            self.progressView.setProgress(1, animated: true)
            
        })
        
        _ = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(gotoVC2), userInfo: nil, repeats: false)
        
    }
    
}
