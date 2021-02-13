//
//  ViewController.swift
//  PALGIF
//
//  Created by pikachu987 on 02/13/2021.
//  Copyright (c) 2021 pikachu987. All rights reserved.
//

import UIKit
import PALGIF

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let url = URL(string: "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/5eeea355389655.59822ff824b72.gif") {
            if let gif = GIF(url) {
                print(gif.frameImages)
                if let gifImage = gif.gifImage {
                    print(gifImage)
                }
            }
        }

        if let url = Bundle.main.url(forResource: "gif", withExtension: "gif") {
            if let gif = GIF(url) {
                print(gif.frameImages)
                if let gifImage = gif.gifImage {
                    print(gifImage)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

