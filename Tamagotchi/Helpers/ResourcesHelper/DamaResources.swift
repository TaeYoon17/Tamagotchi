//
//  DamaImageResource.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import Foundation
import UIKit
extension UIImage{
    static func getDamaImg(level: Int = 0,type:DamaType? = nil)->UIImage{
        print(type, level)
        guard let type, level > 0, level <= 10 else {
            return UIImage(named: "noImage")! }
        if level == 10{
            return UIImage(named: "\(type.rawValue)-\(9)")!
        }
        print("\(type.rawValue)-\(level)")
        return UIImage(named: "\(type.rawValue)-\(level)")!
    }
}
