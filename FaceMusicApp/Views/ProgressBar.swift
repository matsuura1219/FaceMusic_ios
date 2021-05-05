//
//  ProgressBar.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/17.
//

import Foundation
import UIKit
import EMTNeumorphicView

/* ProgressBarViewクラスです */

class ProgressBar: NSObject {
        
    //進捗バー
    private var progress: UIView
    //ボタン
    private var concave : EMTNeumorphicButton
    //全体のview
    private var progressView: UIView
    
    private let ANIMATION_TIME = 2.0
    
    /* イニシアライザ */
    
    init (frame: CGRect) {
        
        //ボタンをインスタンス化します
        concave = EMTNeumorphicButton(type: .custom)
        //角丸の設定を行います
        concave.neumorphicLayer?.cornerRadius = SizeUtil.barHeight / 4
        //ボタンの深さを設定します
        concave.neumorphicLayer?.elementDepth = 7
        //ボタンの背景色を設定します
        concave.neumorphicLayer?.elementBackgroundColor = ColorUtil.baseColor.cgColor
        //凹を設定します
        concave.neumorphicLayer?.depthType = .concave
        
        //インスタンス化
        progressView = UIView()
        //viewに追加します
        progressView.addSubview(concave)
        
        //インスタンス化
        progress = UIView()
        //色を設定します
        progress.backgroundColor = ColorUtil.blue
        //角丸の設定を行います
        progress.layer.cornerRadius = SizeUtil.barHeight / 4
        //viewに追加します
        progressView.addSubview(progress)
        
        //スーパークラスの初期化を行います
        super.init()
        
    }
    
    /* コンポーネントの配置を変更するメソッドです */
    
    func setLayout (frame: CGRect, top: CGFloat, left: CGFloat) {
        
        //frameを設定します
        concave.frame = CGRect(x: left, y: top, width: frame.width - left * 2, height: SizeUtil.barHeight)
        progress.frame = CGRect(x: left, y: top, width: 0, height: SizeUtil.barHeight)
        
    }
    
    /* viewを取得するメソッドです */
    
    func getView() -> UIView {
        
        return progressView
        
    }
    
    func getHeight () -> CGFloat {
        
        return SizeUtil.barHeight
        
    }
    
    /* アニメーションを実行するメソッドです */
    
    func doaAnimation (rate: CGFloat) {
        
        UIView.animate(withDuration: ANIMATION_TIME, delay: 0.0, options: .allowAnimatedContent, animations: { [weak self] in
            
            guard let value = self?.concave.frame.width else { return }
            
            //アニメーションの処理内容を記載します
            self?.progress.frame.size.width += value * rate
            
        }, completion: nil)
        
    }
    
    
    
}

