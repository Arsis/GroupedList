//
//  ViewExtension.swift
//  View
//
//  Created by DF on 8/28/18.
//  Copyright © 2018 Lab. All rights reserved.
//

import Foundation

extension UIView {
    public func rotate(duration:TimeInterval, clockwise:Bool) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = clockwise ? Double.pi * 2 : -Double.pi * 2
        animation.duration = duration
        animation.isCumulative = true
        animation.repeatCount = 0
        self.layer.add(animation, forKey: "rotationAnimation")
    }
}
