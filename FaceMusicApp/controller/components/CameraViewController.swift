//
//  CameraViewController.swift
//  FaceMusic
//
//  Created by 松浦裕久 on 2021/03/12.
//

import UIKit
import Foundation

class CameraViewController: BaseViewController {
    
    /* view変数 */
    
    private lazy var guideView1: GuideView = {
        
        let view = GuideView(frame: self.view.frame, title: TextUtil.step1Title, subTitle: TextUtil.step1SubTitle, imageName: ImageEnum.step1.rawValue, message: TextUtil.step1Message)
        return view
        
    }()
    
    private lazy var guideView2: GuideView = {
        
        let view = GuideView(frame: self.view.frame, title: TextUtil.step2Title, subTitle: TextUtil.step2SubTitle, imageName: ImageEnum.step2.rawValue, message: TextUtil.step2Message)
        return view
        
    }()
    
    private lazy var guideView3: GuideView = {
        
        let view = GuideView(frame: self.view.frame, title: TextUtil.step3Title, subTitle: TextUtil.step3SubTitle, imageName: ImageEnum.step3.rawValue, message: TextUtil.step3Message)
        return view
        
    }()
    
    private lazy var nextButton : NextButton = {
        
        //インスタンス化します
        let view = NextButton(frame: self.view.frame)
        //デリゲートを設定します
        view.delegate = self
        
        return view
        
    }()
    
    //オーバーレイ
    
    private lazy var overlay: LoadingView = {
        
        let view = LoadingView(frame: self.view.frame, message: "AIで分析中です")
        return view
        
    }()
    
    
    /* メンバー変数 */
    
    private var objectName: String = ""
    
    private var showLoading: Bool = false
    
 
    /* メモリにロードされた後に呼ばれるコールバックメソッドです */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //デリゲートを設定します
        AmazonS3Util.shared.delegate = self
        FaceAPIUtil.shared.delegate = self
        
        //viewを親Viewに追加します
        view.addSubview(nextButton.getView())
        view.addSubview(guideView1.getView())
        view.addSubview(guideView2.getView())
        view.addSubview(guideView3.getView())
        
        //HomeViewControllerのタイトルを設定します
        self.title = TextUtil.title_cameraView
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if showLoading {
            //サーバとの通信中の場合
            showOverlay()
        }
    }
    
    /* viewが描画される前に呼ばれるコールバックメソッドです */
    
    override func viewWillLayoutSubviews() {
        
        //コンポーネントの配置を変更します
        nextButton.setLayout(frame: self.view.frame, top: getScreenHeight() - getSafeAreaBottomHeight(view: view) - SizeUtil.margin * 2 - SizeUtil.buttonHeight)
        
        guideView1.setLayout(frame: self.view.frame, top: getSafeAreaTopHeight(view: view) + getNavigationBarHeight() + SizeUtil.margin * 2, left: SizeUtil.margin * 2, width: getScreenWidth())
        
        guideView2.setLayout(frame: self.view.frame, top: getSafeAreaTopHeight(view: view) + getNavigationBarHeight() + SizeUtil.margin * 2 + guideView1.getHeight() + SizeUtil.margin * 4, left: SizeUtil.margin * 2, width: getScreenWidth())
        
        guideView3.setLayout(frame: self.view.frame, top: getSafeAreaTopHeight(view: view) + getNavigationBarHeight() + SizeUtil.margin * 2 + guideView1.getHeight() + SizeUtil.margin * 4 + guideView2.getHeight() + SizeUtil.margin * 4, left: SizeUtil.margin * 2, width: getScreenWidth())
    }
    
    /* オーバーレイを表示するメソッドです */
    
    func showOverlay () {
        
        navigationController?.view.addSubview(overlay.getView())
        overlay.setLayout(frame: view.frame)
        //アニメーションを実行します
        overlay.doAnimation()
    }
    
    /* オーバーレイを非表示にします */
    
    func deleteOverlay () {
        
        overlay.getView().removeFromSuperview()
        
    }
    
    
}

extension CameraViewController: NextButtonDelegate {
    
    //[NEXT]ボタンをタップした時に実行されるメソッドです
    
    func onTapped() {
        
        //カメラを起動します
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
    }
    
}


extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //撮影後に実行される関数です
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        showLoading = true
        
        //撮影した画像
        let image = info[.originalImage] as! UIImage
        //カメラを閉じます
        self.dismiss(animated: true, completion: nil)
        
        
        //オブジェクトキーを代入します
        objectName = CommonUtil.getObjectKeyName()
        
        //AmazonS3に画像をアップロードします
        AmazonS3Util.shared.uploadObject(key: objectName, data: image.jpegData(compressionQuality: 0.5)!)
        
        
    }
    
}

extension CameraViewController: AmazonS3Delegate {
    
    /* AmazonS3への画像アップロードが完了した後に実行されるコールバックメソッドです */
    
    func onUploaded(status: Int) {
        
        if status == Exconst.UPLOADED_SUCCESS {
            //画像アップロードに成功した場合
            
            //署名付きURLを生成します
            let imageUrl = AmazonS3Util.shared.createURL(key: objectName)
            
            //FaceAPIを呼び出します
            FaceAPIUtil.shared.sendImageToMicrosoft(imageUrl: imageUrl)
            
            
        } else {
            //画像アップロードに失敗した場合
            
        }
    }
    
}


extension CameraViewController: FaceAPIDelegate {
    
    //FaceAPIをコールした後に実行されるデリゲートです
    
    func onResponse(statusCode: Int, data: FaceAPIResult?) {
        
        showLoading = false
        
        DispatchQueue.main.async {
            
            //オーバーレイを解除します
            self.deleteOverlay()
        }
        
        if statusCode == Exconst.CALL_SUCCESS {
            //FaceAPIのコールに成功した場合
            
            //S3内のオブジェクトを削除します
            AmazonS3Util.shared.deleteObject(key: objectName)
            
            
            //メインスレッドで画面遷移を行います
            DispatchQueue.main.async {
                
                //オーバーレイ表示を解除します
                self.deleteOverlay()
                
                //画面遷移を行います
                let viewController = FaceApiResultViewController()
                //次の画面に顔情報を渡します
                viewController.faceData = data!
                self.navigationController?.pushViewController(viewController, animated: true)
                
            }
            
            
        } else if statusCode == Exconst.NON_FACE_IMAGE_ERROR {
            //FaceAPIのコールに失敗した場合(撮影時に顔が写っていない場合)
            print("顔が写っていません")
            
             
        } else {
            //FaceAPIのコールに失敗した場合(その他エラーの場合)
            
            
        }
    }
}
