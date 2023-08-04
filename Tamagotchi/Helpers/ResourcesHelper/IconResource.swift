//
//  IconResources.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import Foundation
import UIKit

extension UIImage{
    enum IconType:String{
        case food = "drop.circle",water = "leaf.circle"
    }
    enum SettingType:String{
        case name = "pencil"
        case change = "moon.fill"
        case reset = "arrow.clockwise"
    }
    static func getIcon(eat type:IconType)->UIImage{
        UIImage(systemName: type.rawValue) ?? UIImage()
    }
    static func getIcon(setting type:SettingType)->UIImage{
        UIImage(systemName: type.rawValue) ?? UIImage()
    }
}
