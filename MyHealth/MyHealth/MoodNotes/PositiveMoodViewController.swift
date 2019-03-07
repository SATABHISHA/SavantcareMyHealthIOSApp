//
//  PositiveMoodViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 02/08/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit
//import PopupDialog

class PositiveMoodViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var labelClose: UILabel!
    @IBOutlet weak var tableview: UITableView!
    var arrPositiveFeelings = ["Bold","Calm","Cheerful","Confident","Content","Eager","Ecstatic","Energized","Engaged","Enthusiastic","Excited","Grateful","Happy","Humorous","Inspired","Joyful","Lively","Loving","Motivated","Optimistic","Passionate","Peaceful","Playful","Proud","Reassured","Refreshed","Relaxed","Relieved","Satisfied","Secure","Surprised","Thrilled","Wonderful"]
    
   
    @IBAction func btnCancelRatingForm(_ sender: Any) {
        cancelRatingFormPopup()
    }
    @objc func tapFunction_ViewClose(sender:UITapGestureRecognizer){
        print("tapped")
       /* let vc = self.storyboard?.instantiateViewController(withIdentifier: "moodHome") as! MoodHomeViewController
        self.present(vc, animated: true, completion: nil)*/
        self.performSegue(withIdentifier: "moodHome", sender: self)
       
    }
    @IBAction func btnSave(_ sender: Any) {
        self.performSegue(withIdentifier: "positiveDetail", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
       
        // Do any additional setup after loading the view.
        let tapClose = UITapGestureRecognizer(target: self,action: #selector(tapFunction_ViewClose))
        labelClose.isUserInteractionEnabled = true
        labelClose.addGestureRecognizer(tapClose)
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
    
    //================function to convert hexacode to UIColor code starts==============
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    //================function to convert hexacode to UIColor code ends==============
    
    
    @IBAction func ratingSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        print("slider value: \(currentValue)")
    }
    
    
    //================function to open and close popup code starts=============
     @IBOutlet var ratingFormView: UIView!
    
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
            self.ratingFormView.removeFromSuperview();
            self.canelBlurEffect()
        }
    }
    //-----close popup code ends-------
    //================function to open and close popup code ends===========
    
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
    
    // ====================== Popup Dialog START ================= \\
   /* func showPopupDialog(title: String, message: String, Buttons: Array<Any>, Alignment: UILayoutConstraintAxis) {
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: Alignment,//.horizontal, // .vertical
            transitionStyle: .zoomIn,
            gestureDismissal: true,
            hideStatusBar: true
        )
        if Buttons.count > 0 {
            popup.addButtons(Buttons as! [PopupDialogButton])
        }
        
        self.present(popup, animated: true, completion: nil)
    }*/
    // ====================== Popup Dialog END ================= \\
    //===========tableview code starts==========
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPositiveFeelings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let colors = [UIColor.red, UIColor.blue, UIColor.green, UIColor.orange, UIColor.purple]
        let colors = [hexStringToUIColor(hex: "#33ECFF"), hexStringToUIColor(hex: "#8E8D8E")]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PositiveFeelingsTableViewCell
        //        cell.layer.cornerRadius = 10
        //        cell.layer.borderWidth=1
        
        //        cell.layer.borderColor=UIColor.blue.cgColor
        
        //        cell.view_linedraw.
        cell.view.layer.cornerRadius = 18
//        cell.backgroundColor = colors[indexPath.row % colors.count]
//        cell.view.backgroundColor = colors[indexPath.row % colors.count]
       /* var dict = arrRes[indexPath.row]
        cell.labelMedicineName.text = dict["name"] as? String
        cell.labelQuantityRefilSupply.text = "\(dict["quantity"] as! String) |  Refill: \(dict["numberOfRefills"] as! String)  |  Days of Supply: \(dict["daysSupply"] as? String ?? "")"
        cell.labelPatient.text = dict["noteToPharmacist"] as? String ?? ""
        cell.labelPatient.text = dict["directionToPatient"] as? String ?? ""
        cell.labelPrescribedBy.text = "\(dict["userFullName"] as? String ?? "")  \(dict["created_at"] as? String ?? "")"*/
        cell.labelPositiveFeelingName.text = self.arrPositiveFeelings[indexPath.row]
        return cell
        
    }
    //---------onClick tableview code starts----------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var row=arrPositiveFeelings[indexPath.row]
        print(row)
        print("tap is working")
        openRatingFormPopup()
      /*  let publicUniqueId=row["publicUniqueId"] as? String
        print(publicUniqueId!)
        // UserSingletonModel.sharedInstance.goalID=row["id"] as? Int
        // UserSingletonModel.sharedInstance.goalPublicUid=row["goalPublicUid"] as? String
        // print(UserSingletonModel.sharedInstance.goalPublicUid!)
        // get_Goal_details()
        UserSingletonModel.sharedInstance.helpdesk_status=row["status"] as? String
        UserSingletonModel.sharedInstance.helpdesk_statusId=row["statusId"] as? Int
        UserSingletonModel.sharedInstance.helpdesk_created_at=row["created_at"] as? String
        UserSingletonModel.sharedInstance.helpdesk_description=row["description"] as? String
        UserSingletonModel.sharedInstance.helpdesk_userId=row["userId"] as? Int
        UserSingletonModel.sharedInstance.helpdesk_title=row["title"] as? String
        UserSingletonModel.sharedInstance.helpdesk_public_unique_id=row["publicUniqueId"] as? String
        
        self.performSegue(withIdentifier: "helpdeskdesc", sender: self)*/
    }
    //---------onClick tableview code ends----------
    //==========tableview code ends===============
}
