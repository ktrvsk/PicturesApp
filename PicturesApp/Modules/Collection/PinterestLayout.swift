//
//  PinterestLayout.swift
//  PicturesApp
//
//  Created by Ksusha on 23.05.2022.
//
//
import UIKit


protocol PinterestLayoutDelegate: AnyObject {
    func collectionView(_ collection: UICollectionView, sizeOfPhotoAt indexPath: IndexPath) -> CGSize
}

class PinterestLayout: UICollectionViewLayout {
    
    weak var delegate: PinterestLayoutDelegate!
    
    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        return collectionView.bounds.width
    }
    
    override var collectionViewContentSize: CGSize {
        CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard
            cache.isEmpty,
            let collectionView = collectionView else {
            return
        }
        
        let columnWidth = contentWidth / CGFloat(Constants.numberOfColumns)
        var xOffset = [CGFloat]()
        
        (0 ..< Constants.numberOfColumns).forEach { column in
            xOffset.append(CGFloat(column) * columnWidth)
        }
        
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: Constants.numberOfColumns)
        
        (0 ..< collectionView.numberOfItems(inSection: 0)).forEach { item in
            let indexPath = IndexPath(item: item, section: 0)
            let photoSize = delegate.collectionView(collectionView, sizeOfPhotoAt: indexPath)
            
            let cellWidth = columnWidth
            var cellHeight = photoSize.height * cellWidth / photoSize.width
        
            cellHeight = Constants.cellPadding * 2 + cellHeight
            
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: cellWidth, height: cellHeight)
            let frameWithInsets = frame.insetBy(dx: Constants.cellPadding, dy: Constants.cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frameWithInsets
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] += cellHeight
            
            column = column < (Constants.numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var vissbleLayoutAttributes = [UICollectionViewLayoutAttributes]()

        cache.forEach({ attributes in
            if attributes.frame.intersects(rect) {
                vissbleLayoutAttributes.append(attributes)
            }
        })
        return vissbleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        cache[indexPath.item]
    }
}

//MARK: - Constanst enum

extension PinterestLayout {
    private enum Constants {
        static let numberOfColumns = 2
        static let cellPadding: CGFloat = 3
    }
}
