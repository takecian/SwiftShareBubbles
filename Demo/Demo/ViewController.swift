//
//  ViewController.swift
//  Demo
//
//  Created by Fujiki Takeshi on 2017/03/10.
//  Copyright © 2017年 com.takecian. All rights reserved.
//

import UIKit
import SwiftShareBubbles

class ViewController: UIViewController, SwiftShareBubblesDelegate {

    let bubbles = SwiftShareBubbles()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bubbles.delegate = self
        bubbles.hide()
    }

    func bubblesTapped(bubbles: SwiftShareBubbles) {
        print("")
    }

    func bubblesDidHide(bubbles: SwiftShareBubbles) {
        print("hide:")
    }

}

