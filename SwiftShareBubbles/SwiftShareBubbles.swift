//
//  SwiftShareBubbles.swift
//  SwiftShareBubbles
//
//  Created by Fujiki Takeshi on 2017/03/10.
//  Copyright © 2017年 com.takecian. All rights reserved.
//

import UIKit

public class SwiftShareBubbles: UIView {
    public weak var delegate: SwiftShareBubblesDelegate?


    public func show() {
        delegate?.bubblesTapped(bubbles: self)
    }

    public func hide() {
        delegate?.bubblesDidHide(bubbles: self)
    }

}
