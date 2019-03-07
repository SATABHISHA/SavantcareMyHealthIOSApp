//
//  AboutUsViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 18/07/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var labelUrlLink: UILabel!
    
    @IBAction func btnBack(_ sender: Any) {
        self.performSegue(withIdentifier: "home", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        labelUrlLink.isUserInteractionEnabled = true
     /*  var string = "www.savantcare.com"
        var attributedString = NSMutableAttributedString(string: string, attributes:[NSAttributedStringKey.link: URL(string: "https://www.savantcare.com")!])
        labelUrlLink.attributedText = attributedString*/
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunctionLabel))
        self.labelUrlLink.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tapFunctionLabel(sender: UITapGestureRecognizer){
        print("tap is working")
//        var string = "www.savantcare.com"
//        var attributedString = NSMutableAttributedString(string: string, attributes:[NSAttributedStringKey.link: URL(string: "https://www.savantcare.com")!])
//        labelUrlLink.attributedText = attributedString
        
        if let url = NSURL(string:"https://www.savantcare.com"){
//            UIApplication.shared.openURL(url as URL)
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
  

}
