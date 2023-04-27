//
//  UIImage+Extension.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 27.04.2023.
//

import UIKit


extension UIImage {
    enum DessertsView {
        static var placeholderImage: UIImage { UIImage(named: "placeholder")! }
        static var pizza: UIImage { UIImage(named: "pizza")! }
    }
    
    enum FavoriteButton {
        static var heart: UIImage { (UIImage(systemName: "heart.fill")?.withTintColor(.red).withRenderingMode(.alwaysOriginal))! }
        
        static var emptyHeart: UIImage { (UIImage(systemName: "heart")?.withTintColor(.red).withRenderingMode(.alwaysOriginal))! }
    }
    
    enum CheckMarkButton {
        static var checked: UIImage { (UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.brown).withRenderingMode(.alwaysOriginal))! }
        
        static var unchecked: UIImage { (UIImage(systemName: "checkmark.circle")?.withTintColor(.brown).withRenderingMode(.alwaysOriginal))! }
    }
}
