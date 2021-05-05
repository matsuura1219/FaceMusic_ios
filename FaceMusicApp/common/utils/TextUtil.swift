//
//  TextUtil.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/11.
//

import Foundation

/* テキストの定義をするクラスです */

class TextUtil {
    
    /* OpeningViewController */
    
    static let openingTitle = "FACE MUSIC"
    
    /* HomeViewController */
    
    //タイトルバー
    static let title_homeView = "FACE MUSIC"
    
    /* CameraViewController */
    
    //タイトルバー
    static let title_cameraView = "アプリの操作説明"
    
    //STEP1
    static let step1Title = "STEP1"
    static let step1SubTitle = "顔写真の撮影"
    static let step1Message = "NEXTボタンを押下すると、カメラが起動します。今の感情を表情に出し、撮影してください。"
    
    //STEP2
    static let step2Title = "STEP2"
    static let step2SubTitle = "感情の推論"
    static let step2Message = "撮影画像を送信すると、AIにより感情を取得します。"
    
    //STEP3
    static let step3Title = "STEP3"
    static let step3SubTitle = "最適な楽曲の提案"
    static let step3Message = "取得した感情から、最適な楽曲を提案し、音楽の視聴ができます。"
    
    
    /* FaceApiResultViewController */
    //タイトルバー
    static let title_faceApiResultView = "AIによる分析結果"
    
    static let anger = "Anger"
    static let contempt = "Contempt"
    static let disgust = "Disgust"
    static let fear = "Fear"
    static let happiness = "Happiness"
    static let neutral = "Neutral"
    static let sadness = "Sadness"
    static let surprise = "Surprise"
    
    
}
