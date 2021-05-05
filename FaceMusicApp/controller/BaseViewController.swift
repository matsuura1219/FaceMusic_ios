//
//  BaseViewController.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/11.
//

import UIKit

/* 共通の処理を行うコントローラーです　*/

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景色をベースカラーにします
        self.view.backgroundColor = ColorUtil.baseColor
        
        // ナビゲーションバーの戻るボタンなどの色を変更します
        self.navigationController?.navigationBar.tintColor = ColorUtil.textColor
        
        // ナビゲーションバーのテキストの色を変更します
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: ColorUtil.textColor]
        
        //ナビゲーションバーの背景色をベースカラーにします
        self.navigationController?.navigationBar.barTintColor = ColorUtil.baseColor
        
        // ナビゲーションバーの影を消します
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    
    /* viewWillLayoutSubviews()でviewの配置を行います */
    
    override func viewWillLayoutSubviews() {
        
        
    }
    
    /* safeAreaのtopの高さを取得する関数です */
    
    func getSafeAreaTopHeight (view: UIView) -> CGFloat {
        
        var topSafeAreaHeight: CGFloat = 0
        
        if #available(iOS 11.0, *) {
            //iOS 11.0以上の場合
            topSafeAreaHeight = view.safeAreaInsets.top
        }
        
        return topSafeAreaHeight
        
    }
    
    /* safeAreaのbottomの高さを取得する関数です */
    
    func getSafeAreaBottomHeight (view: UIView) -> CGFloat {
        
        var bottomSafeAreaHeight: CGFloat = 0
        
        if #available(iOS 11.0, *) {
            //iOS 11.0以上の場合
            bottomSafeAreaHeight = view.safeAreaInsets.bottom
        }
        
        return bottomSafeAreaHeight
        
    }
    
    /* 端末の高さを取得する関数です */
    
    func getScreenHeight () -> CGFloat {
        
        let myBoundSize: CGSize = UIScreen.main.bounds.size
        return myBoundSize.height
        
    }
    
    /* 端末の幅を取得する関数です */
    
    func getScreenWidth () -> CGFloat {
        
        let myBoundSize: CGSize = UIScreen.main.bounds.size
        return myBoundSize.width
        
    }
    
    
    /* ナビゲーションバーの高さを取得する関数です */
    
    func getNavigationBarHeight () -> CGFloat {
        
        let height: CGFloat! = self.navigationController?.navigationBar.frame.height
        return height
        
    }
    
}
