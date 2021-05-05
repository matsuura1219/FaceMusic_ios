//
//  LoadingIcon.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/19.
//

import UIKit

class LoadingIcon: UIView {

    /* 変数 */
    
    //円の半径
    private let radius: CGFloat = 30
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {

        //インスタンス化
        let circle1 = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi) * 2, clockwise: true)
        //内側の色を設定します
        ColorUtil.baseColor.setFill()
        //内側を塗りつぶします
        circle1.fill()
        //線の色を設定します
        ColorUtil.baseColor.setStroke()
        //線の太さを設定します
        circle1.lineWidth = 0.0
        //線の色を塗りつぶします
        circle1.stroke()
        
    }
    
    func setLayout () {
        
    }
   

}
