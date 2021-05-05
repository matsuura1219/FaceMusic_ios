//
//  OpeningView.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/11.
//

import UIKit

/* ロゴを表示するViewクラスです */

class LogoView: NSObject {
    
    private var image: UIImage
    private var imageView: UIImageView

    /* イニシアライザ */
    
    init(frame: CGRect) {
        
        //UIImageをインスタンス化します
        image = UIImage(named: "logo")!
        //UIImageViewをインスタンス化します
        imageView = UIImageView(image: image)
        
        super.init()

    }
    
    /* viewを取得するメソッドです */
   
    func getView () -> UIImageView {
        
        return imageView
        
    }
    
    /* コンポーネントの配置を変更するメソッドです */
    
    func setLayout (frame: CGRect, top: CGFloat, bottom: CGFloat, navigationHeight: CGFloat) {
        
        //画像の縦横を取得します
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        
        //スクリーンの縦横を算出します
        let screenWidth = frame.width
        let screenHeight = frame.height
        
        //端末と画像の縮尺を算出します
        let scale = imageWidth / (screenWidth * 0.8)
        
        //画像のy座標を算出します
        let y = (screenHeight - top - bottom) / 2 - navigationHeight / 2
        
        //frameを設定します
        imageView.frame = CGRect(x: screenWidth * 0.1, y: y, width: imageWidth / scale, height: imageHeight / scale)
        
    }

}
