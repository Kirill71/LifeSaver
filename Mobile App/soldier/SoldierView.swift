//
//  SoldierView.swift
//  soldier
//
//  Created by Кирилл Жаренков on 05.12.16.
//  Copyright © 2016 Кирилл Жаренков. All rights reserved.
//

import UIKit

class SoldierView: UIView {

  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {}
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {}
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {}
    
    override func draw(_ rect:CGRect){
       
        let pointSize:CGFloat = 4.0
        var forDraw = [CGPoint]()
        var color = [ UIColor.gray,UIColor.green, UIColor.red]
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(pointSize)
        var temp:(x:UInt,y:UInt)
        for o in a{
            temp = o.getCoord()
            context?.setStrokeColor(color[Int(o.getStatus())].cgColor)
            forDraw.append(CGPoint(x: CGFloat(temp.x), y: CGFloat(temp.y)))
            context?.move(to: CGPoint(x: (forDraw.last?.x)!, y: (forDraw.last?.y)!))
            context?.addLine(to: CGPoint(x: (forDraw.last?.x)! + pointSize, y: (forDraw.last?.y)! + pointSize))
            context?.strokePath()
            
        }
    }
}
