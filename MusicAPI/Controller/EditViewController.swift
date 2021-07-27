//
//  EditViewController.swift
//  MusicAPI
//
//  Created by 大江祥太郎 on 2021/07/27.
//

import UIKit
import AVKit

class EditViewController: UIViewController {

    var url:URL?
    
    var playerController:AVPlayerViewController?
    var player:AVPlayer?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //viewwillappearの後に呼ばれるメソッド
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setUpVideoPlayer(url: url!)
    }
    
    func setUpVideoPlayer(url:URL){
        
        //重なり排除
        //viewcontrollerを親から取り除く
        self.playerController?.removeFromParent()
        player = nil
        
        view.backgroundColor = .black
        
        playerController = AVPlayerViewController()
        playerController?.videoGravity = .resizeAspectFill
        playerController?.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 100)
        playerController?.showsPlaybackControls = false
        playerController?.player = player
        self.addChild(playerController!)
        self.view.addSubview((playerController?.view)!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
        
        let cancelButton = UIButton(frame: CGRect(x: 10.0, y: 10.0, width: 30.0, height: 30.0))
        
        cancelButton.setImage(UIImage(named: "cancel"), for: UIControl.State())
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        view.addSubview(cancelButton)
        
        player?.play()
    
    }
    
    @objc func cancel(){
        //画面を戻る
        self.navigationController?.popViewController(animated: true)
        
    }

    @objc func playerItemDidReachEnd(){
        
        //繰り返しが可能になる。
        if self.player != nil {
            //seek求める
            self.player?.seek(to: CMTime.zero)
            self.player?.volume = 1
            self.player?.play()
        }
    }

}
