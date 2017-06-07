//
//  GameViewController.swift
//  Tappy Hands
//
//  Created by Konstantin Nenadov on 6/5/17.
//  Copyright © 2017 Konstantin Nenadov. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GameViewController: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet var bannerView: GADBannerView!
    
    
    var tapInt = 0
    var startInt = 3
    var startTimer = Timer()
    
    var gameInt = 10
    var gameTimer = Timer()
    
    var recordData: String!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label1.layer.cornerRadius = 5.0
        label2.layer.cornerRadius = 5.0
        button.layer.cornerRadius = 5.0
        
        tapInt = 0
        scoreLabel.text = String(tapInt)
        
        startInt = 3
        button.setTitle(String(startInt), for: .normal)
        button.isEnabled = false
        
        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.startGameTimer), userInfo: nil, repeats: true)
        
        gameInt = 10
        timeLabel.text = String(gameInt)
        
        let userDafaults = Foundation.UserDefaults.standard
        let value = userDafaults.string(forKey: "Record")
        recordData = value
        
        bannerView.isHidden = true
        
        bannerView.delegate = self
        
        bannerView.adUnitID = "ca-app-pub-1022963532676886/1974865852"
        bannerView.adSize = kGADAdSizeSmartBannerPortrait
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        
        bannerView.isHidden = false
        
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        
        bannerView.isHidden = true
    }

    @IBAction func tapMeButton(_ sender: Any) {
        
        tapInt += 1
        scoreLabel.text = String(tapInt)
        
    }
    
    func startGameTimer() {
        
        startInt -= 1
        button.setTitle(String(startInt), for: .normal)
        
        if startInt == 0 {
            
            startTimer.invalidate()
            
            button.setTitle("Tap Me", for: .normal)
            
            button.isEnabled = true
            
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.game), userInfo: nil, repeats: true)
        }
        
    }
    
    func game() {
        
        gameInt -= 1
        timeLabel.text = String(gameInt)
        
        if gameInt == 0 {
            
            gameTimer.invalidate()
            
            if recordData == nil {
                
                let savedString = scoreLabel.text
                let userDefaults = Foundation.UserDefaults.standard
                userDefaults.set(savedString, forKey: "Record")
                
            } else {
                
                let score: Int? = Int(scoreLabel.text!)
                let record: Int? = Int(recordData)
                
                if score! > record! {
                    
                    let savedString = scoreLabel.text
                    let userDefaults = Foundation.UserDefaults.standard
                    userDefaults.set(savedString, forKey: "Record")
                    
                }
                
            }
            
            
            
            button.isEnabled = false
            
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(GameViewController.end), userInfo: nil, repeats: false)
            
            
        }
        
    }
   
    func end() {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "endGame") as! EndViewController
            
            vc.scoreData = scoreLabel.text
            
            self.present(vc, animated: false, completion: nil)
            
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            let vc = UIStoryboard(name: "IPadStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "endGame") as! EndViewController
            
            vc.scoreData = scoreLabel.text
            
            self.present(vc, animated: false, completion: nil)
        
        
    }
    
}
    
    
    
    
    

  
}









