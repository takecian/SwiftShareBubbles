//
//  ShareAttirbute.swift
//  SwiftShareBubbles
//
//  Created by FUJIKI TAKESHI on 2017/03/10.
//  Copyright © 2017 com.takecian. All rights reserved.
//

import UIKit

/// Social button attribute. For custom button, custom bubbleId must be other than values define in `enum Bubble`.
public struct ShareAttirbute {
    let bubbleId: Int
    let icon: UIImage
    let backgroundColor: UIColor
    
    public init(bubbleId: Int, icon: UIImage, backgroundColor: UIColor) {
        self.bubbleId = bubbleId
        self.icon = icon
        self.backgroundColor = backgroundColor
    }
}

extension ShareAttirbute {
    static func createFacebook() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.facebook.rawValue, imageName: "icon-facebook", color: UIColor.colorFromRGB("3c5a9a"))!
    }

    static func createTwitter() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.twitter.rawValue, imageName: "icon-twitter", color: UIColor.colorFromRGB("3083be"))!
    }

    static func createLine() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.line.rawValue, imageName: "icon-line", color: UIColor.colorFromRGB("57BE37"))!
    }

    static func createGoogle() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.google.rawValue, imageName: "icon-googleplus", color: UIColor.colorFromRGB("d95433"))!
    }
    
    static func createInstagram() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.instagram.rawValue, imageName: "icon-instagram", color: UIColor.colorFromRGB("2e5e89"))!
    }
    
    static func createLinkedin() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.linkedin.rawValue, imageName: "icon-linkedin", color: UIColor.colorFromRGB("008dd2"))!
    }
    static func createWeibo() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.weibo.rawValue, imageName: "icon-weibo", color: UIColor.colorFromRGB("E6162D"))!
    }
    
    static func createWhatsapp() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.whatsapp.rawValue, imageName: "icon-whatsapp", color: UIColor.colorFromRGB("00B000"))!
    }
    
    static func createPinterest() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.pintereset.rawValue, imageName: "icon-pinterest", color: UIColor.colorFromRGB("b61d23"))!
    }

    static func createYoutube() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.youtube.rawValue, imageName: "icon-youtube", color: UIColor.colorFromRGB("ce3025"))!
    }

    static func createSafari() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.safari.rawValue, imageName: "icon-safari", color: UIColor.colorFromRGB("FFFFFF"))!
    }

    private static func createButton(bubbleId: Int, imageName: String, color: UIColor) -> ShareAttirbute? {
        let classBundle = Bundle(for: SwiftShareBubbles.self)
        guard let bundle = Bundle(path: "\(classBundle.bundlePath)/SwiftShareBubbles.bundle") else { return nil }
        if let icon = UIImage(named: "SwiftShareBubbles.bundle/\(imageName)", in: bundle, compatibleWith: nil) {
            return ShareAttirbute(bubbleId: bubbleId, icon: icon, backgroundColor: color)
        } else if let icon = UIImage(named: imageName, in: bundle, compatibleWith: nil) {
            return ShareAttirbute(bubbleId: bubbleId, icon: icon, backgroundColor: color)
        } else{
            return nil
        }
    }
}
