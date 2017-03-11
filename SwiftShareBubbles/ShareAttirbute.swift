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
    static func createFacebookButton() -> ShareAttirbute {
        return createButton(bubbleId: 0, imageName: "icon-facebook", color: UIColor.blue)!
    }

    static func createButton(bubbleId: Int, imageName: String, color: UIColor) -> ShareAttirbute? {
        let classBundle = Bundle(for: SwiftShareBubbles.self)
        guard let bundle = Bundle(path: "\(classBundle.bundlePath)/SwiftShareBubbles.bundle") else { return nil }
        
        guard let icon = UIImage(named: imageName, in: bundle, compatibleWith: nil) else { return nil }
        
        return ShareAttirbute(bubbleId: bubbleId, icon: icon, backgroundColor: color)
    }
}
