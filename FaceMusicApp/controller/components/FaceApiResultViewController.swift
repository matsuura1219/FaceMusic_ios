//
//  FaceApiResultViewController.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/15.
//

import UIKit

class FaceApiResultViewController: BaseViewController {
    
    /* 変数 */
    
    //撮影画像から取得した顔情報
    var faceData: FaceAPIResult!
    
    /* view変数 */
    
    //進捗バー
    
    private lazy var angerBar: ProgressBar = {
       
        let view = ProgressBar(frame: self.view.frame)
        return view
        
    }()
    
    private lazy var contemptBar: ProgressBar = {
       
        let view = ProgressBar(frame: self.view.frame)
        return view
        
    }()
    
    private lazy var disgustBar: ProgressBar = {
       
        let view = ProgressBar(frame: self.view.frame)
        return view
        
    }()
    
    private lazy var fearBar: ProgressBar = {
       
        let view = ProgressBar(frame: self.view.frame)
        return view
        
    }()
    
    private lazy var happinessBar: ProgressBar = {
       
        let view = ProgressBar(frame: self.view.frame)
        return view
        
    }()
    
    private lazy var neutralBar: ProgressBar = {
       
        let view = ProgressBar(frame: self.view.frame)
        return view
        
    }()
    
    private lazy var sadnessBar: ProgressBar = {
       
        let view = ProgressBar(frame: self.view.frame)
        return view
        
    }()
    
    private lazy var surpriseBar: ProgressBar = {
       
        let view = ProgressBar(frame: self.view.frame)
        return view
        
    }()
    
    //ラベル
    
    private lazy var angerLabel: BarLabel = {
        
        let label = BarLabel(frame: self.view.frame, title: TextUtil.anger)
        return label
        
    }()
    
    private lazy var contemptLabel: BarLabel = {
        
        let label = BarLabel(frame: self.view.frame, title: TextUtil.contempt)
        return label
        
    }()
    
    private lazy var disgustLabel: BarLabel = {
        
        let label = BarLabel(frame: self.view.frame, title: TextUtil.disgust)
        return label
        
    }()
    
    private lazy var fearLabel: BarLabel = {
        
        let label = BarLabel(frame: self.view.frame, title: TextUtil.fear)
        return label
        
    }()
    
    private lazy var happinessLabel: BarLabel = {
        
        let label = BarLabel(frame: self.view.frame, title: TextUtil.happiness)
        return label
        
    }()
    
    private lazy var neutralLabel: BarLabel = {
        
        let label = BarLabel(frame: self.view.frame, title: TextUtil.neutral)
        return label
        
    }()
    
    private lazy var sadnessLabel: BarLabel = {
        
        let label = BarLabel(frame: self.view.frame, title: TextUtil.sadness)
        return label
        
    }()
    
    private lazy var surpriseLabel: BarLabel = {
        
        let label = BarLabel(frame: self.view.frame, title: TextUtil.surprise)
        return label
        
    }()
    
    //[NEXT]ボタン
    
    private lazy var nextButton: NextButton = {
        
        let button = NextButton(frame: self.view.frame)
        return button
        
    }()
    
    //スクロールView
    
    private lazy var scrollView: ScrollView = {
        
        let scrollView = ScrollView(frame: self.view.frame)
        return scrollView
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //HomeViewControllerのタイトルを設定します
        self.title = TextUtil.title_faceApiResultView
        
        //viewを追加します
        self.view.addSubview(scrollView.getView())
        
        scrollView.getView().addSubview(angerBar.getView())
        scrollView.getView().addSubview(contemptBar.getView())
        scrollView.getView().addSubview(disgustBar.getView())
        scrollView.getView().addSubview(fearBar.getView())
        scrollView.getView().addSubview(happinessBar.getView())
        scrollView.getView().addSubview(neutralBar.getView())
        scrollView.getView().addSubview(sadnessBar.getView())
        scrollView.getView().addSubview(surpriseBar.getView())
        
        scrollView.getView().addSubview(angerLabel.getView())
        scrollView.getView().addSubview(contemptLabel.getView())
        scrollView.getView().addSubview(disgustLabel.getView())
        scrollView.getView().addSubview(fearLabel.getView())
        scrollView.getView().addSubview(happinessLabel.getView())
        scrollView.getView().addSubview(neutralLabel.getView())
        scrollView.getView().addSubview(sadnessLabel.getView())
        scrollView.getView().addSubview(surpriseLabel.getView())
        scrollView.getView().addSubview(nextButton.getView())
        
        view.addSubview(nextButton.getView())
    
        //デリゲートを設定します
        nextButton.delegate = self
        
    }
    
    override func viewWillLayoutSubviews() {
        
        
        //sefeArea外の上部の高さ + ナビゲーションの高さ
        let top = getSafeAreaTopHeight(view: view) + getNavigationBarHeight()
        //配列に格納します
        let components: [BarLabel: ProgressBar] = [angerLabel: angerBar,
                                                   contemptLabel: contemptBar,
                                                   disgustLabel: disgustBar,
                                                   fearLabel: fearBar,
                                                   happinessLabel: happinessBar,
                                                   neutralLabel: neutralBar,
                                                   sadnessLabel: sadnessBar,
                                                   surpriseLabel: surpriseBar]
        
        //レイアウトを行います
        var height: CGFloat = 0
        
        for component in components {
            
            //ラベルの配置を行います
            component.key.setLayout(frame: view.frame, top: height + SizeUtil.margin * 2, left: SizeUtil.margin * 2)
            //プログレスバーの配置を行います
            component.value.setLayout(frame: view.frame, top: height + SizeUtil.margin * 4 + component.key.getHeight(), left: SizeUtil.margin * 2)
            
            //viewの高さをインクリメントします
            height = SizeUtil.margin * 4 + component.key.getHeight() + component.value.getHeight() + height
            
        }
        
        //frameを設定します
        scrollView.setLayout(frame: view.frame, top: top, left: 0, height: getScreenHeight() - getSafeAreaTopHeight(view: view) - getSafeAreaBottomHeight(view: view) - getNavigationBarHeight() - SizeUtil.buttonHeight - SizeUtil.margin * 4 - SizeUtil.margin * 2, contentHeight: height)
        
        //frameを設定します
        nextButton.setLayout(frame: view.frame, top: getScreenHeight() - getSafeAreaBottomHeight(view: view) - SizeUtil.margin * 2 - SizeUtil.buttonHeight)
    }
    
    /* viewが表示された時に呼ばれるコールバックメソッドです */
    
    override func viewDidAppear(_ animated: Bool) {
        
        //アニメーションを実行します
        angerBar.doaAnimation(rate: CGFloat(faceData.faceAttributes.emotion.anger))
        contemptBar.doaAnimation(rate: CGFloat(faceData.faceAttributes.emotion.contempt))
        disgustBar.doaAnimation(rate: CGFloat(faceData.faceAttributes.emotion.disgust))
        fearBar.doaAnimation(rate: CGFloat(faceData.faceAttributes.emotion.fear))
        happinessBar.doaAnimation(rate: CGFloat(faceData.faceAttributes.emotion.happiness))
        neutralBar.doaAnimation(rate: CGFloat(faceData.faceAttributes.emotion.neutral))
        sadnessBar.doaAnimation(rate: CGFloat(faceData.faceAttributes.emotion.sadness))
        surpriseBar.doaAnimation(rate: CGFloat(faceData.faceAttributes.emotion.surprise))
        
    }
    
   

}


extension FaceApiResultViewController: NextButtonDelegate {
    
    /* [NEXT]ボタンを押したときに実行されるコールバックメソッドです */
    
    func onTapped() {
        
        //
        
    }
}
