//
//  DamaModel.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import Foundation
import UIKit
enum DamaType:Int{
    case ddaggeum,bangsil,banzzak
    var korean:String{
        switch self{
        case .ddaggeum: return "따끔따끔"
        case .bangsil: return "방실방실"
        case .banzzak: return "반짝반짝"
        }
    }
    var description:String{
        return Message.getDescription(dama: self)
    }
    func getImg(level:Int)->UIImage{
        UIImage.getDamaImg(type: self, level: level)
    }
}

struct Dama{
    var type: DamaType
    private let maxGrain: Int = 100
    private let maxWater:Int = 50
    public private(set) var rice_grain: Int
    public private(set) var water_drop: Int
    var level:Int{
        let calc = Double(self.rice_grain) / 5.0 + Double(water_drop) / 2.0
        return Int(calc / 10) > 10 ? 10 : Int(calc / 10)
    }
    mutating func add_grain(count: Int)->Bool {
        guard count < maxGrain else {return false}
        rice_grain += count
        return true
    }
    mutating func add_water(count: Int)-> Bool{
        guard count < maxWater else {return false}
        water_drop += count
        return true
    }
}
