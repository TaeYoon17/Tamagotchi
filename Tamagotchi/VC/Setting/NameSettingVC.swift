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
        guard let user,let prevName else {return}
        let newName = self.textField.text?.trimmingCharacters(in: [" ","\n"]) ?? ""
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        if user.changeName(newName){
            alert.title = "이름을 변경했어요"
            alert.message = "이젠 \(prevName)에서 \(newName)으로 부를께용"
        }else{
            alert.title = "이름 바꾸기를 실패했어요"
            alert.message = "2자리에서 6자리 사이의 글자 수로 지어주세요."
        }
//        let alert = UIAlertController(title: "이름을 변경했어요", message: "이젠 \(prevName)에서 \(newName)으로 부를께용", preferredStyle: .alert)
            
        alert.addAction(.init(title: "확인", style: .cancel,handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert,animated: true)
        print(#function)
    }
}
