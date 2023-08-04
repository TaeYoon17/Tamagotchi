//
//  WowModel.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import Foundation
enum Message{
    static private var dummies:[String]{
        ["%@님, 밥주세요.","좋은 하루에요, %@님","%@님이 주신 은혜 꼭 갚을게요."]
    }
    static func get(username:String)->String{
        String(format: dummies.randomElement() ?? "%@님, 밥주세요.", username)
    }
    static func getDescription(dama:DamaType)->String{
        switch dama{
        case .bangsil:
            return "저는 방실방실 다마고치입니당 키는 100km 몸무게는 150톤이에용 성격은 화끈하고 날라다닙니당~! 열심히 잘 먹고 잘 클 자신은 있답니당 방실방실!"
        case .banzzak:
            return "저는 방실방실 다마고치입니당 키는 100km 몸무게는 150톤이에용 성격은 화끈하고 날라다닙니당~! 열심히 잘 먹고 잘 클 자신은 있답니당 방실방실!"
        case .ddaggeum:
            return "저는 방실방실 다마고치입니당 키는 100km 몸무게는 150톤이에용 성격은 화끈하고 날라다닙니당~! 열심히 잘 먹고 잘 클 자신은 있답니당 방실방실!"
        }
    }
}
