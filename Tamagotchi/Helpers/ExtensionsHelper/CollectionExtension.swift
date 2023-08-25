//
//  CollectionExtension.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import Foundation
extension Collection{
    subscript(safe idx:Index)->Element?{
        self.indices.contains(idx) ? self[idx] : nil
    }
}
