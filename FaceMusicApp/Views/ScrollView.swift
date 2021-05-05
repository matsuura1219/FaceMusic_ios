//
//  ScrollView.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/18.
//

import Foundation
import UIKit

class ScrollView: NSObject {
    
    private var view: UIScrollView
    
    init (frame: CGRect) {
        
        //インスタンス化
        view = UIScrollView()
        //スクロールバーを非表示にします
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        
        super.init()
    }
    
    func getView () -> UIScrollView {
        
        return view
    }
    
    func setLayout (frame: CGRect, top: CGFloat, left: CGFloat, height: CGFloat, contentHeight: CGFloat) {
        
        //frameを設定します
        view.frame = CGRect(x: left, y: top, width: frame.width - left * 2, height: height)
        //コンテント領域を設定します
        view.contentSize = CGSize(width: frame.width - left * 2, height: contentHeight)
        
    }
    
    
    
}
