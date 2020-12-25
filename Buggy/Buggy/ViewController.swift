//
//  ViewController.swift
//  Buggy
//
//  Created by franklin smith on 12/25/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

        
    @IBAction func buttonTapped(_ sender: UIButton){
        //print("Called buttonTapped(_:)")
        print("Method: \(#function) in file: \(#file) line: \(#line) called.")
        
        badMethod()
    }
    
    func badMethod() {
        let array = NSMutableArray()
        
        for i in 0..<10 {
            array.insert(i, at: i)
        }
        
        // go one step too far emptying array (notice the range change):
        for _ in 0...10 {
            array.removeObject(at: 0)
        }
    }

}

