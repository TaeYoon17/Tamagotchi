//
//  DataProcess.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import Foundation
enum DataProcessType{
    case Create
    case Read
    case Update
    case Delete
}
protocol DataProcessable{
    var processType: DataProcessType? {get set}
}

