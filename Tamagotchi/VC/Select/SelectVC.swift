//
//  SelectVC.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import UIKit

class SelectVC: UIViewController{
    static let identifier = "SelectVC"
    enum ViewType{
        case Create
        case Update
    }
    @IBOutlet weak var collectionView: UICollectionView!
//    var items = 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionConfigure()
        self.collectionLayout()
    }
}

extension SelectVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionConfigure(){
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
        100
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectItemCell.identifier, for: indexPath) as? SelectItemCell else {
            print(#function,"\(Self.identifier) 셀 생성 안됨")
            return .init()
        }
        return cell
    }
    
    
}
