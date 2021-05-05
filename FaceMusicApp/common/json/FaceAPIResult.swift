//
//  FaceAPIResult.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/16.
//

import Foundation

/* FaceAPIをコールした後に取得するjson変換するためのCodable(インスンス情報を他の形式にデータ変換するプロトコル)です */

struct FaceAPIResult: Codable {
    
    //FaceID
    var faceId: String
    
    //顔の位置
    var faceRectangle: FaceRectangle
    
    //顔画像の位置
    struct FaceRectangle: Codable {
        
        //顔位置の位置(top)
        var top: Int
        //顔位置の位置(left)
        var left: Int
        //顔の横幅
        var width: Int
        //顔の縦幅
        var height: Int
        
    }
    
    //顔の情報
    var faceAttributes: FaceAttributes
    
    //顔の情報
    struct FaceAttributes: Codable {
        
        //笑顔
        var smile: Double
        
        //顔の傾き
        var headPose: HeadPose
        
        //顔の傾き
        struct HeadPose: Codable {
            
            //pitch
            var pitch: Double
            //roll
            var roll: Double
            //yaw
            var yaw: Double
            
        }
        
        //性別
        var gender: String
        
        //年齢
        var age: Int
        
        //髭
        var facialHair: FacialHair
        
        //髭
        struct FacialHair: Codable {
            
            //口髭
            var moustache: Double
            
            //顎髭
            var beard: Double
            
            //ほお髭
            var sideburns: Double
            
        }
        
        //メガネあり
        var glasses: String
        
        //感情
        var emotion: Emotion
        
        //感情
        struct Emotion: Codable {
            
            //怒り
            var anger: Double
            
            //軽蔑
            var contempt: Double
            
            //嫌悪
            var disgust: Double
            
            //恐怖
            var fear: Double
            
            //幸せ
            var happiness: Double
            
            //ノーマル
            var neutral: Double
            
            //悲しみ
            var sadness: Double
            
            //驚き
            var surprise: Double
            
        }
        
        //画像のぼやけ
        var blur: Blur
        
        //画像のぼやけ
        struct Blur: Codable {
            
            //ぼやけ具合
            var blurLevel: String
            
            //ぼやけ具合(数値)
            var value: Double
            
        }
        
        //露出度
        var exposure: Exposure
        
        //露出度
        struct Exposure: Codable {
            
            //露出具合
            var exposureLevel: String
            
            //露出具合(数値)
            var value: Double
            
        }
        
        //ノイズ
        var noise: Noise
        
        //ノイズ
        struct Noise: Codable {
            
            //ノイズのレベル
            var noiseLevel: String
            //ノイズのレベル(数値)
            var value: Double
            
        }
        
        //化粧
        var makeup: MakeUp
        
        //化粧
        struct MakeUp: Codable {
            
            //アイメイク
            var eyeMakeup: Bool
            //リップ
            var lipMakeup: Bool
            
        }
        
        var accessories: [Accessories]
        
        //アクセサリー
        struct Accessories: Codable {
            
        }
        
        var occlusion: Occlusion
        
        //顔を塞いでいるか
        struct Occlusion: Codable {
            
            //額
            var foreheadOccluded: Bool
            //目
            var eyeOccluded: Bool
            //口
            var mouthOccluded: Bool
            
        }
        
        var hair: Hair
        
        //髪
        struct Hair: Codable {
            
            //薄毛の度合い
            var bald: Double
            
            //髪の毛が見えるかどうか
            var invisible: Bool
            
            var hairColor: [HairColor]
            
            //髪色
            struct HairColor: Codable {
                
                struct Color: Codable {
                    
                    //色
                    var color: String
                    
                    //信頼度
                    var confidence: Double
                    
                }
                
            }
            
        }
        
    }
    
    
}
