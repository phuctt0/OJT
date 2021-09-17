//
//  Extension.swift
//  Car Manager
//
//  Created by Trần Thế Phúc on 26/08/2021.
//

import Foundation
import UIKit


extension UIColor {
    static var offWhite = #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1)
    static let newBlue = #colorLiteral(red: 0.1764705926, green: 0.6192968644, blue: 1, alpha: 1)
    static let newBlueLight = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    static let newPurple = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
}

extension UIView {
    func fixShadowPath() {
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }

    func setGradientLayer() {
        // CGColor
        let color1 = UIColor.newBlueLight.cgColor
        let color2 = UIColor.newPurple.cgColor
        let color3 = UIColor.newBlue.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [color1, color2, color3]
        gradientLayer.locations = [0.0, 0.1, 0.3]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 3.0)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

    func addBlur(_ alpha: CGFloat = 1.0) {
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha
        self.insertSubview(effectView, at: 0)
    }

    func setRadius(by radius: CGFloat, isShadow: Bool = true) {
        self.layer.cornerRadius = radius
        if isShadow {
            self.layer.shadowColor = UIColor.gray.cgColor
            self.layer.shadowOffset = .zero
            self.layer.shadowOpacity = 0.3
            self.layer.masksToBounds = false
        }
    }
}
