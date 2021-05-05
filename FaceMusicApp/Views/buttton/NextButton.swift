//
//  CardView.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/12.
//

import Foundation
import UIKit
//UIライブラリをインポートします
import EMTNeumorphicView

/* CardViewをタップした時に発火するデリゲートです */

protocol NextButtonDelegate: class {
    
    /* タップをした時に実行されるメソッドです */
    
    func onTapped()
    
}


/* CardViewクラスです */

class NextButton: NSObject {
    
    //ボタン
    private var button : EMTNeumorphicButton
    //デリゲート
    weak var delegate : NextButtonDelegate? = nil
    
    /* イニシアライザ */
    
    init (frame: CGRect) {
        
        //ボタンをインスタンス化します
        button = EMTNeumorphicButton(type: .custom)
        //角丸の設定を行います
        button.neumorphicLayer?.cornerRadius = SizeUtil.buttonHeight / 4
        //ボタンの深さを設定します
        button.neumorphicLayer?.elementDepth = 7
        //ボタンの背景色を設定します
        button.neumorphicLayer?.elementBackgroundColor = ColorUtil.baseColor.cgColor
        //スーパークラスの初期化を行います
        super.init()
        //ボタンのテキストを設定します
        setText()
        
    }
    
    
    /* ボタンのテキストに関する設定を行うメソッドです */
    
    private func setText() {
        
        //表示するテキストを設定します
        button.setTitle("NEXT", for: .normal)
        //ボタンのテキストの色を設定します
        button.setTitleColor(ColorUtil.textColor, for: .normal)
        
    }
    
    /* コンポーネントの配置を変更するメソッドです */
    
    func setLayout (frame: CGRect, top: CGFloat) {
        
        //frameを設定します
        button.frame = CGRect(x: 15, y: top, width: frame.width - 30, height: SizeUtil.buttonHeight)
        
    }
    
    /* viewを取得するメソッドです */
    
    func getView() -> EMTNeumorphicButton {
        
        //ボタンをタップした時のイベント処理を設定します
        button.addTarget(self, action: #selector(tappedDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(tappedUpInside(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(tappedUpOutside(_:)), for: .touchUpOutside)
        
        
        return self.button
        
    }
    
    /* ボタンを押したときに実行されるメソッドです */
    
    @objc private func tappedDown(_ button: EMTNeumorphicButton) {
        
        button.neumorphicLayer?.depthType = .concave
    }
    
    /* ボタン内で指を離したときに実行されるメソッドです */
    
    @objc private func tappedUpInside (_ button: EMTNeumorphicButton) {
        
        button.neumorphicLayer?.depthType = .convex
        //デリゲートに通知します
        self.delegate?.onTapped()
    }
    
    /* ボタン外で指を離したときに実行されるメソッドです */
    
    @objc private func tappedUpOutside (_ button: EMTNeumorphicButton) {
        
        button.neumorphicLayer?.depthType = .convex
        
    }
    
}
