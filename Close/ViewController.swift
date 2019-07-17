//
//  ViewController.swift
//  Close
//
//  Created by User on 7/4/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var king = 0
    
    @IBAction func lol1(_ sender: UILongPressGestureRecognizer) {
        var inthfh = 0
        print(sender.state.rawValue)
        print(inthfh)
    }
    
    @IBAction func lolooo(_ sender: UIButton) {
        UIWindow().apply{ window in
              print("sdfsdfsdfsdfsdf")
        }
        print("fdfsdfs")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

