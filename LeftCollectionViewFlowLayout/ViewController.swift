//
//  ViewController.swift
//  LeftCollectionViewFlowLayout
//
//  Created by 胡智林 on 2018/7/8.
//  Copyright © 2018年 胡智林. All rights reserved.
//

import UIKit
import SnapKit
class ViewController: UIViewController {
    lazy var collectionView: UICollectionView = {
        let layout = ItemLeftCollectionViewFlowLayout.init()
        //let layout = UICollectionViewFlowLayout.init()
        let collView = UICollectionView.init(frame: .init(x: 20, y: 0, width: view.frame.width-40, height: view.frame.height), collectionViewLayout: layout)
        collView.backgroundColor = UIColor.white
        collView.delegate = self
        collView.dataSource = self
        collView.showsVerticalScrollIndicator = false
        collView.register(SearchingCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "SearchingCollectionViewCell")
        return collView
    }()
    lazy var dataSources: [String] = {
        let string = "即便在Realm这样的NoSQL的数据库中，在进行查询时"
        var resArr = [String]()
        for (indx , _) in string.enumerated(){
             let endindex = string.index(string.startIndex, offsetBy: indx)
            let subStr =  string[ ...endindex]
           
            resArr.append(String(subStr))
        }
       
       
        
        return resArr
   }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(collectionView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = dataSources[indexPath.row]
        let width = SearchingCollectionViewCell.getCellW(with: model as NSString)
                ///防止宽度 超过collectionView的宽度
        return CGSize.init(width:  min(width, collectionView.frame.width), height: 30)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSources.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchingCollectionViewCell", for: indexPath) as! SearchingCollectionViewCell
        cell.titleLabel.text = dataSources[indexPath.row]
        
        return cell
    }
}
class SearchingCollectionViewCell: UICollectionViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.layer.cornerRadius = 4
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 0.8
        label.clipsToBounds = true
        
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.right.equalTo(0)
        }
    }
    static func getCellW(with title: NSString) -> CGFloat{
        let titleSize = title.size(withAttributes: [.font: UIFont.systemFont(ofSize: 15)])
        return titleSize.width + 20
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

