//
//  IconResources.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import Foundation
import UIKit

extension UIImage{
    static func getIcon(eat type:EatType)->UIImage{
        type.icon
    }
    static func getIcon(setting type:SettingType)->UIImage{
        type.getIcon
    }
}
extension SettingType{
    var getIcon:UIImage{
        var str = ""
        switch self{
        case .dama: str = "moon.fill"
        case .name: str = "pencil"
        case .reset: str = "arrow.clockwise"
        }
        return UIImage(systemName: str) ?? UIImage()
    }
}
