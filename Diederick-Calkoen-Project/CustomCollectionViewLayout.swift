//
//  CustomCollectionViewLayout.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 12/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewLayout
{

    let numberOfColumns = 8
    
    var itemAttributes: [[UICollectionViewLayoutAttributes]]?
    
    var itemsSize : [CGSize]?
    
    var contentSize : CGSize!
    
    override func prepare()
    {
        if self.collectionView?.numberOfSections == 0
        {
            return
        }
        
        if (self.itemAttributes != nil && (self.itemAttributes?.count)! > 0)
        {
            for section in 0..<self.collectionView!.numberOfSections
            {
                let numberOfItems : Int = self.collectionView!.numberOfItems(inSection: section)
                
                for index in 0..<numberOfItems
                {
                    if section != 0 && index != 0
                    {
                        continue
                    }
                    
                    let attributes : UICollectionViewLayoutAttributes = self.layoutAttributesForItem(at: IndexPath(item: index, section: section))!
                    

                    if section == 0
                    {
                        var frame = attributes.frame
                        frame.origin.y = self.collectionView!.contentOffset.y
                        attributes.frame = frame
                    }
                    
                    if index == 0
                    {
                        var frame = attributes.frame
                        frame.origin.x = self.collectionView!.contentOffset.x
                        attributes.frame = frame
                    }
                }
            }
            
            return
        }
        
        if (self.itemsSize == nil || self.itemsSize?.count != numberOfColumns)
        {
            self.calculateItemsSize()
        }
        
        var column = 0
        var xOffset : CGFloat = 0
        var yOffset : CGFloat = 0
        var contentWidth : CGFloat = 0
        var contentHeight : CGFloat = 0
        
        for section in 0..<self.collectionView!.numberOfSections
        {
            var sectionAttributes: [UICollectionViewLayoutAttributes] = []
            
            for index in 0..<numberOfColumns
            {
                let itemSize = self.itemsSize?[index]
                let indexPath = IndexPath(item: index, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: xOffset, y: yOffset, width: (itemSize?.width)!, height: (itemSize?.height)!).integral
                
                if section == 0 && index == 0
                {
                    attributes.zIndex = 1024;
                }
                
                else  if section == 0 || index == 0
                {
                    attributes.zIndex = 1023
                }
                
                if section == 0
                {
                    var frame = attributes.frame
                    frame.origin.y = self.collectionView!.contentOffset.y
                    attributes.frame = frame
                }
                
                if index == 0
                {
                    var frame = attributes.frame
                    frame.origin.x = self.collectionView!.contentOffset.x
                    attributes.frame = frame
                }
                
                sectionAttributes.append(attributes)
                
                xOffset += (itemSize?.width)!
                column += 1
                
                if column == numberOfColumns
                {
                    if xOffset > contentWidth
                    {
                        contentWidth = xOffset
                    }
                    
                    column = 0
                    xOffset = 0
                    yOffset += (itemSize?.height)!
                }
            }
            
            if (self.itemAttributes == nil)
            {
                self.itemAttributes = [[UICollectionViewLayoutAttributes]]()
            }
            
            self.itemAttributes!.append(sectionAttributes)
        }
        
        if let attributes : UICollectionViewLayoutAttributes = self.itemAttributes?.last?.last
        {
            contentHeight = attributes.frame.origin.y + attributes.frame.size.height
            
            self.contentSize = CGSize(width: contentWidth, height: contentHeight)
        }
    }
    
    override var collectionViewContentSize : CGSize
    {
        return self.contentSize
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes?
    {
        return self.itemAttributes?[indexPath.section][indexPath.row]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        var attributes = [UICollectionViewLayoutAttributes]()
        
        if let itemAttributes = self.itemAttributes
        {
            for section in itemAttributes
            {
                let filteredArray = section.filter({ (evaluatedObject) -> Bool in
                    return rect.intersects(evaluatedObject.frame)
                })
                
                attributes.append(contentsOf: filteredArray)
            }
        }
        
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool
    {
        return true
    }
    
    func sizeForItemWithColumnIndex(_ columnIndex: Int) -> CGSize
    {
        return CGSize(width: 65, height: 30)
    }
    
    func calculateItemsSize()
    {
        self.itemsSize = []
        
        for index in 0..<numberOfColumns
        {
            self.itemsSize!.append(self.sizeForItemWithColumnIndex(index))
        }
    }
}
