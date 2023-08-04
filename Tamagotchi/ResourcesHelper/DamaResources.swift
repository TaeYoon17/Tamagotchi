//
//  DamaImageResource.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import Foundation
import UIKit
extension UIImage{
    static func getDamaImg(type:DamaType,level: Int)->UIImage{
        if level == 10{
            return UIImage(named: "\(type.rawValue)-\(level - 1)")!
        }
        return UIImage(named: "\(type.rawValue)-\(level)")!
    }
}
