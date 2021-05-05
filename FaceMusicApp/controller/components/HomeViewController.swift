//
//  HomeViewController.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/12.
//

import UIKit

/* コンテンツを表示する画面コントローラーです */

class HomeViewController: BaseViewController {
    
    /* View変数 */
    
    private lazy var cardView : CardButton = {
        
        //インスタンス化します
        let view = CardButton(frame: self.view.frame)
        //デリゲートを設定します
        view.delegate = self
        
        return view
        
    }()
    
    
    private lazy var progressBar: ProgressBar = {
       
        //インスタンス化します
        let view = ProgressBar(frame: self.view.frame)
        
        return view
    }()

    
    /* メモリにロードされた後に呼ばれるコールバックメソッドです */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //viewを親Viewに追加します
        view.addSubview(cardView.getView())
        view.addSubview(progressBar.getView())
        
        //ナビゲーションバーの戻るボタンを非表示にします
        navigationItem.hidesBackButton = true
        
        //HomeViewControllerのタイトルを設定します
        self.title = TextUtil.title_homeView
    
        //次の画面のナビゲーションバーの設定を行います
        //テキストなしの戻るボタンを設定します
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
      
     
    }
    
    /* viewが描画される前に呼ばれるコールバックメソッドです */
    
    override func viewWillLayoutSubviews() {
        
        //コンポーネントの配置を変更します
        cardView.setLayout(frame: view.frame, top: getSafeAreaTopHeight(view: view) + getNavigationBarHeight() + SizeUtil.margin * 2, left: SizeUtil.margin * 2)
        
    }
    
}


extension HomeViewController: CardButtonDelegate {
    
    /* cardViewをタップした際に実行されるコールバックメソッドです */
    
    func onTapped() {
       
        //画面遷移を行います
        let viewControler = CameraViewController()
        navigationController?.pushViewController(viewControler, animated: true)
        
    }
}
