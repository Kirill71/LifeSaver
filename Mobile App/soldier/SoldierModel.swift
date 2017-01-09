//
//  SoldierModel.swift
//  soldier
//
//  Created by Кирилл on 22.11.16.
//  Copyright © 2016 com.myCompany. All rights reserved.
//

import Foundation
let DEADH:UInt = 0;
let LIFE:UInt = 1;
let HELP:UInt = 2;

struct PulseData{
    var pulse:UInt
    var status:UInt
    var coord:(x:UInt,y:UInt)
    init(){
        self.pulse = 0
        self.status = 0
        self.coord = (0,0)
    }
    mutating func setStatus(_ status:UInt){
        self.status = status
    }
    mutating func setPulse(_ pulse : UInt){
        self.pulse = pulse
    }
    func getStatus()-> UInt{
        return status
    }
    func getPulse()->UInt{
        return pulse
    }
    func getX()-> UInt{
        return coord.x
    }
    func getY()-> UInt{
        return coord.y
    }
    func getCoord() -> (x:UInt, y:UInt){
        return coord
    }
    mutating func setCoord(_ x:UInt, y:UInt){
        self.coord = (x,y)
    }
    func toString()->String{
        var statusStr = ""
        switch status {
            case 0:
                statusStr = "Dead"
            case 1:
                statusStr = "Life"
            case 2:
                statusStr = "Help"
            default:
                statusStr = "undefined"
            }
        
        return " '" + statusStr + "', \(pulse), \(coord.x), \(coord.y)"
    }
}
var a = Array(repeating: PulseData(), count: 10)

func generate(_ a:inout Array<PulseData>){
    for  i in 0..<a.count{
        a[i].setPulse(UInt(arc4random_uniform(220)))
        
        a[i].setCoord(UInt(arc4random_uniform(220) + 30), y: UInt(arc4random_uniform(220)) + 120)
    }
    
}


func calculate (_ arr:inout Array<PulseData>)->Void{

    var pulse:UInt
    for  i in 0..<arr.count {
         pulse = arr[i].getPulse()
        if pulse == 0 && pulse <= 25{
            arr[i].setStatus(DEADH)
        }
        if pulse > 120{
            arr[i].setStatus(HELP)
        }
        if pulse > 25 && pulse < 120{
            arr[i].setStatus(LIFE)
        }
    }
}


