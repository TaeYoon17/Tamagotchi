//
//  UserModel.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import Foundation
class User{
    static func initUser(dama:DamaType){
        if Self.shared != nil { return }
        Self.shared = User(nickName: "대장", dama: .init(type: dama, rice_grain: 0, water_drop: 0))
    }
    static func initUser(user:User){
        Self.shared = user
    }
    static public private(set) var shared: User?
    private var nickName: String
    var dama: Dama
    private init(nickName: String, dama: Dama) {
        self.nickName = nickName
        self.dama = dama
    }
    
    @discardableResult
    func changeName(_ name:String)->Bool{
        if name.count < 2 && name.count > 6{
            return false
        }
        self.nickName = name
        return true
    }
    
    @discardableResult
    func changeDamaType(_ type:DamaType)->Bool{
        if dama.type == type{
            return false
        }
        self.dama.type = type
        return true
    }
}
