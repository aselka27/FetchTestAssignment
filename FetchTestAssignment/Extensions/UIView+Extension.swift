//
//  UIView+Extension.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import UIKit

extension UIView {
    func addSubview(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func addCornerRadius(_ radius: CGFloat ) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
