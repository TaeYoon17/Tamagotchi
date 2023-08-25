//
//  WowModel.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import Foundation
enum ServiceResources{
    typealias DamaType = Dama.DamaType
    typealias DamaTypeModel = Dama.DamaTypeModel
    typealias EatType = Dama.EatType
    typealias EatTypeModel = Dama.EatTypeModel
    static private var DamaMessageDummies:[String]{
        ["%@님, 밥주세요.","좋은 하루에요, %@님","%@님이 주신 은혜 꼭 갚을게요."]
    }
    static func get(username:String)->String{
        String(format: DamaMessageDummies.randomElement() ?? "%@님, 밥주세요.", username)
    }
    static let damaTypeModels: [Int:DamaTypeModel] = [("따끔따끔","저는 따끔따끔 다마고치입니당 키는 50km 몸무게는 2500톤이에용 성격은 차갑고 시크하죵~! 빨리 먹을것을 내놔 따끔따끔!"),("방실방실","저는 방실방실 다마고치입니당 키는 100km 몸무게는 150톤이에용 성격은 화끈하고 날라다닙니당~! 열심히 잘 먹고 잘 클 자신은 있답니당 방실방실!"),("반짝반짝","저는 반짝반짝 다마고치입니당 키는 200km 몸무게는 77.15925톤이에용 성격은 알 수 없는 매력 덩이리~! 키워보세요 반짝반짝🌠")].enumerated()
        .reduce(into: [:], {
        $0[$1.offset + 1] = DamaTypeModel(id: $1.offset + 1, name: $1.element.0, description: $1.element.1)
    })
    static let eatTypeModels: [Int:EatTypeModel] = [100,50].enumerated().reduce(into: [:]) { partialResult, val in
        partialResult[val.offset + 1] = EatTypeModel(id: val.offset + 1, maxCnt: val.element)
    }
    
}
