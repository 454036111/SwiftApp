//
//  BroserCollectFlowLayout.swift
//  JPhotoBrowser
//
//  Created by laijihua on 16/2/22.
//  Copyright © 2016年 laijihua. All rights reserved.
//

import UIKit


// 还有问题
class BroserCollectFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.scrollDirection = .Horizontal
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 10
        self.itemSize = CGSize(width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height-64-49)
    }
    
    
    //proposedContentOffset 内容视图的偏移量 velocity速度
    //offsetAdjustment 应该调整的位置,设为最大为了循环取出最小
    //horizontalCenter 内容的最左边到视图中心的位置
    //targetRect 当前看到窗口中得边框
    //layoutAttributes 视图中每一个cell的布局属性包含长宽等
    //contentInset 内容视图在frame中得偏移上下左右等
    override func targetContentOffsetForProposedContentOffset(var proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = self.collectionView else {return CGPointZero}
        
        var offSetAdjustment: CGFloat = CGFloat(MAXFLOAT)
        let horizontalCenter = (CGFloat)(proposedContentOffset.x + collectionView.bounds.size.width / 2.0)

        let targetRect = CGRectMake(proposedContentOffset.x, 0.0, collectionView.bounds.size.width, collectionView.bounds.size.height)

        if let arr = self.layoutAttributesForElementsInRect(targetRect) {
        
            var currentAttributes: UICollectionViewLayoutAttributes?
            for layoutAttributes in arr {
                if layoutAttributes.representedElementCategory == .Cell {
                    let itemHorizontalCenter = layoutAttributes.center.x
                    if abs(Double(itemHorizontalCenter - horizontalCenter)) < abs(Double(offSetAdjustment)) {
                        currentAttributes = layoutAttributes
                        offSetAdjustment = itemHorizontalCenter - horizontalCenter
                        
                    }
                }
            }
            let nextOffset = proposedContentOffset.x + offSetAdjustment
            proposedContentOffset.x = nextOffset
            let deltaX = proposedContentOffset.x - collectionView.contentOffset.x
            let velX = velocity.x
            
            if deltaX == 0.0 || velX == 0 || (velX >  0.0  &&  deltaX >  0.0) || (velX <  0.0 &&  deltaX <  0.0) {
                
            }else if (velocity.x > 0) {
                for layoutAttributes in arr {
                    if layoutAttributes.representedElementCategory == .Cell {
                        let itemHorizontalCenter = layoutAttributes.center.x
                        if itemHorizontalCenter > proposedContentOffset.x {
                            proposedContentOffset.x = nextOffset + (currentAttributes?.frame.size.width)!/2 + layoutAttributes.frame.size.width/2
                            break
                        }
                    }
                }
            }else if (velocity.x < 0) {
                for layoutAttributes in arr {
                    if layoutAttributes.representedElementCategory == .Cell {
                        let itemHorizontalCenter = layoutAttributes.center.x
                        if itemHorizontalCenter > proposedContentOffset.x {
                            proposedContentOffset.x = nextOffset - ((currentAttributes?.frame.size.width)!/2 + layoutAttributes.frame.size.width/2)
                            break
                        }
                    }
                }
            }
            proposedContentOffset.y = 0
            return proposedContentOffset
        }
        return CGPointZero
    }
    
    // //返回所有cell的布局属性
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let arr = super.layoutAttributesForElementsInRect(rect)
        var visibleRect: CGRect = CGRectZero
        visibleRect.origin = (self.collectionView?.contentOffset)!
        visibleRect.size = (self.collectionView?.bounds.size)!
        for attributes in arr! {
            let distance = CGRectGetMidX(visibleRect) - attributes.center.x
            let normalizedDistance = distance / UIScreen.mainScreen().bounds.size.width
            let zoom = 1 + 0.1*(1 - abs(normalizedDistance))
            attributes.transform3D = CATransform3DMakeScale(1.0, zoom, 1.0)
            attributes.zIndex = 1
        }
        return arr
    }
    
    // 自定义布局必须返回true
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    
    
//    // 返回每个cell的布局属性
//    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
//        <#code#>
//    }
    
    
    
    
    
    
    
    
    
    
}
