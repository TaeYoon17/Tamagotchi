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
enum EatType:Int,CaseIterable{
    case water = 1, food
    var icon:UIImage{
        switch self{
        case .food:
            return UIImage(systemName: "drop.circle") ?? UIImage()
        case .water:
            return UIImage(systemName: "leaf.circle") ?? UIImage()
        }
    }
    var maxEat:Int{
        switch self{
        case .food: return 50
        case .water: return 100
        }
    }
}

struct Dama:Codable{
    var type: DamaType
    public private(set) var rice_grain: Int
    public private(set) var water_drop: Int
    var level:Int{
        let calc = Double(self.rice_grain) / 5.0 + Double(water_drop) / 2.0
        
        return Int(calc / 10) > 10 ? 10 : Int(calc / 10) <= 0 ? 1 : Int(calc / 10)
    }
    @discardableResult
    mutating func eat(type: EatType,count: Int)->Bool {
        guard count < type.maxEat else { return false}
        switch type{
        case .food: rice_grain += count
        case .water: water_drop += count
        }
        print("정보입력완료..!")
        return true
    }
}
