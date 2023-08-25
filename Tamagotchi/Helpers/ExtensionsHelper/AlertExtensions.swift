//
//  AlertExtensions.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/17.
//

import UIKit

extension UIViewController{
    func showAlert(title:String,message:String,cancel:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: cancel, style: .cancel))
        present(alert,animated: true)
    }
}
