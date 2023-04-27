//
//  DessertDetailViewController.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import UIKit

class DessertDetailViewController: UIViewController {
    
    private let dessertView = DessertDetailView()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false 
        return scrollView
    }()
    
    override func loadView() {
        self.view = dessertView
        dessertView.segmentCollectionView.delegate = self
        dessertView.segmentCollectionView.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let indexPath = IndexPath(row: 0, section: 0)
        dessertView.segmentCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
 // meal name , instruction , ingredients/measurements
    }

}


extension DessertDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentCollectionViewCell.identifier, for: indexPath) as? SegmentCollectionViewCell else { return UICollectionViewCell() }
        let types = ["Ingredients", "Directions"]
        cell.configure(segmentType: types[indexPath.item])
        return cell 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = dessertView.segmentCollectionView.frame.size
        return CGSize(width: size.width/2-4, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}
