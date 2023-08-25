//
//  DamaModel.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import Foundation
import UIKit

struct Dama:Codable{
    typealias Resources = ServiceResources
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
extension Dama{
    // 다마고치별 타입마다 갖고 있어야 할 최소 특성 - 한국 이름, 설명, 이미지
    enum DamaType:Int,CaseIterable,Codable{
        typealias R = Resources
        case ddaggeum = 1,bangsil,banzzak
        var korean:String{ R.damaTypeModels[self.rawValue]?.name ?? "이름이 없습니다." }
        var description:String{ R.damaTypeModels[self.rawValue]?.description ?? "설명이 없습니다." }
        func getImg(level:Int = 6)->UIImage{ UIImage.getDamaImg(level: level,type: self) }
    }
    struct DamaTypeModel{
        let id:Int
        let name:String
        let description:String
    }
}

extension Dama{
    enum EatType:Int,CaseIterable{
        typealias R = Resources
        case water = 1, food
        var icon:UIImage{
            switch self{
            case .food:
                return UIImage(systemName: "leaf.circle") ?? UIImage()
            case .water:
                return UIImage(systemName: "drop.circle") ?? UIImage()
            }
        }
        var maxEat:Int{ R.eatTypeModels[self.rawValue]?.maxCnt ?? 0 }
    }
    struct EatTypeModel{
        let id:Int
        let maxCnt:Int
    }
}
