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
    
    private var radius: Int
    private var bubbleRadius: Int
    private var parentView: UIView
    private var faderView = UIView()
    private var isAnimating = false
    private var bubbles = [SwiftShareBubble]()

    private var faderColor = UIColor.black
    private var faderAlpha: CGFloat = 0.15
    
    public init(point: CGPoint, radius radiusValue: Int, in inView: UIView) {
        self.radius = radiusValue
        self.bubbleRadius = 40
        self.parentView = inView
        super.init(frame: CGRect(x: point.x - CGFloat(radiusValue), y: point.y - CGFloat(radiusValue), width:  CGFloat(radiusValue) * 2, height: CGFloat(radiusValue) * 2))
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func show() {
        guard !isAnimating else { return }
        isAnimating = true
        
        parentView.addSubview(self)

        faderView.frame = parentView.bounds
        faderView.backgroundColor = faderColor
        faderView.alpha = 0
        parentView.insertSubview(faderView, belowSubview: self)
        UIView.animate(withDuration: 0.25) {
                self.faderView.alpha = self.faderAlpha
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(SwiftShareBubbles.tapped(_:)))
        faderView.addGestureRecognizer(tap)
        
        guard bubbles.count > 0 else { return }

    }

    public func hide() {
        guard isAnimating else { return }
        
        UIView.animate(withDuration: 0.25, animations: { 
            self.faderView.alpha = 0
        }) { (finished) in
            self.faderView.removeFromSuperview()
            self.removeFromSuperview()
            self.isAnimating = false
            self.delegate?.bubblesDidHide(bubbles: self)
        }        
    }

    func tapped(_ sender: UITapGestureRecognizer) {
        hide()
    }
        
    
}
