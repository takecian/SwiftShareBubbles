//
//  ShareAttirbute.swift
//  SwiftShareBubbles
//
//  Created by FUJIKI TAKESHI on 2017/03/10.
//  Copyright © 2017 com.takecian. All rights reserved.
//

import UIKit

struct ShareAttirbute {
    let bubbleId: Int
    let icon: UIImage
    let backgroundColor: UIColor
}

extension ShareAttirbute {
    static func createFacebook() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.facebook.rawValue, imageName: "icon-facebook", color: UIColor.colorFromRGB("3c5a9a"))!
    }

    static func createTwitter() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.twitter.rawValue, imageName: "icon-twitter", color: UIColor.colorFromRGB("3083be"))!
    }

    static func createLine() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.twitter.rawValue, imageName: "icon-line", color: UIColor.colorFromRGB("57BE37"))!
    }

    static func createGoogle() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.facebook.rawValue, imageName: "icon-googleplus", color: UIColor.colorFromRGB("d95433"))!
    }
    
    static func createInstagram() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.twitter.rawValue, imageName: "icon-instagram", color: UIColor.colorFromRGB("2e5e89"))!
    }
    
    static func createLinkedin() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.twitter.rawValue, imageName: "icon-linkedin", color: UIColor.colorFromRGB("008dd2"))!
    }
    static func createWeibo() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.facebook.rawValue, imageName: "icon-weibo", color: UIColor.colorFromRGB("E6162D"))!
    }
    
    static func createWhatsapp() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.twitter.rawValue, imageName: "icon-whatsapp", color: UIColor.colorFromRGB("00B000"))!
    }
    
    static func createPinterest() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.twitter.rawValue, imageName: "icon-pinterest", color: UIColor.colorFromRGB("b61d23"))!
    }

    static func createYoutube() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.twitter.rawValue, imageName: "icon-youtube", color: UIColor.colorFromRGB("ce3025"))!
    }

    static func createSafari() -> ShareAttirbute {
        return createButton(bubbleId: Bubble.twitter.rawValue, imageName: "icon-safari", color: UIColor.colorFromRGB("FFFFFF"))!
    }

    private static func createButton(bubbleId: Int, imageName: String, color: UIColor) -> ShareAttirbute? {
        let classBundle = Bundle(for: SwiftShareBubbles.self)
        guard let bundle = Bundle(path: "\(classBundle.bundlePath)/SwiftShareBubbles.bundle") else { return nil }
        guard let icon = UIImage(named: imageName, in: bundle, compatibleWith: nil) else { return nil }
        return ShareAttirbute(bubbleId: bubbleId, icon: icon, backgroundColor: color)
    }
}
