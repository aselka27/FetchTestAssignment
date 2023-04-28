//
//  CustomLabel.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 27.04.2023.
//

import UIKit

  class CustomLabel: UILabel {
      //MARK: Properties
     private let fontSize: CGFloat
     private let fontWeight: UIFont.Weight
     private var color: UIColor 
    
      //MARK: Init
      init(frame: CGRect, fontSize: CGFloat, fontWeight: UIFont.Weight, color: UIColor = .black) {
          self.fontSize = fontSize
          self.fontWeight = fontWeight
          self.color = color
          super.init(frame: frame)
          self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
          translatesAutoresizingMaskIntoConstraints = false
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
  }


