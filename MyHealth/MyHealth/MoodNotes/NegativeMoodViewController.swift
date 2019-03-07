//
//  NegativeMoodViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 02/08/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit

class NegativeMoodViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    var arrNegativeFeelings = ["Afraid","Angry","Annoyed","Anxious","Ashamed","Bored","Burnt out","Confused","Demoralized","Depressed","Disappointed","Disgusted","Distraught","Embarrassed","Empty","Exhausted","Frustrated","Furious","Guilty","Insecure","Irritated","Jealous","Jittery","Lethargic","Lonely","Nervous","Numb","Resentful","Sad","Self-conscious","Stressed","Tired","Worried"]
    
    
    @IBAction func btnCancelRatingForm(_ sender: Any) {
        cancelRatingFormPopup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //===========function to open and close popup code starts===========
    
    @IBOutlet var ratingFormView: UIView!
    //    @IBOutlet weak var ratingFormView: UIView!
     //-------openPopup function code starts---------
    func openRatingFormPopup(){
        blurEffect()
        self.view.addSubview(ratingFormView)
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.height
        //        ratingFormView.frame.size = CGSize.init(width: screenWidth, height: ratingFormView.frame.height)
        ratingFormView.transform = CGAffineTransform.init(scaleX: 1.3,y :1.3)
        ratingFormView.center = self.view.center
        ratingFormView.alpha = 0
        ratingFormView.sizeToFit()
        
        UIView.animate(withDuration: 0.3) {
            self.ratingFormView.alpha = 1
            self.ratingFormView.transform = CGAffineTransform.identity
        }
    }
    //-------openPopup function code ends---------
    
    //------close popup code starts------
    func cancelRatingFormPopup() {
        UIView.animate(withDuration: 0.3, animations: {
            self.ratingFormView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.ratingFormView.alpha = 0
            self.blurEffectView.alpha = 0.3
        }) { (success) in
            self.ratingFormView.removeFromSuperview()
            self.canelBlurEffect()
        }
        
    }
    //-----close popup code ends-------
    //===========function to open and close popup code ends==============
    
    // ====================== Blur Effect Defiend START ================= \\
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var blurEffectView: UIVisualEffectView!
    var loader: UIVisualEffectView!
    func loaderStart() {
        // ====================== Blur Effect START ================= \\
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        loader = UIVisualEffectView(effect: blurEffect)
        loader.frame = view.bounds
        loader.alpha = 2
        view.addSubview(loader)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 2, y: 2)
        activityIndicator.transform = transform
        loadingIndicator.center = self.view.center;
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        loadingIndicator.startAnimating();
        loader.contentView.addSubview(loadingIndicator)
        
        // screen roted and size resize automatic
        loader.autoresizingMask = [.flexibleBottomMargin, .flexibleHeight, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleWidth];
        
        // ====================== Blur Effect END ================= \\
    }
    
    func loaderEnd() {
        self.loader.removeFromSuperview();
    }
    // ====================== Blur Effect Defiend END ================= \\
    
    // ====================== Blur Effect START ================= \\
    func blurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0.9
        view.addSubview(blurEffectView)
        // screen roted and size resize automatic
        blurEffectView.autoresizingMask = [.flexibleBottomMargin, .flexibleHeight, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleWidth];
        
        // ====================== Blur Effect END ================= \\
    }
    func canelBlurEffect() {
        self.blurEffectView.removeFromSuperview();
    }
    
    
    //============tableview code starts===========
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNegativeFeelings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell") as! NegativeFeelingsTableViewCell
        cell.view.layer.cornerRadius = 10
        cell.labelNegativeFeelings.text = arrNegativeFeelings[indexPath.row]
        return cell
    }
    //---------onClick tableview code starts----------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var row=arrNegativeFeelings[indexPath.row]
        print(row)
        print("tap is working")
        openRatingFormPopup()
       
    }
    //---------onClick tableview code ends----------
    //===========tableview code ends=============

}
