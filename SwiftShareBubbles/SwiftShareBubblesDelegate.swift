//
//  SwiftShareBubblesDelegate.swift
//  SwiftShareBubbles
//
//  Created by Fujiki Takeshi on 2017/03/10.
//  Copyright © 2017年 com.takecian. All rights reserved.
//

import UIKit

public protocol SwiftShareBubblesDelegate: class {

//    -(void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(AAShareBubbleType)bubbleType;
    func bubblesTapped(bubbles: SwiftShareBubbles)

    func bubblesDidHide(bubbles: SwiftShareBubbles)
}

public extension SwiftShareBubblesDelegate {
    func bubblesTapped(bubbles: SwiftShareBubbles) {}
    func bubblesDidHide(bubbles: SwiftShareBubbles) {}
}
