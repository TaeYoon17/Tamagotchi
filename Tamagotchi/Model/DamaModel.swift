//
//  DamaModel.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import Foundation
import UIKit

// 다마고치별 타입마다 갖고 있어야 할 최소 특성 - 한국 이름, 설명, 이미지
enum DamaType:Int,CaseIterable,Codable{
    case ddaggeum = 1,bangsil,banzzak
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
    func getImg(level:Int = 6)->UIImage{
        return UIImage.getDamaImg(level: level,type: self)
    }
}

struct Dama:Codable{
    var type: DamaType
    static private let maxGrain: Int = 100
    static private let maxWater:Int = 50
    public private(set) var rice_grain: Int
    public private(set) var water_drop: Int
    var level:Int{
        let calc = Double(self.rice_grain) / 5.0 + Double(water_drop) / 2.0
        return Int(calc / 10) > 10 ? 10 : Int(calc / 10)
    }
    mutating func add_grain(count: Int)->Bool {
        guard count < Self.maxGrain else {return false}
        rice_grain += count
        return true
    }
    mutating func add_water(count: Int)-> Bool{
        guard count < Self.maxWater else {return false}
        water_drop += count
        return true
    }
}
