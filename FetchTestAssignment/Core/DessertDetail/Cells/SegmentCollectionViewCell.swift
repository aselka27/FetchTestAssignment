//
//  SegmentCollectionViewCell.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import UIKit

final class SegmentCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    static let identifier = "SegmentCollectionViewCell"
    override var isSelected: Bool {
        didSet {
            undelineView.isHidden = isSelected ? false : true
            typeLabel.textColor = isSelected ? .red : .black
        }
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Views
    private lazy var typeLabel: CustomLabel = {
        let label = CustomLabel(frame: .zero, fontSize: 14, fontWeight: .bold)
        return label
    }()
    
    private lazy var undelineView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    //MARK: ConfigureUI
    private func configureUI() {
        contentView.addSubview(typeLabel, undelineView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let constraints = [
            typeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            typeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            undelineView.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
            undelineView.trailingAnchor.constraint(equalTo: typeLabel.trailingAnchor),
            undelineView.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 3),
            undelineView.heightAnchor.constraint(equalToConstant: 2)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: ConfigureCell
     func configure(segmentType: Types) {
         self.typeLabel.text = segmentType.rawValue
    }
}
