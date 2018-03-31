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
    let customBubbleId = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bubbles = SwiftShareBubbles(point: CGPoint(x: view.frame.width / 2, y: view.frame.height / 2), radius: 100, in: view)
        bubbles?.showBubbleTypes = [Bubble.facebook, Bubble.twitter, Bubble.safari]
        
        let customAttribute = ShareAttirbute(bubbleId: customBubbleId, icon: UIImage(named: "Custom")!, backgroundColor: UIColor.white)
        bubbles?.customBubbleAttributes = [customAttribute]
        
        bubbles?.delegate = self
    }

    func bubblesTapped(bubbles: SwiftShareBubbles, bubbleId: Int) {
        if let bubble = Bubble(rawValue: bubbleId) {
            print("\(bubble)")
            switch bubble {
            case .facebook:
                let alert = UIAlertController(title: nil, message: "Open facebook using SDK", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            case .twitter:
                let alert = UIAlertController(title: nil, message: "Open twitter using SDK", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            default:
                break
            }
        } else {
            if customBubbleId == bubbleId {
                let alert = UIAlertController(title: nil, message: "Add custom id handling", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
    }

    func bubblesDidHide(bubbles: SwiftShareBubbles) {
    }

    @IBAction func buttonTapped(_ sender: Any) {
        bubbles?.show()
    }
}

