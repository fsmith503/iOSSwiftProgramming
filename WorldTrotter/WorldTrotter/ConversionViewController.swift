//
//  ViewController.swift
//  WorldTrotter
//
//  Created by franklin smith on 12/13/20.
//

import UIKit

class ConversionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Conversion VC loaded its view")
        //createGradientLayer()
//        // Do any additional setup after loading the view.
//
//        let firstFrame = CGRect(x: 160, y: 240, width: 100, height: 150)
//        let firstView = UIView(frame: firstFrame)
//        firstView.backgroundColor = UIColor.blue
//        view.addSubview(firstView)
//
//
//        let secondFrame = CGRect(x: 20, y: 30, width: 50, height: 50)
//        let secondView = UIView(frame: secondFrame)
//        secondView.backgroundColor = UIColor.green
////        view.addSubview(secondView)
//        firstView.addSubview(secondView)
    }
    

    func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
     
        gradientLayer.frame = self.view.bounds
     
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        //self.view.layer.addSublayer(gradientLayer)
        self.view.layer.sublayers?.append(gradientLayer)
    }


}

