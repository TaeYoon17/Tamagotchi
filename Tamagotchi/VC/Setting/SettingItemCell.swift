//
//  SettingItemCell.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/05.
//

import UIKit

class SettingItemCell: UITableViewCell {
    @IBOutlet weak var detailVC: UILabel!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    static let identifier = "SettingItemCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .black
        detailVC.text = ""
        detailVC.font = .systemFont(ofSize: 13)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
