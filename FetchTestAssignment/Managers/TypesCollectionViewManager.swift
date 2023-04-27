//
//  TypesCollectionViewManager.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 27.04.2023.
//

import UIKit

protocol TypesCollectionViewManagerImpl: AnyObject {
    func inject(collectionView: UICollectionView)
    var passIndexPath: ((Int)->())? { get set }
}

final class TypesCollectionViewManager: NSObject, TypesCollectionViewManagerImpl {
    
    //MARK: Properties
    var passIndexPath: ((Int)->())?
    var collectionView: UICollectionView?
    
    
    //MARK: Init
    init(collectionView: UICollectionView? = nil) {
        self.collectionView = collectionView
    }
    
    func inject(collectionView: UICollectionView) {
        self.collectionView = collectionView
       configureCollectionView()
    }
    
    func configureCollectionView() {
        guard let collectionView else { return }
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.minimumInteritemSpacing = 0
        collectionView.isScrollEnabled = false
        collectionView.register(SegmentCollectionViewCell.self, forCellWithReuseIdentifier: SegmentCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor(named: "backgroundColor")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
    }
}


  //MARK: UICollectionViewDataSouce & UICollectionViewDelegate
extension TypesCollectionViewManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Types.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentCollectionViewCell.identifier, for: indexPath) as? SegmentCollectionViewCell else { return UICollectionViewCell() }
        let types = Types.allCases
        cell.configure(segmentType: types[indexPath.item])
        return cell
    }
}

extension TypesCollectionViewManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width/2-4, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        passIndexPath?(indexPath.item)
    }
}
