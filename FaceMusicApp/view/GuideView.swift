//
//  GuideView.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/17.
//

import Foundation
//ニューモフィズムのライブラリをインポートします
import EMTNeumorphicView


/* ガイドViewクラスです */

class GuideView: NSObject {
    
    //view
    private var view: UIView
    
    //タイトルラベル
    private var titleLabel: UILabel
    //サブタイトル
    private var subTitleLabel: UILabel
    //イラスト
    private var image: UIImage
    private var imageView: UIImageView
    //説明ラベル
    private var messageLabel: UILabel
    
    
    /* イニシアライザ */
    init (frame: CGRect, title: String, subTitle: String, imageName: String, message: String) {
        
        //インスタンス化
        view = UIView()
        
        //インスタンス化
        titleLabel = UILabel()
        //テキストを設定します
        titleLabel.text = title
        
        //インスタンス化
        subTitleLabel = UILabel()
        subTitleLabel.text = subTitle
        
        //インスタンス化
        image = UIImage(named: imageName)!
        //インスタンス化
        imageView = UIImageView(image: image)
        
        //インスタンス化
        messageLabel = UILabel()
        //テキストを設定します
        messageLabel.text = message
        
        //スーパークラスのイニシアライザ
        super.init()
        
    }
    
    
    /* viewを取得するメソッドです */
   
    func getView () -> UIView {
        
        return view
        
    }
    
    /* コンポーネントの配置を変更するメソッドです */
    
    func setLayout (frame: CGRect, top: CGFloat, left: CGFloat, width: CGFloat) {
        
        /* イラスト */
        
        //画像の横幅
        var imageWidth = image.size.width
        //画像の高さ
        var imageHeight = image.size.height
        //スクリーンの横幅
        let screenWidth = frame.width
        //スクリーンの縦幅
        //let screenHeight = frame.height
        //縮尺
        let scale = imageWidth / imageHeight
        
        //画像の横幅を再設定
        imageWidth = (screenWidth - left * 2) * 0.2
        //画像の縦幅を再設定
        imageHeight = ((screenWidth - left * 2) * 0.2) / scale
        
        //画像のleft位置
        let x = ((screenWidth - left * 2) * 0.35 - imageWidth) / 2
        
        //frameを設定します
        imageView.frame = CGRect(x: left + x, y: top, width: imageWidth, height: imageHeight)
        //viewに追加します
        view.addSubview(imageView)
        
        /* タイトル */
        
        //フォントサイズを設定します
        titleLabel.font = FontUtil.titleSize_cameraView
        //テキストの色を設定します
        titleLabel.textColor = ColorUtil.textColor
        //frameを設定をします
        titleLabel.frame = CGRect(x: left + (screenWidth - left * 2) * 0.35, y: top, width: (screenWidth - left * 2) * 0.65, height: titleLabel.frame.height)
        //テキストのviewをフォントサイズに適合させます
        titleLabel.sizeToFit()
        //viewに追加します
        view.addSubview(titleLabel)
        
        /* サブタイトル */
        
        //フォントサイズを設定します
        subTitleLabel.font = FontUtil.titleSize_cameraView
        //テキストの色を設定します
        subTitleLabel.textColor = ColorUtil.textColor
        //frameを設定をします
        subTitleLabel.frame = CGRect(x: left + (screenWidth - left * 2) * 0.35, y: top + titleLabel.frame.height + SizeUtil.margin, width: (screenWidth - left * 2) * 0.65, height: subTitleLabel.frame.height)
        //テキストのviewをフォントサイズに適合させます
        subTitleLabel.sizeToFit()
        //viewに追加します
        view.addSubview(subTitleLabel)
        
        /* メッセージ */
    
        //フォントサイズを設定します
        messageLabel.font = FontUtil.messageSize_cameraView
        //テキストの色を設定します
        messageLabel.textColor = ColorUtil.textColor
        //行数制限を解除します
        messageLabel.numberOfLines = 0
        //frameを設定をします
        messageLabel.frame = CGRect(x: left + (screenWidth - left * 2) * 0.35, y: top + titleLabel.frame.height + SizeUtil.margin + subTitleLabel.frame.height + SizeUtil.margin, width: (screenWidth - left * 2) * 0.65, height: messageLabel.frame.height)
        //テキストのviewをフォントサイズに適合させます
        messageLabel.sizeToFit()
        
        //viewに追加します
        view.addSubview(messageLabel)
          
    }
    
    
    /* viewの高さを取得するメソッドです */

    func getHeight () -> CGFloat {
        
        let labelHeight = titleLabel.frame.height + subTitleLabel.frame.height + messageLabel.frame.height + SizeUtil.margin * 2
        let imageHeight = imageView.frame.height
        
        if labelHeight > imageHeight {
            
            return labelHeight
            
        } else {
            
            return imageHeight
        }
        
    }
}
