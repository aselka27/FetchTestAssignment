//
//  IngredientTableViewCell.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import UIKit

final class IngredientTableViewCell: UITableViewCell {
    
    //MARK: Properties
    static let identifier = "IngredientTableViewCell"
    private var checkmarkIcon = UIImage.CheckMarkButton.unchecked
    private let configuration = UIImage.SymbolConfiguration(pointSize: 23)
    
     lazy var isChecked: Bool = false {
        didSet {
            checkmarkIcon = isChecked ? UIImage.CheckMarkButton.checked.withConfiguration(configuration) : UIImage.CheckMarkButton.unchecked.withConfiguration(configuration)
            checkmarkImageView.image = checkmarkIcon
        }
    }

    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.isChecked = false
    }
    
    //MARK: Views
    private let ingredientLabel: CustomLabel = {
        let label = CustomLabel(frame: .zero, fontSize: 14, fontWeight: .medium)
        return label
    }()

    private lazy var checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = checkmarkIcon.withConfiguration(configuration)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: ConfigureUI
    private func configureUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(checkmarkImageView, ingredientLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        let constraints = [
            ingredientLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ingredientLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkmarkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: ConfigureCell
    func configure(with model: (String, String)) {
        self.ingredientLabel.text = "\(model.1) \(model.0)"
    }
}
