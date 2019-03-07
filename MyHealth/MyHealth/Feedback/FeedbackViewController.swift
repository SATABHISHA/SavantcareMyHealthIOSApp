//
//  FeedbackViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 16/07/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit
import Toaster
import Alamofire
import SwiftyJSON

class FeedbackViewController: BaseViewController, UITextViewDelegate {
    
    @IBOutlet weak var btn_menu: UIBarButtonItem!
    @IBOutlet weak var btnDelightful: KGRadioButton!
    @IBOutlet weak var btnOk: KGRadioButton!
    @IBOutlet weak var btnNeedImprovement: KGRadioButton!
    @IBOutlet weak var tvComments: UITextView!
    var refresher: UIRefreshControl!
    
    
    @IBAction func btnSave(_ sender: Any) {
         if(btnOk.isSelected == false && btnDelightful.isSelected == false && btnNeedImprovement.isSelected == false && tvComments.text == "Comments..."){
            Toast(text: "Field can't be empty", duration: Delay.short).show()
        }
        else{
            save_feedback_data()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        Toast(text: "Please enter OTP", duration: Delay.short).show()
//        sideMenus()  //------calling function for navigation
          addSlideMenuButton() //---30th aug
        // Do any additional setup after loading the view.
        //--------- code to make the text with rounded edges code starts -------------
        tvComments.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        tvComments.layer.borderWidth = 1.0
        tvComments.layer.cornerRadius = 10
        //--------- code to make the text with rounded edges code ends -------------
        
        //=========code for placeholder inside viewDidLoad() starts==========
        tvComments.text = "Comments..."
        tvComments.textColor = UIColor.lightGray
        tvComments.font = UIFont(name: "verdana", size: 13.0)
        tvComments.returnKeyType = .done
        tvComments.delegate = self
        //=========code for placeholder inside viewDidLoad() ends===========
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //=============code for placeholder code starts========
    func textViewDidBeginEditing(_ textView: UITextView) {
        if tvComments.text == "Comments..."{
            tvComments.text = ""
            tvComments.textColor = UIColor.black
            tvComments.font = UIFont(name: "verdana", size: 18.0)
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            tvComments.resignFirstResponder()
        }
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Comments..."
            textView.textColor = UIColor.lightGray
            textView.font = UIFont(name: "verdana", size: 13.0)
        }
    }
    //============code for placeholder code ends===========
    
    //----------function for navigation drawer/side menu-----------------
    func sideMenus() {
        if revealViewController() != nil {
            btn_menu.target = revealViewController()
            btn_menu.action=#selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth=220
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            //revealViewController().rightViewRevealWidth=160
            
        }
    }
    //----------function for navigation drawer/side menu code ends-----------------
    
    var feedback: String! = ""
    //==============code for radiobutton code starts===============
    @IBAction func didPressButtonDelightFul(_ sender: KGRadioButton) {
        sender.isSelected = !sender.isSelected
        btnOk.isSelected = false
        btnNeedImprovement.isSelected = false
        if sender.isSelected {
            feedback = "1"
        } else{
            feedback = ""
        }
    }
    @IBAction func didPressButtonOk(_ sender: KGRadioButton) {
        sender.isSelected = !sender.isSelected
        btnDelightful.isSelected = false
        btnNeedImprovement.isSelected = false
        if sender.isSelected {
            feedback = "2"
        } else{
            feedback = ""
        }
    }
    @IBAction func didPressButtonNeedImprovement(_ sender: KGRadioButton) {
        sender.isSelected = !sender.isSelected
        btnDelightful.isSelected = false
        btnOk.isSelected = false
        if sender.isSelected {
            feedback = "3"
        } else{
            feedback = ""
        }
    }
    //================code for radiobutton code ends=============
    
    //---------function to get current date and time-------------
    var currentdate: String!
    func currentDate(){
        var todaysDate:Date = Date()
        var dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //var DateInFormat:String = dateFormatter.string(from: todaysDate)
        currentdate=dateFormatter.string(from: todaysDate)
        print(currentdate)
    }
    //---------function to get current date and time code ends-------------
    //================code to submit feedback data using Alamofire and JsonSwift starts=================
    public func save_feedback_data(){
        currentDate()
        //----------code to get timezone in IST/PDT/PST etc format starts------
        let zoneName = NSTimeZone.abbreviationDictionary
        // Iterate through the dictionary
        let currentAutoUpdateTZ = TimeZone.current.identifier
        var finalTimeZoneName:String!
        for (key,value) in zoneName {
            if(value == currentAutoUpdateTZ){
                finalTimeZoneName = key
            }
        }
        print("\(finalTimeZoneName!)")
        //-------code to get timezone in IST/PDT/PST etc format ends------
        let apiurl = "https://www.savantcare.com/v1/api/feedback/public/index.php/savePatientComment/"
        let data: [String: Any] = [
            "comment" : tvComments.text!,
            "feedback" : feedback!,
            "commentedByUid" : UserSingletonModel.sharedInstance.userid!,
            "createdAt" : currentdate,
            "createdAtTimeZone" : finalTimeZoneName
        ]
        Alamofire.request(apiurl, method: .post, parameters: data,encoding: JSONEncoding.default, headers: nil).responseString{
            response in
            switch response.result{
            case .success:
                let swiftyJsonVar=JSON(response.result.value!)
                print(swiftyJsonVar)
                Toast(text: "Submitted", duration: Delay.short).show()
                //=========Declaring comments section blank with placeholder and deselecting the custom radiobuttons after successful submission code starts=========
                self.tvComments.text = "Comments..."
                self.tvComments.textColor = UIColor.lightGray
                self.tvComments.font = UIFont(name: "verdana", size: 13.0)
                self.tvComments.returnKeyType = .done
                self.tvComments.delegate = self
                
                //-------------deselecting radio buttons code starts--------
                self.btnOk.isSelected = false
                self.btnNeedImprovement.isSelected = false
                self.btnDelightful.isSelected = false
                //-------------deselecting radio buttons code ends--------
                //=========Declaring comments section blank with placeholder deselecting the custom radiobuttons after successful submission code ends=========
                
                break
            case .failure(let error):
                Toast(text: "Internal Error", duration: Delay.short).show()
                print(error)
            }
        }
    }
    //================code to submit feedback data using Alamofire and JsonSwift ends=================
    
}
