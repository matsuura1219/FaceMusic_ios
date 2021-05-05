//
//  ExConst.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/13.
//

import Foundation


/* 定数をまとめたクラスです */

class Exconst {

    //AmazonS3への画像アップロードが成功した時
    static let UPLOADED_SUCCESS: Int = 0
    
    //AmazonS3への画像アップロードが失敗した時
    static let UPLOADED_FAILURE: Int = 1
    
    //FaceAPIの呼び出しに成功した場合
    static let CALL_SUCCESS: Int = 1000
    
    //FaceAPIの呼び出しに失敗した場合
    
    //Jsonのパースにエラーが発生した場合
    static let PARSE_JSON_ERROR: Int = 2000
    
    //顔が写っておらず、顔情報を取得できなかった場合
    static let NON_FACE_IMAGE_ERROR = 3000
    
    //その他
    static let OTHER_ERROR = 4000

    
    
    
    
    //HTTP ステータスコード
    static let SUCCESS: Int = 200
}
