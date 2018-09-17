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
    
    public var showBubbleTypes = [Bubble.facebook, Bubble.twitter, Bubble.line, Bubble.google, Bubble.instagram, Bubble.linkedin, Bubble.pintereset, Bubble.weibo, Bubble.whatsapp, Bubble.youtube]
    public var customBubbleAttributes = [ShareAttirbute]()
    
    public var isShown: Bool {
        return self.superview != nil
    }
    
    private var radius: Int
    private var bubbleRadius: Int
    private var parentView: UIView
    private var faderView = UIView()
    private var isAnimating = false
    private var attributes = [ShareAttirbute]()
    private var buttons = [UIButton]()

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

        // setup target bubbles
        attributes.removeAll()
        buttons.removeAll()

        for showBubble in showBubbleTypes {
            switch showBubble {
            case .facebook:
                createButton(attribute: ShareAttirbute.createFacebook())
            case .twitter:
                createButton(attribute: ShareAttirbute.createTwitter())
            case .line:
                createButton(attribute: ShareAttirbute.createLine())
            case .whatsapp:
                createButton(attribute: ShareAttirbute.createWhatsapp())
            case .linkedin:
                createButton(attribute: ShareAttirbute.createLinkedin())
            case .weibo:
                createButton(attribute: ShareAttirbute.createWeibo())
            case .youtube:
                createButton(attribute: ShareAttirbute.createYoutube())
            case .pintereset:
                createButton(attribute: ShareAttirbute.createPinterest())
            case .instagram:
                createButton(attribute: ShareAttirbute.createInstagram())
            case .google:
                createButton(attribute: ShareAttirbute.createGoogle())
            case .safari:
                createButton(attribute: ShareAttirbute.createSafari())
            }
        }
        for customBubbleAttribute in customBubbleAttributes {
            createButton(attribute: customBubbleAttribute)
        }
        
        guard attributes.count > 0 else { return }
        isAnimating = true
        
        parentView.addSubview(self)

        faderView.frame = parentView.bounds
        faderView.backgroundColor = faderColor
        faderView.alpha = 0
        parentView.insertSubview(faderView, belowSubview: self)
        UIView.animate(withDuration: 0.25) {
                self.faderView.alpha = self.faderAlpha
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(SwiftShareBubbles.faderViewTapped(_:)))
        faderView.addGestureRecognizer(tap)
        
        let bubbleDistanceFromPivot = Double(self.radius - self.bubbleRadius)
        
        let bubblesBetweenAngel = Float(360 / attributes.count)
        let angely = ((180 - bubblesBetweenAngel) * 0.5)
        let startAngel = 180 - angely

        var coordinates = [CGPoint]()
        
        for (index, button) in buttons.enumerated() {
            button.tag = index
            
            let angle = startAngel + Float(index) * bubblesBetweenAngel
            let x = (CGFloat) (cos(Double(angle) * Double.pi / 180) * bubbleDistanceFromPivot + Double(radius));
            let y = (CGFloat) (sin(Double(angle) * Double.pi / 180) * bubbleDistanceFromPivot + Double(radius));
            
            let coordinate = CGPoint(x: x, y: y)
            coordinates.append(coordinate)
            button.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            button.center = CGPoint(x: CGFloat(radius), y: CGFloat(radius))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 * Double(index)) {
                self.showBubbleWithAnimation(button: button, coordinate: coordinate)
            }
        }

    }

    public func hide() {
        guard !isAnimating else { return }
        
        for (index, button) in buttons.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 * Double(index)) {
                self.hideBubbleWithAnimation(button: button)
            }
        }
    }

    @objc func faderViewTapped(_ sender: UITapGestureRecognizer) {
        hide()
    }

    @objc func buttonTapped(_ sender: UIButton) {
        let attribute = attributes[sender.tag]
        print("\(attribute.bubbleId) tapped")
        delegate?.bubblesTapped(bubbles: self, bubbleId: attribute.bubbleId)
        hide()
    }

    private func createButton(attribute: ShareAttirbute) {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(SwiftShareBubbles.buttonTapped(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 2 * self.bubbleRadius, height: 2 * self.bubbleRadius)
        
        // Circle background
        let circle = UIView(frame: CGRect(x: 0, y: 0, width: 2 * self.bubbleRadius, height: 2 * self.bubbleRadius))
        circle.backgroundColor = attribute.backgroundColor
        circle.layer.cornerRadius = CGFloat(bubbleRadius)
        circle.layer.masksToBounds = true
        circle.isOpaque = false
        circle.alpha = 0.97
        
        // Circle icon
        let iconView = UIImageView(image: attribute.icon)
        var f = iconView.frame
        f.origin.x = (CGFloat) ((circle.frame.size.width - f.size.width) * 0.5);
        f.origin.y = (CGFloat) ((circle.frame.size.height - f.size.height) * 0.5);
        iconView.frame = f;
        circle.addSubview(iconView)
        
        button.setBackgroundImage(imageWith(view: circle), for: UIControl.State.normal)
        buttons.append(button)
        attributes.append(attribute)

        self.addSubview(button)
    }

    private func imageWith(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    private func showBubbleWithAnimation(button: UIButton, coordinate: CGPoint) {
        UIView.animate(withDuration: 0.25, animations: { 
            button.center = coordinate
            button.alpha = 1;
            button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2);
        }) { (finished) in
            UIView.animate(withDuration: 0.25, animations: { 
                button.transform = CGAffineTransform(scaleX: 0.8, y: 0.8);
            }, completion: { (finished) in
                if(button.tag == self.buttons.count - 1) {
                    self.isAnimating = false
                }
                button.layer.shadowColor = UIColor.black.cgColor
                button.layer.shadowOpacity = 0.2
                button.layer.shadowOffset = CGSize(width: 0, height: 1)
                button.layer.shadowRadius = 2
            })
        }
        
    }
    
    private func hideBubbleWithAnimation(button: UIButton) {
        UIView.animate(withDuration: 0.25, animations: {
            button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2);
        }) { (finished) in
            UIView.animate(withDuration: 0.25, animations: {
                button.center = CGPoint(x: self.radius, y: self.radius)
                button.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                button.alpha = 0
            }, completion: { (finished) in
                if(button.tag == self.buttons.count - 1) {
                    self.isAnimating = false
                    self.faderView.removeFromSuperview()
                    self.removeFromSuperview()
                    self.isAnimating = false
                    self.delegate?.bubblesDidHide(bubbles: self)
                }
                button.removeFromSuperview()
            })
        }
    }

}
