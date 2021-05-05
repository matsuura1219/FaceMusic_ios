//
//  AmazonS3Util.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/13.
//

import Foundation
import AWSS3

/* 画像アップロード後に実行するデリゲートです */

protocol AmazonS3Delegate: class {
    
    func onUploaded(status: Int)
    
}


/* AmazonS3への操作を行うクラスです */

class AmazonS3Util {
    
    /* 変数 */
    
    //デリゲート
    weak var delegate: AmazonS3Delegate? = nil
    
    //バケットの名前
    private let bucketName: String = "face-music-app"
    
    //シングルトン
    static let shared = AmazonS3Util()

    
    /* 画像をアップロードするメソッドです */
    
    func uploadObject (key: String, data: Data) {
        
        let transferUtility = AWSS3TransferUtility.default()
        //アップロードするバケット名
        let bucket = bucketName
        //オブジェクトキー
        let key = key
        //アップロードするコンテンツのファイルの種類
        let contentType = "image/jpeg"
        
        // アップロード中の処理
        let expression = AWSS3TransferUtilityUploadExpression()
        expression.progressBlock = {(task, progress) in
            DispatchQueue.main.async {
                // アップロード中の処理をここに書く
                
            }
        }
        
        // アップロード後の処理
        let completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
        completionHandler = { (task, error) -> Void in
            DispatchQueue.main.async {
                if let _ = error {
                    //アップロードに失敗した場合
                    //デリゲートへ通知する
                    self.delegate?.onUploaded(status: Exconst.UPLOADED_FAILURE)
                    
                    
                } else {
                    //アップロード後の処理をここに書く
                    //デリゲートへ通知する
                    self.delegate?.onUploaded(status: Exconst.UPLOADED_SUCCESS)
                }
            }
        }
     
        
        // アップロード
        transferUtility.uploadData(
            data,
            bucket: bucket,
            key: key,
            contentType: contentType,
            expression: expression,
            completionHandler: completionHandler
        ).continueWith { (task) -> Any? in
            if let _ = task.error as NSError? {
                //アップロードに失敗した場合
                //デリゲートへ通知する
                self.delegate?.onUploaded(status: Exconst.UPLOADED_FAILURE)
               
            } else {
                // アップロードが始まった時の処理をここに書く
            }
            
            return nil
        }
        
    }
    
    
    /* 指定したオブジェクトの署名付きURLを生成するメソッドです */
    
    func createURL (key: String) -> String {
        
        //署名付きURL
        var preSignedURL: String = ""
        
        //署名付きURLのリクエストを生成します
        let request = AWSS3GetPreSignedURLRequest()
        //バケット名を指定します
        request.bucket = bucketName
        //オブジェクトキーを指定します
        request.key = key
        //httpメソッドを設定します
        request.httpMethod = AWSHTTPMethod.GET
        //署名付きURLの有効期限を設定します
        request.expires = Date(timeIntervalSinceNow: 360)
       
        //リクエストをします
        AWSS3PreSignedURLBuilder.default().getPreSignedURL(request).continueWith { (task:AWSTask<NSURL>) -> Any? in
            if let error = task.error as NSError? {
                //リクエスト時にエラーが発生した場合
                print("Error: \(error)")
                return ""
                
            }
            
            //通信が正常に終了した時、署名付きURLを戻り値に返します
            preSignedURL = (task.result?.absoluteString)!
            return nil
        }
        
        return preSignedURL
    }

    
    /* 指定したオブジェクトを削除するメソッドです */
    
    func deleteObject (key: String) {
        
        //リクエストを生成します
        let request = AWSS3DeleteObjectRequest()
        //オブジェクトキーを指定します
        request?.key = key
        //バケット名を指定します
        request?.bucket = bucketName
        //リクエストします
        AWSS3.default().deleteObject(request!, completionHandler: { (response, error) -> () in
            
        })
     
    }
    
    
}
