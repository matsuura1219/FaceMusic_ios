//
//  CommonUtil.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/13.
//

import Foundation

/* 共通関数をまとめたクラスです */

class CommonUtil {
    
    private static let DATE_FORMAT: String = "yyyyMMddHHmmss"
    
    /* 現在の時刻を取得し、オブジェクトキーを取得する関数です */
    
    static func getObjectKeyName () -> String {
        
        //現在時刻をインスタス化します
        let dt = Date()
        //出力するフォーマットをインスタス化します
        let formatter = DateFormatter()
        //フォーマットを指定します
        formatter.dateFormat = DATE_FORMAT
        //フォーマット通りに文字を出力します
        return formatter.string(from: dt) + ".jpeg"
        
    }
    
}
