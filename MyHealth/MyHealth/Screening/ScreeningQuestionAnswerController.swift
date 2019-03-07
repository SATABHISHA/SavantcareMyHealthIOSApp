//
//  ScreeningQuestionAnswerController.swift
//  MyHealth
//
//  Created by Satabhisha on 23/02/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import  QuartzCore
import Toaster

class ScreeningQuestionAnswerController: UIViewController {

    
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var arrRes = [[String:AnyObject]]()
    var questionID:String?
    var activeScreenData:String?
    var activeScreenData1:String?
    var screenReportId:Int?
    var idOfScreen:Int?
    var tableName:String?
    var screenName:String?
    var currentQuestionNumber:String?
    @IBOutlet weak var screening_title: UILabel!
    var timer = Timer()
    
    //---Declaring shared preferences----
    let sharedpreferences=UserDefaults.standard
    
    @IBOutlet weak var btn_Submit: UIButton!
    @IBOutlet weak var btn_Next: UIButton!
    @IBOutlet weak var btn_Prev: UIButton!
    
    
    @IBAction func btn_Next(_ sender: Any) {
         getQuestion(questionType: "next")
    }
    
    @IBAction func btn_Prev(_ sender: Any) {
         getQuestion(questionType: "prev")
    }
    
    
    @IBAction func btn_Submit(_ sender: Any) {
        print("submit is working")
        self.submitScreen()
    }
    
    
    @IBOutlet weak var tv_totalQuestionAnswered_and_totalQuestion: UILabel!
   // @IBOutlet weak var tv_question_number: UILabel!
    @IBOutlet weak var tv_option1: UILabel!
    @IBOutlet weak var tv_option2: UILabel!
    @IBOutlet weak var tv_option3: UILabel!
    @IBOutlet weak var tv_option4: UILabel!
    @IBOutlet weak var tv_option5: UILabel!
    
    
    
    //----------these are the functions which would work on tapping the options------------------
    @objc func tapFunction(sender:UITapGestureRecognizer){
        print("tap is working")
        //let swiftyJsonvar=UserModel.sharedInstance.question_selectedquestion_response!
        let swiftyJsonvar=JSON(UserSingletonModel.sharedInstance.question_selectedquestion_response!)
        tv_option1.backgroundColor=UIColor.green
        tv_option1.textColor=UIColor.white
        
        //---------24th aug changes starts--------
        var qstn_check_next:String!
        qstn_check_next = UserSingletonModel.sharedInstance.question_check_next as! String
        if qstn_check_next! == "1" {
            self.btn_Next.isHidden=false   //-----24th aug changes
        }else{
            self.btn_Next.isHidden = true
        }
        //---------24th aug changes ends--------
        if swiftyJsonvar["data"]["option2"].stringValue != "" {
            tv_option2.backgroundColor=UIColor.cyan
            tv_option2.textColor=UIColor.gray
        }
        if swiftyJsonvar["data"]["option3"].stringValue != "" {
            tv_option3.backgroundColor=UIColor.cyan
            tv_option3.textColor=UIColor.gray
        }
        if swiftyJsonvar["data"]["option4"].stringValue != "" {
            tv_option4.backgroundColor=UIColor.cyan
            tv_option4.textColor=UIColor.gray
        }
        if swiftyJsonvar["data"]["option5"].stringValue != "" {
            tv_option5.backgroundColor=UIColor.cyan
            tv_option5.textColor=UIColor.gray
        }
        submitAnswer(answerId: "1")
    }
    @objc func tapFunctionOption2(sender:UITapGestureRecognizer){
        print("tap is working")
        let swiftyJsonvar=JSON(UserSingletonModel.sharedInstance.question_selectedquestion_response!)
        tv_option2.backgroundColor=UIColor.green
        tv_option2.textColor=UIColor.white
        
        //---------24th aug changes starts--------
        var qstn_check_next:String!
        qstn_check_next = UserSingletonModel.sharedInstance.question_check_next as! String
        if qstn_check_next! == "1" {
            self.btn_Next.isHidden=false   //-----24th aug changes
        }else{
            self.btn_Next.isHidden = true
        }
        //---------24th aug changes ends--------
        if swiftyJsonvar["data"]["option1"].stringValue != "" {
            tv_option1.backgroundColor=UIColor.cyan
            tv_option1.textColor=UIColor.gray
        }
        if swiftyJsonvar["data"]["option3"].stringValue != "" {
            tv_option3.backgroundColor=UIColor.cyan
            tv_option3.textColor=UIColor.gray
        }
        if swiftyJsonvar["data"]["option4"].stringValue != "" {
            tv_option4.backgroundColor=UIColor.cyan
            tv_option4.textColor=UIColor.gray
        }
        if swiftyJsonvar["data"]["option5"].stringValue != "" {
            tv_option5.backgroundColor=UIColor.cyan
            tv_option5.textColor=UIColor.gray
        }
        
        submitAnswer(answerId: "2")
    }
    @objc func tapFunctionOption3(sender:UITapGestureRecognizer){
        print("tap is working")
        let swiftyJsonvar=JSON(UserSingletonModel.sharedInstance.question_selectedquestion_response!)
        tv_option3.backgroundColor=UIColor.green
        tv_option3.textColor=UIColor.white
        
        //---------24th aug changes starts--------
        var qstn_check_next:String!
        qstn_check_next = UserSingletonModel.sharedInstance.question_check_next as! String
        if qstn_check_next! == "1" {
            self.btn_Next.isHidden=false   //-----24th aug changes
        }else{
            self.btn_Next.isHidden = true
        }
        //---------24th aug changes ends--------
        if swiftyJsonvar["data"]["option2"].stringValue != "" {
            tv_option2.backgroundColor=UIColor.cyan
            tv_option2.textColor=UIColor.gray
        }
        if swiftyJsonvar["data"]["option1"].stringValue != "" {
            tv_option1.backgroundColor=UIColor.cyan
            tv_option1.textColor=UIColor.gray
        }
        if swiftyJsonvar["data"]["option4"].stringValue != "" {
            tv_option4.backgroundColor=UIColor.cyan
            tv_option4.textColor=UIColor.gray
        }
        if swiftyJsonvar["data"]["option5"].stringValue != "" {
            tv_option5.backgroundColor=UIColor.cyan
            tv_option5.textColor=UIColor.gray
        }
        submitAnswer(answerId: "3")
    }
    @objc func tapFunctionOption4(sender:UITapGestureRecognizer){
        print("tap is working")
        let swiftyJsonvar=JSON(UserSingletonModel.sharedInstance.question_selectedquestion_response!)
        tv_option4.backgroundColor=UIColor.green
        tv_option4.textColor=UIColor.white
        
        //---------24th aug changes starts--------
        var qstn_check_next:String!
        qstn_check_next = UserSingletonModel.sharedInstance.question_check_next as! String
        if qstn_check_next! == "1" {
            self.btn_Next.isHidden=false   //-----24th aug changes
        }else{
            self.btn_Next.isHidden = true
        }
        //---------24th aug changes ends--------
        if swiftyJsonvar["data"]["option2"].stringValue != "" {
            tv_option2.backgroundColor=UIColor.cyan
            tv_option2.textColor=UIColor.gray
        }
        if swiftyJsonvar["data"]["option3"].stringValue != "" {
            tv_option3.backgroundColor=UIColor.cyan
            tv_option3.textColor=UIColor.gray
        }
        if swiftyJsonvar["data"]["option1"].stringValue != "" {
            tv_option1.backgroundColor=UIColor.cyan
            tv_option1.textColor=UIColor.gray
        }
        if swiftyJsonvar["data"]["option5"].stringValue != "" {
            tv_option5.backgroundColor=UIColor.cyan
            tv_option5.textColor=UIColor.gray
        }
        submitAnswer(answerId: "4")
    }
    @objc func tapFunctionOption5(sender:UITapGestureRecognizer){
        print("tap is working")
        let swiftyJsonvar=JSON(UserSingletonModel.sharedInstance.question_selectedquestion_response!)
        tv_option5.backgroundColor=UIColor.green
        tv_option5.textColor=UIColor.white
        
        //---------24th aug changes starts--------
        var qstn_check_next:String!
        qstn_check_next = UserSingletonModel.sharedInstance.question_check_next as! String
        if qstn_check_next! == "1" {
            self.btn_Next.isHidden=false   //-----24th aug changes
        }else{
            self.btn_Next.isHidden = true
        }
        //---------24th aug changes ends--------
        if swiftyJsonvar["data"]["option2"].stringValue != "" {
            tv_option2.backgroundColor=UIColor.cyan
            tv_option2.textColor=UIColor.gray
        }
        if swiftyJsonvar["data"]["option3"].stringValue != "" {
            tv_option3.backgroundColor=UIColor.cyan
            tv_option3.textColor=UIColor.gray
        }
        if swiftyJsonvar["data"]["option4"].stringValue != "" {
            tv_option4.backgroundColor=UIColor.cyan
            tv_option4.textColor=UIColor.gray
        }
        if swiftyJsonvar["data"]["option1"].stringValue != "" {
            tv_option1.backgroundColor=UIColor.cyan
            tv_option1.textColor=UIColor.gray
        }
        submitAnswer(answerId: "5")
    }
    
    //------------functions for tapping thew options code ends-----------------
    
    
    
    
    
    
    
    
    @IBOutlet weak var menu_btn: UIBarButtonItem!
    @IBOutlet weak var tv_question: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        get_Screening_title() //---Calling get_Screening_title() to get the title of screening and this has been fetched from api
        // Do any additional setup after loading the view.
        
        //------making all buttons and loader default invisible--------
        btn_Submit.isHidden=true
        btn_Prev.isHidden=true
        btn_Next.isHidden=true
        tv_option1.isHidden=true
        tv_option2.isHidden=true
        tv_option3.isHidden=true
        tv_option4.isHidden=true
        tv_option5.isHidden=true
        loader.isHidden=true
        
        //-------making rounded endges of labels/options-----------
        tv_option1.layer.cornerRadius = 5.0
        //----------sharedpreference variable declarations------------
        // sharedpreferences.set(0, forKey: "preferences_screenReportId")
      //  sharedpreferences.set("0", forKey: "preferences_questionId")
      //  sharedpreferences.synchronize()
        
        //------calling sideMenus() function on page load--------
        sideMenus()
        
     //   Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(getQuestion(questionType: "first")), userInfo: nil, repeats: true)
       

        //------Calling function to get question------------
        getQuestion(questionType: "first")
        
       //  Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: Selector(("getQuestion")), userInfo: nil, repeats: true)
     
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
    //----------function for navigation drawer/side menu-----------------
    func sideMenus() {
        if revealViewController() != nil {
            menu_btn.target = revealViewController()
            menu_btn.action=#selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth=275
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            //revealViewController().rightViewRevealWidth=160
            
        }
    }
    //----------function for navigation drawer/side menu code ends-----------------
    
    
    //----------function to get screening title from api using Alamofire and Jsonswifty-------
    func get_Screening_title(){
        Alamofire.request("https://www.savantcare.com/v2/screening/api/public/index.php/api/getScreeningtitle").responseJSON{ (responseData) -> Void in
            if((responseData.result.value) != nil){
                let swiftyJsonVar=JSON(responseData.result.value!)
                print(swiftyJsonVar)
                self.screening_title.text=swiftyJsonVar["data"]["titledescription"].stringValue
            }
        }
    }
    //----------function to get screening title from api using Alamofire and Jsonswifty code ends-------
    
    
    
    //-------viewWillLayoutSubviews() will make the label text align top left------------------
    override func viewWillLayoutSubviews() {
     tv_question.sizeToFit()
    }
      //-------viewWillLayoutSubviews() code ends--------------
    
   //-------refresh handler code starts-------
    
   //-------refresh handler code ends-------
    
    
    //------------function to get questions and answers--------------------
   func getQuestion(questionType:String){
        //-----creating loader till the data loads---------
       /* let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)*/
        loader.isHidden=false
        loader.activityIndicatorViewStyle=UIActivityIndicatorViewStyle.gray
        loader.startAnimating()
        btn_Next.isHidden=true
        btn_Prev.isHidden=true
        //-------loader code ends-------------
        //--------Creating loader----------
       /* let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)*/
        //--------loader code ends-----------
        
        
       // let apiUrl="https://www.savantcare.com/v1/screening/api/public/index.php/api/getQNAForActiveScreen/5842"
        let apiUrl="https://www.savantcare.com/v2/screening/api/public/index.php/api/getQNAForActiveScreen/\(UserSingletonModel.sharedInstance.publicUid!)"
        // let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        
        // questionID=UserModel.sharedInstance.question_questionid!
        activeScreenData=UserSingletonModel.sharedInstance.screening_screen_data!
        print("activescreen data5421 \(UserSingletonModel.sharedInstance.screening_screen_data!)")
        activeScreenData1=sharedpreferences.object(forKey: "activescreendata") as? String
    
        
        screenReportId=UserSingletonModel.sharedInstance.question_reportid!
        idOfScreen=UserSingletonModel.sharedInstance.screening_id!          //------Previously it was screening_screenId and it was giving a bug
        tableName=UserSingletonModel.sharedInstance.screening_tblName!
        screenName=UserSingletonModel.sharedInstance.screening_name!
        
        //--writting data on sharedpreferences----
        /* sharedpreferences.set("1", forKey: "preferences_questionId")
         sharedpreferences.set("0", forKey: "preferences_screenReportId")
         sharedpreferences.synchronize() */
        
        if sharedpreferences.object(forKey: "preferences_questionId") != nil{
        questionID=sharedpreferences.object(forKey: "preferences_questionId") as? String
        }else if sharedpreferences.object(forKey: "preferences_questionId") == nil{
            sharedpreferences.set("0", forKey: "preferences_questionId")
            sharedpreferences.synchronize()
            questionID=sharedpreferences.object(forKey: "preferences_questionId") as? String
        }
        print(questionID)
        // screenReportId=sharedpreferences.object(forKey: "preferences_screenReportId") as? Int
        Alamofire.request(apiUrl, method: .post, parameters: ["activeScreenData":UserSingletonModel.sharedInstance.screening_screen_data!,"questionType":questionType,"questionID":questionID!,"idOfScreen":idOfScreen!,"screenReportID":screenReportId!,"tableName":tableName!],encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success:
               // self.dismiss(animated: true, completion: nil)
               // alert.dismiss(animated: true)
                
               
                self.loader.stopAnimating() //dismissing loader
                self.loader.isHidden=true   //dismissing loader
//                self.btn_Next.isHidden=false  //----24th Aug
                self.btn_Prev.isHidden=false
                
                
                let swiftyJsonVar=JSON(response.result.value!)
                UserSingletonModel.sharedInstance.question_selectedquestion_response=JSON(response.result.value!)
                /*self.sharedpreferences.set(UserSingletonModel.sharedInstance.question_selectedquestion_response!, forKey: "selectedquestion")
                self.sharedpreferences.synchronize()*/
                print("selected question option is:\(UserSingletonModel.sharedInstance.question_selectedquestion_response!)")
               // print("selected question option is:\(self.sharedpreferences.object(forKey: "selectedquestion") as! String as Any)")
                // UserModel.sharedInstance.question_questionid=swiftyJsonVar["data"]["id"].stringValue
                UserSingletonModel.sharedInstance.question_reportid=swiftyJsonVar["screenReportId"].intValue
                self.sharedpreferences.set(swiftyJsonVar["data"]["id"].stringValue, forKey: "preferences_questionId")
                // self.sharedpreferences.set(swiftyJsonVar["data"]["screenReportId"].intValue, forKey: "preferences_screenReportId")
                self.sharedpreferences.synchronize()
                print("sharedpref questionid: \(String(describing: self.sharedpreferences.object(forKey: "preferences_questionId") as? String))")
                //print(swiftyJsonVar)
                //print(swiftyJsonVar["data"]["id"])
                /*  if let resData = swiftyJsonVar["data"].arrayObject{
                 self.arrRes = resData as! [[String:AnyObject]]
                 }*/
                
                //---------Calling updateController function------------
                self.updateController(questionType: "totalQuestion" + "totalQuestionAnswered")
               // self.tv_question_number.text="Q"+swiftyJsonVar["questionNumber"].stringValue+"."
                self.tv_question.contentMode = .scaleToFill
                self.tv_question.numberOfLines = 3
                self.currentQuestionNumber = swiftyJsonVar["questionNumber"].stringValue  //-------newly added
               self.tv_question.text="Q"+swiftyJsonVar["questionNumber"].stringValue+".  "+swiftyJsonVar["data"]["question"].stringValue
                
                // var next=swiftyJsonVar["next"].stringValue
                // print("next value \(next)")
                //---------24th aug chages start---------------------------------
                /*   if swiftyJsonVar["next"].stringValue == "1"{
                 self.btn_Next.isHidden=false
                 }else{
                 self.btn_Next.isHidden=true
                 } */
                if swiftyJsonVar["next"].stringValue == "0"{
                    self.btn_Next.isHidden=true
                }
                UserSingletonModel.sharedInstance.question_check_next=swiftyJsonVar["next"].stringValue
                //---------24th aug changes end---------------------------
                //---------24th aug chages start---------------------------------
               /* if swiftyJsonVar["next"].stringValue == "1"{
                    self.btn_Next.isHidden=false
                }else{
                    self.btn_Next.isHidden=true
                }*/
                //---------24th aug changes end---------------------------
                //var prev=swiftyJsonVar["prev"].stringValue
                if swiftyJsonVar["prev"].stringValue == "1"{
                    self.btn_Prev.isHidden=false
                }else{
                    self.btn_Prev.isHidden=true
                }
                if swiftyJsonVar["data"]["option1"].stringValue != ""{
                    self.tv_option1.isHidden=false
                    self.tv_option1.text=swiftyJsonVar["data"]["option1"].stringValue
                    if swiftyJsonVar["answerId"].stringValue == "1" {
                        self.tv_option1.backgroundColor=UIColor.green
                        self.tv_option1.textColor=UIColor.white
                        self.tv_option1.layer.masksToBounds=true
                        self.tv_option1.layer.cornerRadius = 15
                    }else{
                        self.tv_option1.backgroundColor=UIColor.cyan
                        self.tv_option1.textColor=UIColor.gray
                        self.tv_option1.layer.masksToBounds=true
                        self.tv_option1.layer.cornerRadius = 15
                    }
                    let tap = UITapGestureRecognizer(target: self, action: #selector(ScreeningQuestionAnswerController.tapFunction))
                    self.tv_option1.isUserInteractionEnabled = true
                    self.tv_option1.addGestureRecognizer(tap)
                    
                }else{
                    self.tv_option1.isHidden=true
                }
                if swiftyJsonVar["data"]["option2"].stringValue != ""{
                    self.tv_option2.isHidden=false
                    self.tv_option2.text=swiftyJsonVar["data"]["option2"].stringValue
                    if swiftyJsonVar["answerId"].stringValue == "2"{
                        self.tv_option2.backgroundColor=UIColor.green
                        self.tv_option2.textColor=UIColor.white
                        self.tv_option2.layer.masksToBounds=true
                        self.tv_option2.layer.cornerRadius = 15
                    }else{
                        self.tv_option2.backgroundColor=UIColor.cyan
                        self.tv_option2.textColor=UIColor.gray
                        self.tv_option2.layer.masksToBounds=true
                        self.tv_option2.layer.cornerRadius = 15
                    }
                    let tap = UITapGestureRecognizer(target: self, action: #selector(ScreeningQuestionAnswerController.tapFunctionOption2))
                    self.tv_option2.isUserInteractionEnabled = true
                    self.tv_option2.addGestureRecognizer(tap)
                }else{
                    self.tv_option2.isHidden=true
                }
                if swiftyJsonVar["data"]["option3"].stringValue != ""{
                    self.tv_option3.isHidden=false
                    self.tv_option3.text=swiftyJsonVar["data"]["option3"].stringValue
                    if swiftyJsonVar["answerId"].stringValue == "3" {
                        self.tv_option3.backgroundColor=UIColor.green
                        self.tv_option3.textColor=UIColor.white
                        self.tv_option3.layer.masksToBounds=true
                        self.tv_option3.layer.cornerRadius = 15
                    }else{
                        self.tv_option3.backgroundColor=UIColor.cyan
                        self.tv_option3.textColor=UIColor.gray
                        self.tv_option3.layer.masksToBounds=true
                        self.tv_option3.layer.cornerRadius = 15
                    }
                    let tap = UITapGestureRecognizer(target: self, action: #selector(ScreeningQuestionAnswerController.tapFunctionOption3))
                    self.tv_option3.isUserInteractionEnabled = true
                    self.tv_option3.addGestureRecognizer(tap)
                }else{
                    self.tv_option3.isHidden=true
                }
                if swiftyJsonVar["data"]["option4"].stringValue != ""{
                    self.tv_option4.isHidden=false
                    self.tv_option4.text=swiftyJsonVar["data"]["option4"].stringValue
                    if swiftyJsonVar["answerId"].stringValue == "4"{
                        self.tv_option4.backgroundColor=UIColor.green
                        self.tv_option4.textColor=UIColor.white
                        self.tv_option4.layer.masksToBounds=true
                        self.tv_option4.layer.cornerRadius = 15
                    }else{
                        self.tv_option4.backgroundColor=UIColor.cyan
                        self.tv_option4.textColor=UIColor.gray
                        self.tv_option4.layer.masksToBounds=true
                        self.tv_option4.layer.cornerRadius = 15
                    }
                    let tap = UITapGestureRecognizer(target: self, action: #selector(ScreeningQuestionAnswerController.tapFunctionOption4))
                    self.tv_option4.isUserInteractionEnabled = true
                    self.tv_option4.addGestureRecognizer(tap)
                }else{
                    self.tv_option4.isHidden=true
                }
                //var option5=swiftyJsonVar["data"]["option5"].stringValue
                if swiftyJsonVar["data"]["option5"].stringValue != ""{
                    self.tv_option5.isHidden=false
                    self.tv_option5.text=swiftyJsonVar["data"]["option5"].stringValue
                    if swiftyJsonVar["answerId"].stringValue == "5"{
                        self.tv_option5.backgroundColor=UIColor.green
                        self.tv_option5.textColor=UIColor.white
                        self.tv_option5.layer.masksToBounds=true
                        self.tv_option5.layer.cornerRadius = 15
                    }else{
                        self.tv_option1.backgroundColor=UIColor.cyan
                        self.tv_option1.textColor=UIColor.gray
                        self.tv_option5.layer.masksToBounds=true
                        self.tv_option5.layer.cornerRadius = 15
                    }
                    let tap = UITapGestureRecognizer(target: self, action: #selector(ScreeningQuestionAnswerController.tapFunctionOption5))
                    self.tv_option5.isUserInteractionEnabled = true
                    self.tv_option5.addGestureRecognizer(tap)
                }
                else{
                    self.tv_option5.isHidden=true
                }
                break
                
            case .failure(let error):
              //  self.dismiss(animated: true, completion: nil)
                self.loader.stopAnimating() //dismissing loader
                self.loader.isHidden=true   //dismissing loader

                print(error)
            }
        }
        
    }
    //------------function to get questions and answers ends--------------------
    
    //-----------function for update questions which will be called inside getQuestion()-----------------
    func updateController(questionType:String){
        self.loader.isHidden=false
        self.loader.startAnimating()
        //let apiUrl="https://www.savantcare.com/v1/screening/api/public/index.php/api/getQNAForActiveScreen/5842"
        let apiUrl="https://www.savantcare.com/v2/screening/api/public/index.php/api/getQNAForActiveScreen/\(UserSingletonModel.sharedInstance.publicUid!)"
        // let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        // questionID=UserModel.sharedInstance.question_questionid!
        activeScreenData=UserSingletonModel.sharedInstance.screening_screen_data!
        activeScreenData1=sharedpreferences.object(forKey: "activescreendata") as? String
        
        idOfScreen=UserSingletonModel.sharedInstance.screening_id!    //--------Previously it was "screening_screenId" and it was giving a bug
        tableName=UserSingletonModel.sharedInstance.screening_tblName!
        screenName=UserSingletonModel.sharedInstance.screening_name!
        screenReportId=UserSingletonModel.sharedInstance.question_reportid!
        questionID=sharedpreferences.object(forKey: "preferences_questionId") as? String
     //   print(questionID)
        //screenReportId=sharedpreferences.object(forKey: "preferences_screenReportId") as? Int
        
        Alamofire.request(apiUrl, method: .post, parameters: ["activeScreenData":UserSingletonModel.sharedInstance.screening_screen_data!,"questionType":questionType,"questionID":questionID!,"idOfScreen":idOfScreen!,"screenReportID":screenReportId!,"tableName":tableName!],encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success:
                let swiftyJsonVar=JSON(response.result.value!)
                
                print(swiftyJsonVar)
                self.loader.stopAnimating()
                self.loader.isHidden=true
//                self.tv_totalQuestionAnswered_and_totalQuestion.text=swiftyJsonVar["totalQuestionAnswered"].stringValue+"/"+swiftyJsonVar["totalQuestion"].stringValue
                self.tv_totalQuestionAnswered_and_totalQuestion.text=self.currentQuestionNumber!+"/"+swiftyJsonVar["totalQuestion"].stringValue
                print("toal ques answered: \(swiftyJsonVar["totalQuestionAnswered"])")
                if swiftyJsonVar["totalQuestionAnswered"].stringValue == swiftyJsonVar["totalQuestion"].stringValue{
                    self.btn_Submit.isHidden=false
                }
                print(response)
                break
                
            case .failure(let error):
                print(error)
            }
        }
    }
    //-----------function for update questions which will be called inside getQuestion() ends-----------------
    
    //-------------function for submit screen--------------
    func submitScreen(){
        //let apiurl="https://www.savantcare.com/v1/screening/api/public/index.php/api/getQNAForActiveScreen/\(screenReportId!)"
        //  let apiurl="https://www.savantcare.com/v1/screening/api/public/index.php/api/submitScreen/\(screenReportId!)"
        //screenReportId=sharedpreferences.object(forKey: "preferences_screenReportId") as? Int
        screenReportId=UserSingletonModel.sharedInstance.question_reportid!
        let api="https://www.savantcare.com/v2/screening/api/public/index.php/api/submitScreen/\(UserSingletonModel.sharedInstance.question_reportid!)"
        print(api)
        /* Alamofire.request("https://www.savantcare.com/v1/screening/api/public/index.php/api/submitScreen/\(UserModel.sharedInstance.question_reportid!)").responseJSON{ (responseData) -> Void in
         if((responseData.result.value) != nil){
         let swiftyJsonVar=JSON(responseData.result.value!)
         print(swiftyJsonVar)
         /*  if swiftyJsonVar["status"].stringValue == "success" {
         //self.sharedpreferences.set(0, forKey: "preferences_screenReportId")
         UserModel.sharedInstance.question_reportid=0
         /* UserModel.sharedInstance.question_questionid="0"*/
         self.sharedpreferences.set("0", forKey: "preferences_questionId")
         self.sharedpreferences.synchronize()
         print("Submitted")
         }else{
         print("Not Submitted")
         }*/
         /* if let resData = swiftyJsonVar["patientAssignedScreens"].arrayObject{
         self.arrRes = resData as! [[String:AnyObject]]
         } */
         
         }*/
        Alamofire.request(api,method: .post).responseJSON{ response in
            switch response.result{
            case .success:
              //  print("Submitted")
                print("See the following output")
                print(response.result.value!)
                let swiftyJsonVar = JSON(response.result.value!)
                UserSingletonModel.sharedInstance.submit_screen_message=JSON(response.result.value!)
                if swiftyJsonVar["status"].stringValue == "success" {
                    //self.sharedpreferences.set(0, forKey: "preferences_screenReportId")
                    UserSingletonModel.sharedInstance.question_reportid=0
                    /* UserModel.sharedInstance.question_questionid="0"*/
                    self.sharedpreferences.set("0", forKey: "preferences_questionId")
                    self.sharedpreferences.synchronize()
                    self.btn_Submit.isHidden=true
                    self.dismiss(animated: true, completion: nil) //--------this would dismiss this controller
                    self.performSegue(withIdentifier: "home", sender: self)
                    Toast(text: "Submitted", duration: Delay.short).show()
                }
                print(response)
                
            case .failure(let error):
                print(error)
            }
            
            
        }
        
    }
    //-------------function for submit screen code ends--------------
    
    
    //-------------function for submitAnswer------------------
    func submitAnswer(answerId:String){
        let apiUrl="https://www.savantcare.com/v2/screening/api/public/index.php/api/questionAnswer";
        //questionID=UserModel.sharedInstance.question_questionid!
        activeScreenData=UserSingletonModel.sharedInstance.screening_screen_data!
        tableName=UserSingletonModel.sharedInstance.screening_tblName!
        idOfScreen=UserSingletonModel.sharedInstance.screening_id!   //------previously it was "screening_screenId" and it was giving a bug
        screenName=UserSingletonModel.sharedInstance.screening_name!
        //screenReportId=sharedpreferences.object(forKey: "preferences_screenReportId") as? Int
        screenReportId=UserSingletonModel.sharedInstance.question_reportid!
        var report_id_temp:Int?
        report_id_temp=0
        questionID=sharedpreferences.object(forKey: "preferences_questionId") as? String
        print("report id: \(screenReportId!)")
        /*print(tableName!)
         print(questionID!)
         print(answerId)*/
        print("id of screen: \(idOfScreen!)")
        print("id of screen: \(screenReportId!)")
        print("id of screen: \(tableName!)")
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-HTTP-Method-Override": "PATCH"
        ]
        Alamofire.request("https://www.savantcare.com/v2/screening/api/public/index.php/api/questionAnswer", method: .post, parameters: ["screenReportID":screenReportId!,"tableName":tableName!,"questionId":questionID!,"answerId":answerId,"userId":UserSingletonModel.sharedInstance.userid!,"idOfScreen":idOfScreen!],encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success:
                let swiftyJsonVar=JSON(response.result.value!)
                
                print(swiftyJsonVar)
                
                //----Displaying toast----
             /*   let toast=Toast(text: "Saved")
                toast.show()
                toast.cancel()*/
                 Toast(text: "\(swiftyJsonVar["message"].stringValue)", duration: Delay.short).show()
                 //----Displaying toast code ends----
                
                
                /*  self.sharedpreferences.set(swiftyJsonVar["screenReportId"].intValue, forKey: "preferences_screenReportId")
                 self.sharedpreferences.synchronize()*/
                
                /*if UserModel.sharedInstance.question_reportid! == 0 {
                 UserModel.sharedInstance.question_reportid=swiftyJsonVar["screenReportId"].intValue
                 print("ReportId: \(UserModel.sharedInstance.question_reportid!)")
                 }else {
                 UserModel.sharedInstance.question_reportid=self.screenReportId
                 print("ReportId: \(UserModel.sharedInstance.question_reportid!)")
                 } */
                UserSingletonModel.sharedInstance.question_reportid=swiftyJsonVar["screenReportId"].intValue
                self.updateController(questionType: "totalQuestion" + "totalQuestionAnswered")
                //print("submit answer message:\(swiftyJsonVar["message"].stringValue)")
               
                break
                
            case .failure(let error):
                print(error)
            }
        }
        /*   Alamofire.request("https://www.savantcare.com/v2/screening/api/public/index.php/api/questionAnswer", method: .post, parameters: ["screenReportID":screenReportId!,"tableName":tableName!,"questionID":questionID!,"answerId":answerId,"userId":"5842","idOfScreen":idOfScreen!],encoding: JSONEncoding.default, headers: nil).responseString(completionHandler: <#T##(DataResponse<String>) -> Void#>)*/
        
    }
    //-------------function for submitAnswer ends------------------
    
    //--------to lock screen rotation, here shouldAutorotate is made false----------------
    override var shouldAutorotate: Bool{
        return false
    }
    //--------autorotation code ends--------------
    
}
