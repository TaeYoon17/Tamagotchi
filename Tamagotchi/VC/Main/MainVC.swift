//
//  MainVC.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import UIKit
import Combine
class MainVC:UIViewController{
    typealias EatType = Dama.EatType
    static let identifier = "MainVC"
    // Model
    let usermodel: User? = User.shared
    // View
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var damaImgView: UIImageView!
    @IBOutlet weak var titleWrapperView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infosLabel: UILabel!
    @IBOutlet weak var eatTextField: UITextField!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var eatBtns: [UIButton]!
    let pickerView = UIPickerView()
    
    // VC State Propertys
    var inputEatType: Dama.EatType?{
        didSet{
            pickerView.tag = inputEatType!.rawValue
            self.pickerView.reloadAllComponents()
        }
    }
    var subscription = Set<AnyCancellable>()
    var inputCount = [Dama.EatType.water:1,.food:1]
    var infosString:String{
        guard let usermodel else {return "계정이 없어용"}
        return "LV\(usermodel.dama.level) · 밥알 \(usermodel.dama.rice_grain) · 물방울 \(usermodel.dama.water_drop)"
    }
    func bindingModel(){
        guard let usermodel else {return}
        self.infosLabel.text = infosString
        self.navigationItem.title = usermodel.nickName
        self.commentLabel.text = ServiceResources.get(username: usermodel.nickName)
        self.titleLabel.text = "\(usermodel.dama.type.korean) 다마고치"
        self.damaImgView.image = usermodel.dama.getImg()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard usermodel != nil else {
            print("존재하지 않음!!") // 여기에 에러 처리 로직 만들어야함
            return
        }
        navigationConfigure()
        designConfigure()
        textFields.forEach { $0.delegate = self; $0.inputView = pickerView }
        self.pickerView.delegate = self; self.pickerView.dataSource = self
        bindingModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        bindingModel()
    }
    deinit{
        print("MainVC 사라짐!!")
    }
    func dismissKeyboard(){
        self.view.frame.origin.y = 0
        view.endEditing(true)
    }

}
extension MainVC{
    @IBAction func rootViewTapped(_ sender: UITapGestureRecognizer) { dismissKeyboard() }
    @IBAction func eatBtnTapped(_ sender: UIButton) {
        print(#function)
        guard let btnEatType = Dama.EatType(rawValue: sender.tag),
        let eatCount = inputCount[btnEatType],let usermodel else {return}
        usermodel.dama.eat(type: btnEatType, count: eatCount)
        bindingModel()
        if let textfield = textFields.first(where: {$0.tag == sender.tag}){
            textfield.text = ""
            self.inputCount[btnEatType] = 1
        }
        dismissKeyboard()
    }
}
extension MainVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.frame.origin.y = -150
        textField.text = ""
        textField.placeholder = ""
        if let eatType = EatType(rawValue: textField.tag){
            self.inputEatType = eatType
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let eatType = EatType(rawValue: textField.tag) else {return}
        switch eatType{
        case .food:
            textField.placeholder = "밥주세용"
        case .water:
            textField.placeholder = "물주세용"
        }
    }
}
extension MainVC: UIPickerViewDelegate,UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let inputEatType else { return 0 }
        return inputEatType.maxEat - 1
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let inputEatType,
              let textField = self.textFields.first(where: { $0.tag == inputEatType.rawValue})
            else { return }
        inputCount[inputEatType] = row + 1
        textField.text = "\(row + 1)개"
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(row + 1) 개"
    }
}

extension MainVC{
    func navigationConfigure(){
        guard let usermodel else { return }
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationItem.title = usermodel.nickName
        self.view.backgroundColor = .background
        self.navigationItem.rightBarButtonItem = .init(image: .init(systemName: "person.circle"), style: .plain, target: self, action: #selector(Self.settingTapped(_:)))
        self.navigationItem.rightBarButtonItem?.tintColor = .accentColor
    }
    @objc func settingTapped(_ sender: UIBarButtonItem){
        guard let vc = storyboard?.instantiateViewController(identifier: SettingVC.identifier) as? SettingVC else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func designConfigure(){
        self.titleWrapperView.layer.borderColor = UIColor.accentColor.cgColor
        self.titleWrapperView.layer.borderWidth = 1
        self.titleWrapperView.layer.cornerRadius = 8
        
        self.view.backgroundColor = .background
        self.textFields.forEach{
            $0.font = .systemFont(ofSize: 15, weight: .semibold)
            $0.textColor = .accentColor
            $0.setValue(UIColor.lightGray, forKeyPath: "placeholderLabel.textColor")
            let layer = CALayer()
            layer.frame = .init(x: 8, y: $0.bounds.height - 4, width: $0.bounds.width, height: 0.8)
            layer.borderColor = UIColor.accentColor.cgColor
            layer.borderWidth = 1
            $0.layer.addSublayer(layer)
            $0.clipsToBounds = true
        }
        self.eatBtns.forEach { btn in
            let eatType = EatType(rawValue: btn.tag) ?? .food
            var config = UIButton.Configuration.plain()
            config.background.strokeColor = .accentColor
            config.imagePadding = 4
            config.contentInsets = .init(top: 4, leading: 12, bottom: 4, trailing: 12)
            config.attributedTitle = .init(eatType.btnString)
            config.attributedTitle?.font = .systemFont(ofSize: 15, weight: .medium)
            btn.setPreferredSymbolConfiguration(.init(scale: .medium), forImageIn: .normal)
            btn.setImage(UIImage.getIcon(eat: eatType), for: .normal)
            config.baseForegroundColor = .accentColor
//            btn.setTitle(eatType.btnString, for: .normal)
            btn.configuration = config
        }
    }
}
fileprivate extension Dama.EatType{
    var btnString:String{
        switch self{
        case .food: return "밥먹기"
        case .water: return "물먹기"
        }
    }
}
extension Dama{
    func getImg()->UIImage{
        self.type.getImg(level: self.level)
    }
}
