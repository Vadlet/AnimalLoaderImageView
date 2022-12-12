//
//  CircularLoaderView.swift
//  AnimationLoaderImageView
//
//  Created by Vadlet on 12.12.2022.
//

import UIKit

class CircularLoaderView: UIView {
    
    let circularPathLayer = CAShapeLayer()
    let circularRadius: CGFloat = 20
    
    
    var progress: CGFloat {
        get {
            circularPathLayer.strokeEnd
        }
        set {
            if newValue > 1 {
                circularPathLayer.strokeEnd = 1
            } else if newValue < 0 {
                circularPathLayer.strokeEnd = 0
            } else {
                circularPathLayer.strokeEnd = newValue
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circularPathLayer.frame = bounds
        circularPathLayer.path = circularPath().cgPath
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        progress = 0
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        //Устанавливаем границы
        circularPathLayer.frame = bounds
        circularPathLayer.lineWidth = 4
        circularPathLayer.fillColor = UIColor.clear.cgColor
        circularPathLayer.strokeColor = UIColor.orange.cgColor
        layer.addSublayer(circularPathLayer)
    }
    
    func cirucarFrame() -> CGRect {
        var circularFrame = CGRect(x: 0, y: 0, width: 2 * circularRadius, height: 2 * circularRadius)
        let circularPathBounds = circularPathLayer.bounds
        circularFrame.origin.x = circularPathBounds.midX - circularFrame.midX
        circularFrame.origin.y = circularPathBounds.midY - circularFrame.midY
        return circularFrame

    }
    
    func circularPath() -> UIBezierPath {
        UIBezierPath(ovalIn: cirucarFrame())
    }
    
    func reveal() {
        backgroundColor = .clear
        progress = 1
        
        circularPathLayer.removeAnimation(forKey: "strokeEnd")
        
        circularPathLayer.removeFromSuperlayer()
        superview?.layer.mask = circularPathLayer
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let finalRadius = sqrt((center.x * center.x) + (center.y * center.y))
        let radiusInset = finalRadius - circularRadius
        let outerRect = cirucarFrame().insetBy(dx: -radiusInset, dy: -radiusInset)
        let toPath = UIBezierPath(ovalIn: outerRect).cgPath
        
        let fromPath = circularPathLayer.path
        let fromLineWith = circularPathLayer.lineWidth
        
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        circularPathLayer.lineWidth = 2 * finalRadius
        circularPathLayer.path = toPath
        CATransaction.commit()
        
        
        let lineWidthAnimation = CABasicAnimation(keyPath: "lineWidth")
        lineWidthAnimation.fromValue = fromLineWith
        lineWidthAnimation.toValue = 2 * finalRadius
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = fromPath
        pathAnimation.toValue = toPath
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 1
        groupAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        groupAnimation.animations = [pathAnimation, lineWidthAnimation]
        groupAnimation.delegate = self
        circularPathLayer.add(groupAnimation, forKey: "strokeWidth")
        
    }
}


extension CircularLoaderView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        superview?.layer.mask = nil
    }
}
