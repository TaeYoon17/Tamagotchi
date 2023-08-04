//
//  MainVC.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import UIKit

class MainVC:UIViewController{
    static let identifier = "MainVC"
    let usermodel: User? = User.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let usermodel else {
            print("존재하지 않음!!")
            return
        }
        self.navigationItem.title = usermodel.nickName
    }
}
