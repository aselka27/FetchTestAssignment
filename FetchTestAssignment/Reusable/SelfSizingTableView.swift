//
//  SelfSizingTableView.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import UIKit

class SelfSizingTableView: UITableView {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        return contentSize
    }
}
