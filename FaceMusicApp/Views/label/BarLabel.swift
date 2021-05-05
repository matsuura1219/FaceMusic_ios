//
//  BarLabel.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/18.
//

import Foundation
import UIKit

/* プログレスバーに表示するタイトルラベルです */

class BarLabel: NSObject {
    
    private var label: UILabel
    
    init (frame: CGRect, title: String) {
        
        label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = ColorUtil.textColor
        
    }
    
    func getView () -> UILabel {
        
        return label
    }
    
    func setLayout (frame: CGRect, top: CGFloat, left: CGFloat) {
        
        label.sizeToFit()
        label.frame = CGRect(x: left, y: top, width: frame.width - left * 2, height: label.frame.height)
        
    }
    
    func getHeight () -> CGFloat {
    
        return label.frame.height
        
        
    }
}
