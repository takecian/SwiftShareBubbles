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

    var bubbles: SwiftShareBubbles?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bubbles = SwiftShareBubbles(point: CGPoint(x: view.frame.width / 2, y: view.frame.height / 2), radius: 100, in: view)
        bubbles?.delegate = self
    }

    func bubblesTapped(bubbles: SwiftShareBubbles) {
        print("")
    }

    func bubblesDidHide(bubbles: SwiftShareBubbles) {
        print("hide:")
    }

    @IBAction func buttonTapped(_ sender: Any) {
        bubbles?.show()
    }
}

