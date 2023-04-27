//
//  IngredientTableViewCell.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    
    //MARK: Properties
    static let identifier = "IngredientTableViewCell"
    private var isChecked: Bool = false

    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Views
    private let ingredientLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var checkButton: UIButton = {
        let button = UIButton()
        let checkMarkImage = UIImage(systemName: "checkmark.circle")?.withTintColor(.brown).withRenderingMode(.alwaysOriginal)
        
        button.setImage(checkMarkImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 18)), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: ConfigureUI
    private func configureUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(checkButton, ingredientLabel)
        setConstraints()
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    private func setConstraints() {
        let constraints = [
            ingredientLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ingredientLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func checkButtonTapped() {
        isChecked.toggle()
        let checkMarkImage = isChecked ? UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.brown).withRenderingMode(.alwaysOriginal) : UIImage(systemName: "checkmark.circle")?.withTintColor(.brown).withRenderingMode(.alwaysOriginal)
        checkButton.setImage(checkMarkImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 18)), for: .normal)
    }
    
    //MARK: ConfigureCell
    func configure(with model: (String, String)) {
        self.ingredientLabel.text = "\(model.1) \(model.0)"
    }
}
