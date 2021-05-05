//
//  CircleView.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/19.
//

import Foundation
import UIKit

class CircleView: NSObject {
    
    /* 変数 */
    
    private var view: UIView
    
    private var radius: CGFloat = 15
    
    /* イニシアライザ */
    
    init (frame: CGRect) {
        
        //インスタンス化
        view = UIView(frame: CGRect(x: 0, y: 0, width: radius, height: radius))
        //色を設定します
        view.backgroundColor = ColorUtil.blue
        //角丸を設定します
        view.layer.cornerRadius = radius / 2
        
        super.init()
        
    }
    
    /* viewを取得する関数です */
    
    func getView () -> UIView {
        
        return view
        
    }
    
    /* 高さを取得する関数です */
    
    func getHeight () -> CGFloat {
        
        return view.frame.height
        
    }
    
    
    /* レイアウトを配置します */
    
    func setLayout (top: CGFloat, left: CGFloat) {
        
        view.frame = CGRect(x: left, y: top, width: radius, height: radius)
        
    }
    
    
    /* 色を変更する関数です */
    
    func setColor (color: UIColor) {
        
        view.backgroundColor = color
    }
    
}
