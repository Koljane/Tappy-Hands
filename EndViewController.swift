//
//  EndViewController.swift
//  Tappy Hands
//
//  Created by Konstantin Nenadov on 6/6/17.
//  Copyright © 2017 Konstantin Nenadov. All rights reserved.
//

import UIKit
import Social
import MessageUI
import GoogleMobileAds

class EndViewController: UIViewController,MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, GADBannerViewDelegate {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var bannerView: GADBannerView!
    
    
    var scoreData: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label1.layer.cornerRadius = 5.0
        label2.layer.cornerRadius = 5.0
        
        button1.layer.cornerRadius = 5.0
        button2.layer.cornerRadius = 5.0
        button3.layer.cornerRadius = 5.0
        button4.layer.cornerRadius = 5.0
        
        scoreLabel.text = scoreData
        
        bannerView.isHidden = true
        
        bannerView.delegate = self
        
        bannerView.adUnitID = "ca-app-pub-1022963532676886/1974865852"
        bannerView.adSize = kGADAdSizeSmartBannerPortrait
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        func adViewDidReceiveAd(_ bannerView: GADBannerView) {
            
            bannerView.isHidden = false
            
        }
        
        func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
            
            bannerView.isHidden = true
        }

        
    }

    @IBAction func restartGame(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
        self.presentingViewController?.dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func shareTwitter(_ sender: Any) {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            
            let twitter:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            twitter.setInitialText("My final score was: \(scoreLabel.text!)")
            
            self.present(twitter, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Accounts", message: "Please log into your twitter accountwithin the settings", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func shareEmail(_ sender: Any) {
        
        if MFMailComposeViewController.canSendMail() {
            
            let mail:MFMailComposeViewController = MFMailComposeViewController()
            
            mail.mailComposeDelegate = self
            
            mail.setToRecipients(nil)
            mail.setSubject("I bet you can`t beat me!")
            mail.setMessageBody("My final score was: \(scoreLabel.text!)", isHTML: false)
            
            self.present(mail, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Accounts", message: "Please log into your email account", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

    @IBAction func shareSMS(_ sender: Any) {
        
        if MFMessageComposeViewController.canSendText() {
            
            let message: MFMessageComposeViewController = MFMessageComposeViewController()
            
            message.messageComposeDelegate = self
            
            message.recipients = nil
            message.body = "My final score was: \(scoreLabel.text!)"
            
            self.present(message, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Warning", message: "This device can not send SMS messages", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
 
}






















