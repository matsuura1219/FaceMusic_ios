//
//  FaceAPIUtil.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/13.
//

import Foundation

/* FaceAPIを呼び出した後に実行されるデリゲートです */

protocol FaceAPIDelegate: class {

    //FaceAPIを呼び出した後に実行される関数です
    func onResponse(statusCode: Int, data: FaceAPIResult?)
}


/* FaceAPIの処理をまとめたクラスです */

class FaceAPIUtil {
    
    /* 変数 */
    
    //デリゲート
    weak var delegate: FaceAPIDelegate? = nil
    
    /* 定数 */
    
    //エンドポイント
    private let FACE_ENDPOINT = "facemusicapp.cognitiveservices.azure.com"
    //サブスクリプションキー
    private let FACE_SUBSCRIPTION_KEY = "694dff107a7c4ffb98645ec06f2f0723"
    //サーバーURL
    private let requsetURL =
        "https://facemusicapp.cognitiveservices.azure.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=age,gender,headPose,smile,facialHair,glasses,emotion,hair,makeup,occlusion,accessories,blur,exposure,noise&recognitionModel=recognition_03&returnRecognitionModel=false&detectionModel=detection_01&faceIdTimeToLive=86400"
    
    //シングルトン
    static let shared = FaceAPIUtil()
    
    /**
     * httpの中身です
     * https://japaneast.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=age,gender,headPose,smile,facialHair,glasses,emotion,hair,makeup,occlusion,accessories,blur,exposure,noise&recognitionModel=recognition_03&returnRecognitionModel=false&detectionModel=detection_01&faceIdTimeToLive=86400 HTTP/1.1
     * Host: japaneast.api.cognitive.microsoft.com
     * Content-Type: application/json
     * Ocp-Apim-Subscription-Key: ••••••••••••••••••••••••••••••••
     * {
     * "url": "https://my-website-v1.s3-ap-northeast-1.amazonaws.com/img/about.jpg"
     * }
     */
    
    /* 撮影画像をAzureに送信するメソッドです */
    
    func sendImageToMicrosoft (imageUrl: String) {
        
        //URL型に変換します
        let url = URL(string: requsetURL)!
        //リクエストを生成します
        var request = URLRequest(url: url)
        //POST通信を設定します
        request.httpMethod = "POST"
        
        let json = ["url": imageUrl]
        
        do {
            //body部へパラーメータを付与します
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
            
        } catch {
            
        }
        
        //header部へパラメータを付与します
        request.addValue(FACE_ENDPOINT, forHTTPHeaderField: "Host")
        request.addValue(FACE_SUBSCRIPTION_KEY, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        //タスクを定義します
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            
            //dataをアンラップします
            guard let data = data else { return }
            
            if (response as! HTTPURLResponse).statusCode != Exconst.SUCCESS {
                //FaceAPIの呼び出しに失敗した場合
                //デリゲートに通知します
                self?.delegate?.onResponse(statusCode: Exconst.OTHER_ERROR,data: nil)
                
            } else {
                //FaceAPIの呼び出しに成功した場合
                
                do {
                    
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
                    
                    let jsonData = jsonObject.map { (jsonObject) -> [String: Any] in
                        
                        return jsonObject as! [String: Any]
                        
                    }
                    
                    if jsonData.count == 0 {
                        
                        //顔が写っていない場合
                        self?.delegate?.onResponse(statusCode: Exconst.NON_FACE_IMAGE_ERROR, data: nil)
                        
                    } else {
                        
                        //顔が写っている場合
                        
                        do {
                            
                            let test = try JSONSerialization.data(withJSONObject: jsonData[0], options: [])
                            
                            print(test)
                            
                            let result = try JSONDecoder().decode(FaceAPIResult.self, from: test)
                   
                            //デリゲートに通知します
                            self?.delegate?.onResponse(statusCode: Exconst.CALL_SUCCESS, data: result)
                            
                            
                        } catch {
                            
                            //デリゲートに通知します
                            self?.delegate?.onResponse(statusCode: Exconst.PARSE_JSON_ERROR, data: nil)
                            
                        }
                        
                    }
                    
                    
                } catch {
                    
                    //デリゲートに通知します
                    self?.delegate?.onResponse(statusCode: Exconst.PARSE_JSON_ERROR, data: nil)
                    
                }
                
            }
            
        }
        
        task.resume()
        
        
    }
    
    
   
    
}
