//
//  SelectVC.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import UIKit
class SelectVC: UIViewController,DataProcessable{
    var processType: DataProcessType?
    static let identifier = "SelectVC"
    @IBOutlet weak var collectionView: UICollectionView!
    var damas:[DamaType] = DamaType.allCases
    override func viewDidLoad() {
        super.viewDidLoad()
        guard processType != nil else { fatalError("데이터 처리 타입을 정의하지 않음!!") }
        self.view.backgroundColor = .background
        self.navigationBarConfigure()
        self.collectionConfigure()
        self.collectionLayout()
    }
    deinit{
        print(SelectVC.identifier,"deinit called!!")
    }
    
    func navigationBarConfigure(){
        guard let processType else {return}
        switch processType {
        case .Create:
            self.navigationItem.title = "다마고치 선택하기"
        default: break
        }
    }
}

extension SelectVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionConfigure(){
        self.collectionView.backgroundColor = .background
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(.init(nibName: SelectItemCell.identifier, bundle: nil),
                                     forCellWithReuseIdentifier: SelectItemCell.identifier)
    }
    func collectionLayout(){
        let layout = UICollectionViewFlowLayout()
        
        let spacing:CGFloat = UIScreen.main.bounds.width >= 390 ? 20 : 16
        let itemWidth = collectionView.getCellWidth(itemCnt: 3, spacing: spacing)
        layout.itemSize = .init(width: itemWidth, height: itemWidth + (spacing == 16 ? 34 : 38))
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = .init(top: spacing, left: spacing, bottom: spacing, right: spacing)
        self.collectionView.collectionViewLayout = layout
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        40
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectItemCell.identifier, for: indexPath) as? SelectItemCell else {
            print(#function,"\(Self.identifier) 셀 생성 안됨")
            return .init()
        }
        if let dama = damas[safe: indexPath.row]{
            cell.damaTypeLabel.text = "\(dama.korean) 다마고치"
            cell.damaImgView.image = dama.getImg()
        }else{
            cell.damaTypeLabel.text = "준비중이에요"
            cell.damaImgView.image = UIImage.getDamaImg()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let type = damas[safe: indexPath.row], let vc = storyboard?.instantiateViewController(identifier: SelectPopUpVC.identifier) as? SelectPopUpVC{
            vc.damaType = type
            vc.processType = processType
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            switch processType{
            case .Create:
                vc.completion = {[weak self] in
                    User.initUser(dama: type)
                    if User.shared == nil{
                        let vc = UIAlertController(title: "이 친구로 만들 수 없어요", message: nil, preferredStyle: .alert)
                        vc.addAction(.init(title: "돌아가기", style: .cancel))
                        self?.present(vc,animated: true)
                        return
                    }
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
                    guard let vc = self?.storyboard?.instantiateViewController(withIdentifier: MainVC.identifier) as? MainVC else { return }
                    let nav = UINavigationController(rootViewController: vc)
                    sceneDelegate?.window?.rootViewController = nav
                    sceneDelegate?.window?.makeKeyAndVisible()
                }
            default: break
            }
            present(vc, animated: true)
        }
    }
}
