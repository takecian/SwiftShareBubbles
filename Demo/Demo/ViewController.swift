//
//  ViewController.swift
//  Demo
//
//  Created by Fujiki Takeshi on 2017/03/10.
//  Copyright © 2017年 com.takecian. All rights reserved.
//

import UIKit
import SwiftShareBubbles
import Social

class ViewController: UIViewController, SwiftShareBubblesDelegate {

    var bubbles: SwiftShareBubbles?
    let customBubbleId = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bubbles = SwiftShareBubbles(point: CGPoint(x: view.frame.width / 2, y: view.frame.height / 2), radius: 100, in: view)
        bubbles?.showBubbleTypes = [Bubble.twitter, Bubble.line, Bubble.safari]
        
        let customAttribute = ShareAttirbute(bubbleId: 100, icon: UIImage(named: "")!, backgroundColor: UIColor.blue)
        bubbles?.customBubbleAttributes = [customAttribute]
        
        bubbles?.delegate = self
    }

    func bubblesTapped(bubbles: SwiftShareBubbles, bubbleId: Int) {
        if let bubble = Bubble(rawValue: bubbleId) {
            print("\(bubble)")
            switch bubble {
            case .facebook:
                break
            case .twitter:
                if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                    guard let composer = SLComposeViewController(forServiceType: SLServiceTypeTwitter) else { return }
                    composer.setInitialText("test test")
                    present(composer, animated: true, completion: nil)
                }
                break
            case .line:
                break
            default:
                break
            }
        
        } else {
            // custom case
        }
    }

    func bubblesDidHide(bubbles: SwiftShareBubbles) {
    }

    @IBAction func buttonTapped(_ sender: Any) {
        bubbles?.show()
    }
}

