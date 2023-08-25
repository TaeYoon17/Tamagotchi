//
//  SelectItemCell.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import UIKit

class SelectItemCell: UICollectionViewCell {
    @IBOutlet weak var damaImgView: UIImageView!
    @IBOutlet weak var damaTypeLabel: UILabel!
    @IBOutlet weak var wrapperView: UIView!
    static let identifier = "SelectItemCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.wrapperView.backgroundColor = .blsrue
        wrapperView.layer.borderWidth = 1
        wrapperView.layer.cornerRadius = 4
        wrapperView.layer.borderColor = UIColor.accentColor.cgColor
    }

}
