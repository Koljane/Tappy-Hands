//
//  ViewController.swift
//  Tappy Hands
//
//  Created by Konstantin Nenadov on 6/5/17.
//  Copyright © 2017 Konstantin Nenadov. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet var bannerView: GADBannerView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label1.layer.cornerRadius = 5.0
        button.layer.cornerRadius = 5.0
        
        bannerView.isHidden = true
        
        bannerView.delegate = self
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.string(forKey: "Record")
        
        if (value == nil) {
            
            label2.text = "0"
            
        } else {
            
            label2.text = value
            
        }
    }




}

