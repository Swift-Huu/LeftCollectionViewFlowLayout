//
//  ItemLeftCollectionViewFlowLayout.swift
//  LeftCollectionViewFlowLayout
//
//  Created by 胡智林 on 2018/7/8.
//  Copyright © 2018年 胡智林. All rights reserved.
//

import UIKit

class ItemLeftCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override var flipsHorizontallyInOppositeLayoutDirection: Bool{
        return true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        ///默认所有的cell 的间距相同，且右边靠边， 所以需要对所有的cell向左移
        let supAttributes = super.layoutAttributesForElements(in: rect)
       // return supAttributes
        
        guard let  supAtts = supAttributes   else {
            return supAttributes
        }
        var cellX: CGFloat = 0
        
        for layoutAttr in supAtts {
            if layoutAttr.representedElementCategory == .cell{
                var layFrame = layoutAttr.frame
                if layFrame.origin.x == 0{
                    cellX = layFrame.width
                    layoutAttr.frame = layFrame
                    continue
                }
                if layFrame.origin.x < cellX{
                    
                    layFrame.origin.x = 0
                    cellX = layFrame.width
                    layoutAttr.frame = layFrame
                    continue
                }
                if cellX > 0{
                    let collDele = collectionView?.delegate as? UICollectionViewDelegateFlowLayout
                    if let minInteritemSpace = collDele?.collectionView?(collectionView!, layout: self, minimumInteritemSpacingForSectionAt: layoutAttr.indexPath.section){
                        ///如果有代理 就用代理的值
                         layFrame.origin.x = cellX + minInteritemSpace
                        
                    }else{
                        layFrame.origin.x = cellX + minimumInteritemSpacing
                    }
                    
                }else{
                    // cellX = 0时
                    layFrame.origin.x = 0
                }
                cellX = layFrame.origin.x + layFrame.width
                layoutAttr.frame = layFrame
            }
        }
        
        return supAttributes
    }

}
