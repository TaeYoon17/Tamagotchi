//
//  SelectPopUpVC.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import UIKit
class SelectPopUpVC:UIViewController,DataProcessable{
    static let identifier = "SelectPopUpVC"
    var damaType:DamaType?
    var processType: DataProcessType?
    var completion: (()->())?
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleWrapperView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    func configure(){
        guard let damaType,let processType else { return }
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        self.rootView.backgroundColor = .background
        self.titleLabel.text = damaType.korean
        self.imageView.image = damaType.getImg()
        self.rootView.layer.cornerRadius = 16
        self.titleWrapperView.layer.cornerRadius = 8
        self.titleWrapperView.layer.borderColor = UIColor.accentColor.cgColor
        self.titleWrapperView.layer.borderWidth = 1
        self.descriptionLabel.text = damaType.description
        switch processType{
        case .Create:
            self.startBtn.setTitle("시작하기", for: .normal)
        case .Update:
            self.startBtn.setTitle("바꾸기", for: .normal)
        default: break
        }
    }
    deinit{
        print("SelectPopUpVC Deinit called!!")
    }
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func startBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true){
            guard let completion = self.completion else {return}
            print("Completion called!!")
            completion()
        }
    }
    
}
