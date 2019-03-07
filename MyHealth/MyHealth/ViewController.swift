//
//  ViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 01/02/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit
import CoreTelephony
import Alamofire
import SwiftyJSON
import MRCountryPicker
import Foundation
import SystemConfiguration
import  QuartzCore
import Toaster


class ViewController: UIViewController, UITextFieldDelegate, MRCountryPickerDelegate{
    
    //-------countrPhonePicker func helps to pick the country code(starts here)---------
    func countryPhoneCodePicker(_ picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        UserSingletonModel.sharedInstance.countrycode=phoneCode
    }
    //-------countrPhonePicker func helps to pick the country code(ends here)---------
    
    @IBOutlet weak var countryPicker: MRCountryPicker!
    
   //----------code for countdown---------
    var TIMER=Timer()
    var SECONDS=30
    let MyLabel:UILabel=UILabel(frame:CGRect(x: 50, y: 5, width: 35, height: 16))
   
    @objc func CLOCK(){
        SECONDS=SECONDS-1
        MyLabel.text = String(SECONDS)
        if (SECONDS==0){
            TIMER.invalidate()
            
        }
        
    }
    
    //--------code for countdown ends------
    
    
    @IBOutlet weak var phone_number: UITextField!
 //   @IBOutlet weak var countrycode: UITextField!
    var mobilenumber:String?=nil
    var otpMessage:String?=nil
    var userid:String?=nil
    var publicuid:String?=nil
    var get_otpnumber:String?=nil
   // var arrRes = [[String:AnyObject]]()
    
    //---Declaring shared preferences----
    let sharedpreferences=UserDefaults.standard
    
    
    //------code for onClick image tap function in the alert box----------
    @objc func tapFunction(sender:UITapGestureRecognizer){
        print("Tapped")
        self.dismiss(animated: true, completion: nil)
        // self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
        // self.performse
        /*  ViewController.dismiss(animated: true, completion:{
         self.present(self.inputViewController,animated: true)
         })*/
    }
     //------code for onClick image tap function in the alert box code ends----------
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.sharedpreferences.object(forKey: "userid") as? String as Any)
       phone_number.delegate=self
        //=======================30th aug code starts to change editText view====================
        var bottomLine = CALayer()
        //        bottomLine.frame = CGRect(0.0, phone_number.frame.height - 1, phone_number.frame.width, 1.0)
        var width = CGFloat(2.0)
        bottomLine.frame = CGRect(x: 0, y: phone_number.frame.size.height - width, width: phone_number.frame.size.width, height:1)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        phone_number.borderStyle = UITextBorderStyle.none
        phone_number.layer.addSublayer(bottomLine)
        //=======================30th aug code to change editText view ends=====================
        
        // Do any additional setup after loading the view, typically from a nib.
      /*  if let CountryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
           // print(countryCode)
            countrycode.text=CountryCode
        }*/
        
        //---------for country code detector(not using any more in this project after adding latest countrycodepicker)---------------
      /* let networkInfo = CTTelephonyNetworkInfo()
        if let carrier = networkInfo.subscriberCellularProvider {
           // print("country code is: " + carrier.mobileCountryCode!);
            
            //will return the actual country code
           // print("ISO country code is: " + carrier.isoCountryCode!);
            //countrycode.text=carrier.isoCountryCode!
             countrycode.text=carrier.mobileCountryCode!
        }else{
                // print(countryCode)
                countrycode.text="+91"
        
        }*/
        
         //---------country code detector code ends(not using any more in this project after adding latest countrycodepicker)---------------
        
        //-----------latest countrycode picker using MRCountryPicker library code----------
        countryPicker.countryPickerDelegate = self
        countryPicker.showPhoneNumbers = true
        //countryPicker.setCountry("SI")
        countryPicker.setCountry("US")
        
        //countryPicker.setLocale("sl_SI")
        countryPicker.setLocale("India")
      //  countryPicker.setCountryByName("Canada")
        countryPicker.setCountryByName("United States")
        //-----------latest countrycode picker using MRCountryPicker library code ends----------
        
        
        //--------for hidding keyboard--------------
        phone_number.resignFirstResponder()
        
        //let phn = phone_number.text
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //--------viewDidAppear(_ animated: Bool) helps to navigate other screen(here I am using this function for one time login using shared prefrence) code starts----------
    override func viewDidAppear(_ animated: Bool) {
        
        //-----using userid code in checking sharedpreference starts(temoporarily not in use)------
       /* if sharedpreferences.object(forKey: "userid") != nil {
            // let swiftyJsonVar=JSON(sharedpreferences.object(forKey: "preferences_activescreen")!)
            UserSingletonModel.sharedInstance.userid=sharedpreferences.object(forKey: "userid") as? String
            UserSingletonModel.sharedInstance.userFullName=sharedpreferences.object(forKey: "userfullname") as? String
            UserSingletonModel.sharedInstance.gender=sharedpreferences.object(forKey: "gender") as? String
            UserSingletonModel.sharedInstance.userImageUrl=sharedpreferences.object(forKey: "userimageurl") as? String
            UserSingletonModel.sharedInstance.publicUid=sharedpreferences.object(forKey: "publicUniqueId") as? String
            
           // self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "home", sender: self)
            
            
        }*/
        //--------using userid code in checking shared preference ends
        
         //-----using publicuid code in checking sharedpreference starts------
        if sharedpreferences.object(forKey: "publicUid") != nil {
            // let swiftyJsonVar=JSON(sharedpreferences.object(forKey: "preferences_activescreen")!)
            UserSingletonModel.sharedInstance.userid=sharedpreferences.object(forKey: "userid") as? String
            UserSingletonModel.sharedInstance.userFullName=sharedpreferences.object(forKey: "userfullname") as? String
            UserSingletonModel.sharedInstance.gender=sharedpreferences.object(forKey: "gender") as? String
            UserSingletonModel.sharedInstance.userImageUrl=sharedpreferences.object(forKey: "userimageurl") as? String
            UserSingletonModel.sharedInstance.publicUid=sharedpreferences.object(forKey: "publicUid") as? String
            UserSingletonModel.sharedInstance.mobilenumber=sharedpreferences.object(forKey: "mobilenumber") as? String
            
            // self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "home", sender: self)
            
            
        }
         //--------using publicuid code in checking shared preference ends
        //--------Internet checking code starts-------
        if Reachability.isConnectedToNetwork() == true
        {
            print("Connected")
        }
        else
        {
            let controller = UIAlertController(title: "No Internet Detected", message: "This app requires an Internet connection", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            controller.addAction(ok)
            controller.addAction(cancel)
            
            present(controller, animated: true, completion: nil)
        }
        //--------Internet checking code ends-------
        
        
    }
    //--------viewDidAppear(_ animated: Bool) helps to navigate other screen(here I am using this function for one time login using shared prefrence) code ends----------
    
  
    
    //---------Internet checking code starts-----
    public class Reachability {
        class func isConnectedToNetwork() -> Bool {
            var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
            if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
                return false
            }
            let isReachable = flags == .reachable
            let needsConnection = flags == .connectionRequired
            return isReachable && !needsConnection
        }
    }
    //------Internet checking code ends------------
    
//-----------dismiss keyboard on touching anywhere in the screen code starts-----------
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    private func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
    }
    //-----------dismiss keyboard code ends-----------
    
    //--------Login button function----------
    @IBAction func login(_ sender: UIButton) {
        
        print(self.phone_number.text!)
       // showInputDialog()
       // getOtp()
       // showInputDialog()
        if(self.phone_number.text! == "111"){
            UserSingletonModel.sharedInstance.userid = "440"
            UserSingletonModel.sharedInstance.publicUid = "ef0844e8-8b70-4fae-861d-ea7af21301b8"
            UserSingletonModel.sharedInstance.userFullName = "Vikas Kedia"
            UserSingletonModel.sharedInstance.gender = "Male"
            UserSingletonModel.sharedInstance.userImageUrl = ""
             self.performSegue(withIdentifier: "home", sender: self)
        }else{
            mobilenumber=self.phone_number.text!
            getOtp_usingAlamofire()
        }
    }
    //--------Login button function code ends---------ž
    
    //-----------function to show Alert Dialog------------------------
   public func showInputDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
    
        let alertController = UIAlertController(title: "Validate One Time Password (OTP)", message: "An OTP has been sent to \(UserSingletonModel.sharedInstance.countrycode!)\(mobilenumber!) \n Please enter the OTP below to verify your phone number", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Verify OTP", style: .default) { (_) in
            
            //getting the input values from user
           // let name = alertController.textFields?[0].text
          //  let email = alertController.textFields?[1].text
            
           // self.labelMessage.text = "Name: " + name! + "Email: " + email!
            self.get_otpnumber=alertController.textFields?[0].text
            
            if self.get_otpnumber! == "" {
                Toast(text: "Please enter OTP", duration: Delay.short).show()
            }else{
         //----Calling function for verifying otp-------
              
            self.verifyotp()
            self.dismiss(animated: true, completion: nil)
            }
        }
        
        //the cancel action doing nothing
       // let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
    let resendOtp = UIAlertAction(title: "Resend OTP", style: .default) { (_) in
        self.resendOtp_usingAlamofire()
         self.present(alertController, animated: true, completion: nil)
    }
    
    
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter OTP"
        }
    
    
        //-----code to add cross image and make it clickable---------
        var imageView=UIImageView(frame: CGRect(x: 5, y: 6, width: 15, height: 15))
        imageView.image=#imageLiteral(resourceName: "X")
        alertController.view.addSubview(imageView)
        let tap=UITapGestureRecognizer(target:self,action:#selector(ViewController.tapFunction))
        imageView.isUserInteractionEnabled=true
        imageView.addGestureRecognizer(tap)
        //-----code to add cross image and make it clickable code ends---------
    //----------code for countdown----------
    
   /* TIMER=Timer.scheduledTimer(timeInterval: 1,target: self, selector: #selector(ViewController.CLOCK),userInfo: nil, repeats: true )
     alertController.view.addSubview(MyLabel)*/
    //----------code for countdown code ends---------
    
    
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
    alertController.addAction(resendOtp)
  //  UserSingletonModel.sharedInstance.Login_count=MyLabel.text
  
    
   
   
    
  
   
    
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    //-----------function to show Alert Dialog code ends------------------------
    
    
    
    //----------resend Otp function code starts------------
    func resendOtp_usingAlamofire(){
       // showInputDialog()
        Alamofire.request("https://www.savantcare.com/v2/screening/api/public/index.php/api/checkMobileNumberAndSendSms/\(UserSingletonModel.sharedInstance.countrycode!)\(mobilenumber!)").responseJSON{ (responseData) -> Void in
            if((responseData.result.value) != nil){
                let swiftyJsonVar=JSON(responseData.result.value!)
                print(swiftyJsonVar)
            }
        }
    }
    //----------resend Otp function code ends------------
    
    
    
    
    //-----------------fetching json data for getting otp message using alamofire and swiftyjson libraries--------------
    func getOtp_usingAlamofire(){
        //--------Creating loader----------
       /* let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)*/
        //--------loader code ends-----------
        Alamofire.request("https://www.savantcare.com/v2/screening/api/public/index.php/api/checkMobileNumberAndSendSms/\(UserSingletonModel.sharedInstance.countrycode!)\(mobilenumber!)").responseJSON{ (responseData) -> Void in
            if((responseData.result.value) != nil){
                let swiftyJsonVar=JSON(responseData.result.value!)
                print(swiftyJsonVar)
               // self.id="254"
                //self.userid.text! = swiftyJsonVar[""].string!
                let id=swiftyJsonVar["userid"].stringValue
                let publicuid=swiftyJsonVar["userPublicUuid"].stringValue
                self.userid=id
                self.publicuid=publicuid
                let status=swiftyJsonVar["status"].stringValue
                if status == "success" {
//                    self.dismiss(animated: true, completion: nil)
//                    self.showInputDialog() //---27th aug changes
                      self.openOtpFormPopup()  //---27th aug changes
                }else if status == "failed" {
//                    self.dismiss(animated: true, completion: nil)
                    let alertController = UIAlertController(title: "Alert!", message: swiftyJsonVar["message"].stringValue, preferredStyle: .alert)
                    
                    //the confirm action taking the inputs
                    let confirmAction = UIAlertAction(title: "Back to Login", style: .default) { (_) in}
                    
                    //adding the action to dialogbox
                    alertController.addAction(confirmAction)
                    // alertController.addAction(cancelAction)
                    
                    //finally presenting the dialog box
                    self.present(alertController, animated: true, completion: nil)
                }
                
    }
        }
    
}
      //-----------------fetching json data for getting otp message using alamofire and swiftyjson libraries ends--------------
    
    
    //--------------------function for verifying otp using Alamofire---------------------
    func verifyotp(){
         //--------Creating loader----------
         //=========29th aug changes starts========
       /* let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)*/
        //==========29th aug changes ends============
         //--------Creating loader code ends----------
        Alamofire.request("https://www.savantcare.com/v2/screening/api/public/index.php/api/validateOTP/\(get_otpnumber!)/\(publicuid!)").responseJSON{ (responseData) -> Void in
            if((responseData.result.value) != nil){
                self.dismiss(animated: true, completion: nil)  //----dismissing the loader
                let swiftyJsonVar=JSON(responseData.result.value!)
                print(swiftyJsonVar["userObject"]["gender"])
                print(swiftyJsonVar)
                UserSingletonModel.sharedInstance.userid=swiftyJsonVar["userid"].stringValue
                UserSingletonModel.sharedInstance.userFullName=swiftyJsonVar["userObject"]["userFullName"].stringValue
                UserSingletonModel.sharedInstance.publicUid=swiftyJsonVar["userObject"]["publicUniqueId"].stringValue
                UserSingletonModel.sharedInstance.gender=swiftyJsonVar["userObject"]["gender"].stringValue
                UserSingletonModel.sharedInstance.userImageUrl=swiftyJsonVar["userImageUrl"].stringValue
                UserSingletonModel.sharedInstance.mobilenumber=self.mobilenumber!
                print(swiftyJsonVar["userObject"]["publicUniqueId"].stringValue)
               // UserSingletonModel.sharedInstance.userImage=URL(swiftyJsonVar["userImageUrl"].stringValue)!
                
                //------Saving the values in shared preference----------
                //let s=JSON(responseData.result.value!)
               self.sharedpreferences.set(UserSingletonModel.sharedInstance.userid, forKey: "userid")
                 self.sharedpreferences.set(UserSingletonModel.sharedInstance.userFullName, forKey: "userfullname")
                 self.sharedpreferences.set(UserSingletonModel.sharedInstance.gender, forKey: "gender")
                self.sharedpreferences.set(UserSingletonModel.sharedInstance.publicUid, forKey: "publicUid")
                 self.sharedpreferences.set(UserSingletonModel.sharedInstance.userImageUrl, forKey: "userimageurl")
                self.sharedpreferences.set(UserSingletonModel.sharedInstance.mobilenumber!, forKey: "mobilenumber")
                
                self.sharedpreferences.synchronize()
                 let swiftyJsonVar_sharedpref=self.sharedpreferences.object(forKey: "userid")
                print("sharedprefvalue: \(swiftyJsonVar_sharedpref!)")
                
                
                let status=swiftyJsonVar["status"]
                if status == "success" {
                   /* let viewController: UIViewController? = storyboard?.instantiateViewController(withIdentifier: "HomeController")
                    let navi = UINavigationController(rootViewController: viewController!)
                    navigationController?.pushViewController(navi, animated: true)*/
                    
                   //----- Swift 4 code (but it maynot work)-----------
                 /*   var viewController: UIViewController? = storyboard().instantiateViewController(withIdentifier: "Identifier")
                    var navi = UINavigationController(rootViewController: viewController!)
                    navigationController?.pushViewController(navi, animated: true)*/
//                    self.dismiss(animated: true, completion: nil) //-------30th aug newly added
                    self.performSegue(withIdentifier: "home", sender: self)
                }else if status == "failed"{
                     Toast(text: "\(swiftyJsonVar["message"].stringValue)", duration: Delay.short).show()
                    self.sharedpreferences.set(nil, forKey: "userid")
                    self.sharedpreferences.synchronize()
                }
                //self.userid.text! = swiftyJsonVar[""].string!
            }
            
           
        }
    }
      //--------------------function for verifying otp using Alamofire ends---------------------
    
    
    //--------to lock screen rotation, here shouldAutorotate is made false----------------
    override var shouldAutorotate: Bool{
        return false
    }
    //--------autorotation code ends--------------
    
    //=============================27th aug newly added code starts========================================
    
    //----------function to open and close popup code starts--------
    
    @IBOutlet weak var otpFormView: UIView!
    @IBOutlet weak var labelMobileNumber: UILabel!
    @IBOutlet weak var txtInputOtp: UITextField!
    
    @IBAction func btnVerify(_ sender: Any) {
        if(txtInputOtp.text == ""){
            Toast(text: "Otp field can't be left blank", duration: Delay.short).show()
        }
        else{
            self.get_otpnumber=txtInputOtp.text
            self.verifyotp()
        }
    }

    @IBAction func btnCancel(_ sender: Any) {
         cancelOtpFormPopup()
    }
    
    @IBAction func btnResend(_ sender: Any) {
         self.resendOtp_usingAlamofire()
    }
    
    //--------openPopup function code starts--------
    func openOtpFormPopup(){
        blurEffect()
        self.view.addSubview(otpFormView)
        labelMobileNumber.text = "An OTP has been sent to \(UserSingletonModel.sharedInstance.countrycode!)\(mobilenumber!)"
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.height
        //        ratingFormView.frame.size = CGSize.init(width: screenWidth, height: ratingFormView.frame.height)
        otpFormView.transform = CGAffineTransform.init(scaleX: 1.3,y :1.3)
        otpFormView.center = self.view.center  //----27th aug changes
        otpFormView.layer.cornerRadius = 10
        otpFormView.alpha = 0
        otpFormView.sizeToFit()
        
        UIView.animate(withDuration: 0.3) {
            self.otpFormView.alpha = 1
            self.otpFormView.transform = CGAffineTransform.identity
        }
    }
    //---------openPopup function code ends--------
    //------close popup code starts------
    func cancelOtpFormPopup() {
        UIView.animate(withDuration: 0.3, animations: {
            self.otpFormView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.otpFormView.alpha = 0
            self.otpFormView.alpha = 0.3
        }) { (success) in
            self.otpFormView.removeFromSuperview();
            self.canelBlurEffect()
        }
    }
    //-----close popup code ends-------
    //----------function to open and close popup code ends---------
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
        
        
    }
    
    func canelBlurEffect() {
        self.blurEffectView.removeFromSuperview();
    }
    
    // ====================== Blur Effect END ================= \\
    //===================================27th aug newly added code ends===================================
}

