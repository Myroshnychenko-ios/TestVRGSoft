//
//  LoadVC + Animations.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 05.10.2021.
//

import UIKit

extension LoadViewController {
    
    // MARK: - Load view animations
    
    func startAnimate() {
        CATransaction.begin()
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = Double.pi * -4
        animation.duration = 1
        animation.isCumulative = true
        animation.autoreverses = true
        animation.repeatCount = 1
        CATransaction.setCompletionBlock {
            print("end animation")
        }
        logoImageView.layer.add(animation, forKey: "rotationAnimation")
        CATransaction.commit()
    }
}
