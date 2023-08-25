//
//  CollectionViewExtension.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import UIKit

extension UICollectionView{
    func getCellWidth(itemCnt: Int,spacing:Int)->CGFloat{
        getCellWidth(itemCnt: itemCnt, spacing: CGFloat(spacing))
    }
    func getCellWidth(itemCnt: Int,spacing:CGFloat)->CGFloat{
        let screenWidth = UIScreen.main.bounds.width
        return (screenWidth - CGFloat(spacing * CGFloat((itemCnt + 1)))) / CGFloat(itemCnt)
    }
}
