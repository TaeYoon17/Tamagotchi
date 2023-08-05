//
//  NameSettingVC.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/05.
//

import UIKit

class NameSettingVC:UIViewController,DataProcessable{
    static let identifier = "NameSettingVC"
    var processType: DataProcessType?
    @IBOutlet weak var textField: UITextField!
    let user = User.shared
    var prevName:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user else {return}
        prevName = user.nickName
        navigationConfigure()
        self.view.backgroundColor = .background
        let layer = CALayer()
        layer.frame = .init(x: 0,y: textField.bounds.height - 4, width: textField.bounds.width, height: 1)
        layer.backgroundColor = UIColor.accentColor.cgColor
        layer.borderColor = UIColor.accentColor.cgColor
        self.textField.placeholder = "이름을 입력하세요"
        self.textField.font = .systemFont(ofSize: 16, weight: .medium)
        self.textField.textColor = .accentColor
        self.textField.text = user.nickName
        self.textField.layer.addSublayer(layer)
        self.textField.delegate = self
        btnEnable()
    }
    @IBAction func rootViewTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}
extension NameSettingVC:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) { btnEnable() }
    func textFieldDidChangeSelection(_ textField: UITextField) { btnEnable() }
    func textFieldDidEndEditing(_ textField: UITextField) { btnEnable() }
    func btnEnable(){
        self.navigationItem.rightBarButtonItem?.isEnabled = textField.text != "" && textField.text != prevName
    }
}
extension NameSettingVC{
    func navigationConfigure(){
        self.navigationItem.title = "대장님 이름 정하기"
        self.navigationItem.rightBarButtonItem = .init(title: "저장", style: .plain, target: self, action: #selector(Self.saveBtnTapped(_:)))
    }
    @objc func saveBtnTapped(_ sender: UIBarButtonItem){
        print(#function)
    }
}
