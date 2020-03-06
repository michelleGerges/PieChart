//
//  PieChartView.swift
//  PieChartDemo
//
//  Created by Michele on 3/4/20.
//  Copyright © 2020 Michelle. All rights reserved.
//

import UIKit

class PieChartItem {
    
    let color : UIColor!
    var value  : CGFloat!
    
    init(_ color :UIColor , _ value : CGFloat) {
        
        self.color = color
        self.value = value
    }
}

class PieChartView: UIView {
    
    var animationDuration: Double = 1
    var addAnimation: Bool = true
    var sperator: CGFloat = 2.0
    
    func drawChart(_ items : [PieChartItem]){
        
        var totalValue: CGFloat = 0.0
        
        items.forEach {
            totalValue += $0.value
        }
        
        if totalValue == 0 {
            items.forEach {
                $0.value = 1
            }
            totalValue = CGFloat(items.count)
        }
        
        var cursor : CGFloat = 0.0
        for item in items {
            self.drawSlice(rect: self.bounds, startPercent: cursor, endPercent: cursor + (item.value / totalValue), color: item.color)
            cursor += (item.value / totalValue)
        }
        
        if addAnimation {
            self.addClockWipeAnimation()
        }
    }
    
    private func drawSlice(rect: CGRect, startPercent: CGFloat, endPercent: CGFloat, color: UIColor) {
        
        if startPercent == endPercent {
            return
        }
        
        let center = CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        
        let startAngle = (startPercent  ) * ( CGFloat(Double.pi) * 2 ) - 0.5 * CGFloat(Double.pi)
        let endAngle = ( endPercent ) * ( CGFloat(Double.pi) * 2 ) - 0.5 * CGFloat(Double.pi)
        
        let slicePath = UIBezierPath()
        if startPercent == 0.0 && endPercent == 1.0 {
            
            slicePath.move(to: CGPoint(x: rect.origin.x + rect.width / 2, y: 0))
        }else{
            slicePath.move(to: center)
        }
        
        slicePath.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        slicePath.close()
    
        let shapeLayer = CAShapeLayer()
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        
        shapeLayer.frame = self.bounds
        shapeLayer.masksToBounds = true
        
        shapeLayer.path = slicePath.cgPath
        
        shapeLayer.fillColor = color.cgColor
        shapeLayer.strokeColor = self.backgroundColor?.cgColor
        
        shapeLayer.lineWidth = self.sperator
        
        self.layer.addSublayer(shapeLayer)
    }
    
    private func addClockWipeAnimation() {
        
        let rect = self.bounds
        let center = CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height / 2)
        
        let radius = min(rect.width, rect.height) / 2
        
        let startAngle = -0.5 * CGFloat(Double.pi)
        let endAngle = ( CGFloat(Double.pi) * 2 ) - 0.5 * CGFloat(Double.pi)
        
        let animationPath = UIBezierPath()
        
        animationPath.move(to: CGPoint(x: rect.origin.x + rect.width / 2, y: 0))
        animationPath.addArc(withCenter: center, radius: radius, startAngle: endAngle, endAngle: startAngle, clockwise: false)
        animationPath.close()
        
        let animationLayer = CAShapeLayer()
        
        animationLayer.frame = self.bounds
        animationLayer.masksToBounds = true
        
        animationLayer.path = animationPath.cgPath
        
        animationLayer.fillColor = UIColor.clear.cgColor
        animationLayer.strokeColor = self.backgroundColor?.cgColor
        
        animationLayer.lineWidth = 2 * radius
        
        self.layer.addSublayer(animationLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        CATransaction.begin()
        animation.fromValue = 1
        animation.toValue = 0
        
        animation.duration = CFTimeInterval(animationDuration)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn) // animation curve is Ease In
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        CATransaction.setCompletionBlock {
            animationLayer.removeFromSuperlayer()
        }
        animationLayer.add(animation, forKey: "strokeEnd")
        CATransaction.commit()
    }
}
