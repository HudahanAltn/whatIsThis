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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func takeAPicturePressed(_ sender: UIButton) {
    }
    
    @IBAction func chooseAPicturePressed(_ sender: Any) {
    }
}

