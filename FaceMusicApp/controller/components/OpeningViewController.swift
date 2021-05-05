//
//  OpeningViewController.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/11.
//

import UIKit

/* アプリを起動した際に、初めに表示される画面コントローラーです */

class OpeningViewController: BaseViewController {
    
    /* 定数 */
    
    //アニメーションの時間
    private let ANIMATION_TIME: Double = 3.0
    
    /* View変数 */
    
    private lazy var logoView : LogoView = {
        
        //インスタンス化します
        let view = LogoView(frame: self.view.frame)
        
        return view
        
    }()
    
    /* メモリにロードされた後に呼ばれるコールバックメソッドです */

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //viewを親Viewに追加します
        view.addSubview(logoView.getView())
        
        //タイマーを作成します
        createTimer()
            
    }
    
    
    /* viewが描画される前に呼ばれるコールバックメソッドです */
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        logoView.setLayout(frame: view.frame, top: getSafeAreaTopHeight(view: view), bottom: getSafeAreaBottomHeight(view: view), navigationHeight: (self.navigationController?.navigationBar.frame.height)!)
        
    }
    
    /* viewControllerが非表示になった場合に実行されるコールバックメソッドです */
    
    override func viewDidDisappear(_ animated: Bool) {
        
        //画面を破棄します
        self.removeFromParent()
    }
    
    
    /* Timerを生成するメソッドです */
    
    private func createTimer () {
        
        //ANIMATION_TIME秒後にdoAnimation()を実行します
        Timer.scheduledTimer(timeInterval: ANIMATION_TIME, target: self, selector: #selector(doAnimation), userInfo: nil, repeats: false)
        
    }
    
    
    /* ANIMATION_TIME後に実行されるメソッドです */
    
    @objc private func doAnimation () {
        
        //画面遷移を行います
        let viewControler = HomeViewController()
        navigationController?.pushViewController(viewControler, animated: true)
        
    }
  

}
