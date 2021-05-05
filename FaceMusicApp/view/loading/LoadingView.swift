//
//  LoadingView.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/19.
//

import Foundation
import UIKit


/* ローディング時に表示するViewクラスです */

class LoadingView: NSObject {
    
    /* 変数 */
    
    private var view: UIView
    
    private var circle1: CircleView
    private var circle2: CircleView
    private var circle3: CircleView
    private var circle4: CircleView
    private var circle5: CircleView
    private var circle6: CircleView
    
    private var circles: [CircleView]
    
    private var label: UILabel
    
    /* イニシアライザ */
    
    init (frame: CGRect, message: String) {
        
        //インスタンス化
        view = UIView(frame: .zero)
        //背景を設定します
        view.backgroundColor = ColorUtil.overlay
        
        //インスタンス化
        label = UILabel()
        //テキストを設定します
        label.text = message
        //フォントサイズを設定します
        label.font = UIFont.systemFont(ofSize: 18)
        //テキストカラーを設定します
        label.textColor = ColorUtil.blue
        //中央寄せにします
        label.textAlignment = .center
        //文字サイズにviewを合わせまう
        label.sizeToFit()
        //viewに追加します
        view.addSubview(label)
        
        //インスタンス化
        circle1 = CircleView(frame: frame)
        //viewに追加します
        view.addSubview(circle1.getView())
        
        //インスタンス化
        circle2 = CircleView(frame: frame)
        //viewに追加します
        view.addSubview(circle2.getView())
        
        //インスタンス化
        circle3 = CircleView(frame: frame)
        //viewに追加します
        view.addSubview(circle3.getView())
        
        //インスタンス化
        circle4 = CircleView(frame: frame)
        //viewに追加します
        view.addSubview(circle4.getView())
        
        //インスタンス化
        circle5 = CircleView(frame: frame)
        //viewに追加します
        view.addSubview(circle5.getView())
        
        //インスタンス化
        circle6 = CircleView(frame: frame)
        //viewに追加します
        view.addSubview(circle6.getView())
        
        //配列に格納します
        circles = [circle1, circle2, circle3, circle4, circle5, circle6]
        
        //スーパークラスのイニシアライザ
        super.init()
        
    }
    
    
    /* viewを取得する関数です */
    
    func getView () -> UIView {
        
        return view
        
    }
    
    /* viewの配置を変更する関数です */
    
    func setLayout (frame: CGRect) {
        
        //frameを設定します
        view.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        //円のy位置
        let top = (frame.height - circle1.getHeight()) / 2
        
        //円の数
        let count = circles.count
        
        //円の幅
        let gutter : CGFloat = 30
        
        var left : CGFloat = (frame.width - (CGFloat(count) - 1) * gutter) / 2
        
        for circle in circles {
            
            circle.setLayout(top: top, left: left)
            
            left += gutter
            
        }
        
        label.frame = CGRect(x: 0, y: top + 30, width: frame.width, height: label.frame.height)
        
    }
  
    
    /* アニメーションを実行する関数です */
    
    func doAnimation () {
        
        var delay: Double = 0.0
        let duration: Double = 1.0
        
        /*
        UIView.transition(with: label, duration: duration, options: [.transitionCrossDissolve, .repeat], animations: { () in
            
            //アニメーション処理です
            self.label.textColor = ColorUtil.blue
            
        }, completion: nil)
        */
        
        for circle in circles {
            
            UIView.animate(withDuration: duration, delay: delay, options: [.repeat, .autoreverse], animations: { () in
                
                //アニメーション処理です
                
                circle.setColor(color: UIColor.clear)
                
            }, completion: nil)
            
            delay += 0.2
            
        }
        
        
    }
    
    
}
