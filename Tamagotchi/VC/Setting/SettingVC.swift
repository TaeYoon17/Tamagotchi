//
//  SettingVC.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/05.
//

import Foundation
import UIKit
class SettingVC: UIViewController,SegueProtocol{
    typealias U = String?
    var transitionType: TransitionType?
    var model: U?
    @IBOutlet weak var tableView: UITableView!
    static let identifier = "SettingVC"
    let allSettings = SettingType.allCases
    let usermodel = User.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        print(model, "SettingVC Viewdidload")
        self.view.backgroundColor = .background
        tableView.backgroundColor = .background
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: SettingItemCell.identifier, bundle: nil), forCellReuseIdentifier: SettingItemCell.identifier)
        tableView.rowHeight = 48
        navigationConfigure()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    deinit{
        print("SettingVC Deinit!!")
    }
}

extension SettingVC{
    func navigationConfigure(){
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = .init(image: .init(systemName: "chevron.left")?.applyingSymbolConfiguration(.init(weight: .semibold)), style: .plain, target: self, action: #selector(Self.backBtnTapped(_:)))
        self.navigationItem.title = "설정"
    }
    @objc func backBtnTapped(_ sender: UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
    }
}

extension SettingVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allSettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingItemCell.identifier) as? SettingItemCell else { return .init() }
        let settingType = allSettings[indexPath.row]
        cell.titleLabel.text = settingType.title
        cell.iconImgView.image = settingType.getIcon
        cell.detailVC.text = settingType == .name ? usermodel?.nickName ?? "에러!! 초기화하세요." : ""
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch allSettings[indexPath.row]{
        case .dama:
            guard let vc = storyboard?.instantiateViewController(identifier: SelectVC.identifier) as? SelectVC else {return}
            vc.processType = .Update
            self.navigationController?.pushViewController(vc, animated: true)
        case .name:
            guard let vc = storyboard?.instantiateViewController(identifier: NameSettingVC.identifier) as? NameSettingVC else {return}
            vc.processType = .Update
            self.navigationController?.pushViewController(vc, animated: true)
        case .reset:
            let alert = UIAlertController(title: "데이터 초기화", message: "정말 다시 처음부터 시작하실 건가용?", preferredStyle:  .alert)
            alert.addAction(.init(title: "아냐!", style: .cancel))
            alert.addAction(.init(title: "웅!", style: .default,handler: {[weak self] _ in
                User.reset{[weak self] in
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
                    guard let vc = self?.storyboard?.instantiateViewController(withIdentifier: SelectVC.identifier) as? SelectVC else { return }
                    vc.processType = .Create
                    let nav = UINavigationController(rootViewController: vc)
                    sceneDelegate?.window?.rootViewController = nav
                    sceneDelegate?.window?.makeKeyAndVisible()
                }
            }))
            self.present(alert, animated: true)
        }
    }
}
extension SettingType{
    var title:String{
        switch self{
        case .dama: return "다마고치 변경하기"
        case .name: return "내 이름 설정하기"
        case .reset: return "데이터 초기화"
        }
    }
}
