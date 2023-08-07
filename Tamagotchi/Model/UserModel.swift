//
//  UserModel.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import Foundation
class User{
    typealias DamaType = Dama.DamaType
    static func reset(completion:(()->())?){
        User.shared = nil
        UserDefaults.standard.set(nil,forKey: "dama")
        UserDefaults.standard.set(nil,forKey: "username")
        UserDefaults.standard.set(nil,forKey: "User")
        guard let completion else {return}
        completion()
    }
    static func initUser(dama:DamaType){
        if Self.shared != nil { return }
        let dama = Dama(type: dama, rice_grain: 0, water_drop: 0)
        Self.shared = User(nickName: "대장", dama: dama)
        if let encoded = try? JSONEncoder().encode(dama){
            UserDefaults.standard.set(encoded,forKey: "dama")
            UserDefaults.standard.set("대장",forKey: "username")
            UserDefaults.standard.set(true, forKey: "User")
        }else{
            fatalError("제대로 설정되지 않음")
        }
    }
    static var isExist:Bool{
        let exist = UserDefaults.standard.bool(forKey: "User")
        print(#function,exist)
        // 메모리상에 올라가 있으면 저장소에서 다시 부르지 않음
        if exist && Self.shared == nil{ // 저장소에만 있고 아직 안 꺼냄
            let damaData = UserDefaults.standard.data(forKey: "dama")
            let nickname = UserDefaults.standard.string(forKey: "username")
            guard let nickname,let damaData else {return false}
            if let dama = try? JSONDecoder().decode(Dama.self, from: damaData){
                print("디코딩 성공",dama,nickname)
                Self.shared = User(nickName: nickname, dama: dama)
            }else{
                print("디코딩 실패")
            }
        }
        ///1. 존재(무조건 저장소에서 꺼내져 있음)하거나
        ///2. 존재하지 않거나
        return exist
    }
    static public private(set) var shared: User?
    public private(set) var nickName: String{
        didSet{
            print("User의 nicname이 바뀜..!")
            UserDefaults.standard.set(nickName,forKey: "username")
            print("User의 nickname을 저장함..!")
        }
    }
    var dama: Dama{
        didSet{
            print("User의 다마가 바뀜..!")
            if let dama = try? JSONEncoder().encode(dama){
                UserDefaults.standard.set(dama,forKey: "dama")
                print("User의 다마를 저장함..!")
            }
        }
    }
    private init(nickName: String, dama: Dama) {
        self.nickName = nickName
        self.dama = dama
    }
    
    func saveData(){
        if let shared = Self.shared, let dama = try? JSONEncoder().encode(shared.dama){
            UserDefaults.standard.set(dama,forKey: "dama")
            UserDefaults.standard.set(shared.nickName,forKey: "username")
            UserDefaults.standard.set(true, forKey: "User")
            print("저장 성공")
        }else{
            print("저장 실패")
        }
        print(#function)
    }
    
    @discardableResult
    func changeName(_ name:String)->Bool{
        if name.count < 2 || name.count > 6{
            print("이거 실패함 \(name)")
            return false
        }
        self.nickName = name
        return true
    }
    
    @discardableResult
    func changeDamaType(_ type:DamaType)->Bool{
        if dama.type == type{ return false }
        self.dama.type = type
        return true
    }
}
