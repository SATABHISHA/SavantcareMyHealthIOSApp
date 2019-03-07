//
//  GoalHomeModifiedViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 04/09/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toaster

class GoalHomeModifiedViewController: BaseViewController,UITableViewDataSource, UITableViewDelegate, GoalHomeModifiedTableViewCellDelegate, UITextViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    var arrRes = [[String:AnyObject]]()
     @IBOutlet weak var btn_add_goal: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate=self
        self.tableview.dataSource=self
        // Do any additional setup after loading the view.
        btn_add_goal.layer.cornerRadius = self.btn_add_goal.frame.height/2.0
        addSlideMenuButton()
        get_Goal_details()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //=============code for placeholder code starts========
    func textViewDidBeginEditing(_ textView: UITextView) {
        if input_text_area.text == "Description..."{
            input_text_area.text = ""
            input_text_area.textColor = UIColor.black
            input_text_area.font = UIFont(name: "verdana", size: 13.0)
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            input_text_area.resignFirstResponder()
        }
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if input_text_area.text == "" {
            input_text_area.text = "Description..."
            input_text_area.textColor = UIColor.lightGray
            input_text_area.font = UIFont(name: "verdana", size: 13.0)
        }
    }
    //============code for placeholder code ends===========
    
    //--------function to show goal details using Alamofire and Json Swifty------------
    func get_Goal_details(){
        loaderStart()
        Alamofire.request("https://www.savantcare.com/v2/screening/api/public/index.php/api/showAllGoals/\(UserSingletonModel.sharedInstance.publicUid!)").responseJSON{ (responseData) -> Void in
            self.loaderEnd()
            if((responseData.result.value) != nil){
                let swiftyJsonVar=JSON(responseData.result.value!)
                print("Goal description: \(swiftyJsonVar)")
                if let resData = swiftyJsonVar["data"].arrayObject{
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count>0 {
                    self.tableview.reloadData()
                }else{
                    self.tableview.reloadData()
                    //                    Toast(text: "No data", duration: Delay.short).show()
                    let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableview.bounds.size.width, height: self.tableview.bounds.size.height))
                    noDataLabel.text          = "No goal is available"
                    noDataLabel.textColor     = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.tableview.backgroundView  = noDataLabel
                    self.tableview.separatorStyle  = .none
                    
                }
            }
            
        }
    }
    //--------function to show goal details using Alamofire and Json Swifty code ends------------

    //===================tableview code starts=================
    func GoalHomeModifiedTableViewCellDidTapRateGoal(_ sender: GoalHomeModifiedTableViewCell) {
        guard let tappedIndexPath = tableview.indexPath(for: sender) else {return}
        let rowData = arrRes[tappedIndexPath.row]
        UserSingletonModel.sharedInstance.goalID=rowData["id"] as? Int
        UserSingletonModel.sharedInstance.goalPublicUid=rowData["goalPublicUid"] as? String
        UserSingletonModel.sharedInstance.goalValueOfTheRating=rowData["valueOfTheRating"] as? Int
        openGoalRatingFormPopup()
        
    }
    
    func GoalHomeModifiedTableViewCellDidTapSeeGraph(_ sender: GoalHomeModifiedTableViewCell) {
        openGraphFormPopup()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! GoalHomeModifiedTableViewCell
        cell.delegate = self
        
        var dict = arrRes[indexPath.row]
        cell.view_goal.layer.cornerRadius = 10.0
        cell.label_goal.text = dict["goal"] as? String
        cell.label_value_of_rating.text = "\(dict["valueOfTheRating"]!)"
        cell.label_date.text = "\(dict["created_at"]!)"
        return cell
    }
    //========================tableview code ends===================
   
    @IBAction func btn_add_goal(_ sender: Any) {
        openAddGoalFormPopup()
        
    }
    //=======================Goal Rating function to open, close, cancel and save popup code starts=================
    
    @IBOutlet weak var goalRatingFormView: UIView!
    @IBOutlet var goalRatingChildFormView: UIView!
    @IBOutlet weak var labelRateValue: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        var currentValue = Int(sender.value)
        UserSingletonModel.sharedInstance.goalrating = currentValue
        labelRateValue.text = "\(UserSingletonModel.sharedInstance.goalrating!)"
    }
    
    @IBAction func btn_save_rating(_ sender: Any) {
        save_rating()
    }
    
    @IBAction func btn_cancel_rating(_ sender: Any) {
        cancelGoalRatingFormPopup()
    }
    //===============GoalRating openPopup function code starts=============
    func openGoalRatingFormPopup(){
        blurEffect()
        self.view.addSubview(goalRatingFormView)
        slider.value = Float(UserSingletonModel.sharedInstance.goalValueOfTheRating!)
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.height
        goalRatingFormView.transform = CGAffineTransform.init(scaleX: 1.3,y :1.3)
        goalRatingFormView.center = self.view.center
        goalRatingChildFormView.layer.cornerRadius = 10.0
        goalRatingFormView.layer.cornerRadius = 10.0
        goalRatingFormView.alpha = 0
        goalRatingFormView.sizeToFit()
        
//        print("ratevalue",UserSingletonModel.sharedInstance.goalValueOfTheRating!)
        labelRateValue.text = "\(UserSingletonModel.sharedInstance.goalValueOfTheRating!)"
        
        UIView.animate(withDuration: 0.3){
            self.goalRatingFormView.alpha = 1
            self.goalRatingFormView.transform = CGAffineTransform.identity
        }
    }
    //===============GoalRating openPopup function code ends===============
    //------GoalRating close popup code starts------
    func cancelGoalRatingFormPopup() {
        UIView.animate(withDuration: 0.3, animations: {
            self.goalRatingFormView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.goalRatingFormView.alpha = 0
            self.blurEffectView.alpha = 0.3
        }) { (success) in
            self.goalRatingFormView.removeFromSuperview();
            self.canelBlurEffect()
        }
    }
    //-----GoalRating close popup code ends-------
    //=======================Goal Rating function to open, close, cancel and save popup code ends=================
    
    //=============================================================================================================================
    
    //======================Graphview coming soon open, close popup code starts=================
    
    @IBOutlet var graphFormView: UIView!
    @IBOutlet weak var graphChildFormView: UIView!
    
    @IBAction func closeGraphPopupBtn(_ sender: Any) {
        cancelGraphFormPopup()
    }
    func openGraphFormPopup(){
        blurEffect()
        self.view.addSubview(graphFormView)
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.height
        graphFormView.transform = CGAffineTransform.init(scaleX: 1.3,y: 1.3)
        graphFormView.center = self.view.center
        graphFormView.layer.cornerRadius = 10.0
        graphChildFormView.layer.cornerRadius = 10.0
        graphFormView.alpha = 0
        graphFormView.sizeToFit()
        UIView.animate(withDuration: 0.3){
            self.graphFormView.alpha = 1
            self.graphFormView.transform = CGAffineTransform.identity
        }
    }
    func cancelGraphFormPopup() {
        UIView.animate(withDuration: 0.3, animations: {
            self.graphFormView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.graphFormView.alpha = 0
            self.blurEffectView.alpha = 0.3
        }) { (success) in
            self.graphFormView.removeFromSuperview();
            self.canelBlurEffect()
        }
    }
    //======================Graphview coming soon open, close popup code ends=============
    
    //=======================AddGoal function to open, close, cancel and save save popup code starts=================
    
    @IBOutlet var addGoalFormView: UIView!
    @IBOutlet weak var addGoalChildFormView: UIView!
    @IBOutlet weak var input_text_area: UITextView!
    
    @IBAction func btn_save_form(_ sender: Any) {
        if input_text_area.text == "Description..."{
            Toast(text: "Field can't be empty", duration: Delay.short).show()
        }else if input_text_area.text == ""{
            Toast(text: "Field can't be empty", duration: Delay.short).show()
        }else{
            save_goal()
        }
    }
    
    @IBAction func btn_cancel_forn(_ sender: Any) {
        cancelAddGoalFormPopup()
    }
    //===============AddGoal openPopup function code starts=============
    func openAddGoalFormPopup(){
        blurEffect()
        self.view.addSubview(addGoalFormView)
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.height
        addGoalFormView.transform = CGAffineTransform.init(scaleX: 1.3,y :1.3)
        addGoalFormView.center = self.view.center
        addGoalFormView.layer.cornerRadius = 10.0
        addGoalChildFormView.layer.cornerRadius = 10.0
        addGoalFormView.alpha = 0
        addGoalFormView.sizeToFit()
        
        UIView.animate(withDuration: 0.3){
          self.addGoalFormView.alpha = 1
          self.addGoalFormView.transform = CGAffineTransform.identity
        }
        //--------- code to make the text with rounded edges code starts -------------
        input_text_area.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        input_text_area.layer.borderWidth = 1.0
        input_text_area.layer.cornerRadius = 10
        //--------- code to make the text with rounded edges code ends -------------
        
        //=========code for placeholder inside viewDidLoad() starts==========
        input_text_area.text = "Description..."
        input_text_area.textColor = UIColor.lightGray
        input_text_area.font = UIFont(name: "verdana", size: 13.0)
        input_text_area.returnKeyType = .done
        input_text_area.delegate = self
        //=========code for placeholder inside viewDidLoad() ends===========
       
    }
    //===============AddGoal openPopup function code ends===============
    //------AddGoal close popup code starts------
    func cancelAddGoalFormPopup() {
        UIView.animate(withDuration: 0.3, animations: {
            self.addGoalFormView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.addGoalFormView.alpha = 0
            self.blurEffectView.alpha = 0.3
        }) { (success) in
            self.addGoalFormView.removeFromSuperview();
            self.canelBlurEffect()
        }
    }
    //-----AddGoal close popup code ends-------
    //=======================function to open, close, cancel and save popup code ends======================
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
    
    //---------function to get current date and time-------------
    var currentdate:String!
    func currentDate(){
        var todaysDate:Date = Date()
        var dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //var DateInFormat:String = dateFormatter.string(from: todaysDate)
        currentdate=dateFormatter.string(from: todaysDate)
        print(currentdate)
    }
    //---------function to get current date and time code ends-------------
    
    
    //--------function to save goal text to the server using Alamofire and Jsonswifty---------
    public func save_goal(){
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
        
        let apiurl="https://www.savantcare.com/v2/screening/api/public/index.php/api/addGoal/\(UserSingletonModel.sharedInstance.publicUid!)"
        Alamofire.request(apiurl, method: .post, parameters: ["goal":input_text_area.text,"created_at":currentdate,"updated_at":currentdate,"createdTimeZone":finalTimeZoneName],encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success:
                let swiftyJsonVar=JSON(response.result.value!)
                Toast(text: "Goal Added Successfully!!", duration: Delay.short).show()
                self.cancelAddGoalFormPopup()
                self.get_Goal_details()
                print(swiftyJsonVar)
                
                break
                
            case .failure(let error):
                Toast(text: "Sorry, please try again!", duration: Delay.short).show()
                self.cancelAddGoalFormPopup()
                print(error)
            }
        }
    }
    
    
    //--------AddGoal function to save goal text to the server using Alamofire and Jsonswifty code ends---------
    
    //--------function to save rating---------
    public func save_rating(){
        currentDate()
        let apiurl="https://www.savantcare.com/v2/screening/api/public/index.php/api/addRating/\(UserSingletonModel.sharedInstance.goalPublicUid!)"
        Alamofire.request(apiurl, method: .post, parameters: ["valueOfTheRating":UserSingletonModel.sharedInstance.goalrating!,"dateOfRate":currentdate,"created_at":currentdate,"updated_at":currentdate],encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success:
                let swiftyJsonVar=JSON(response.result.value!)
                print(swiftyJsonVar)
                self.cancelGoalRatingFormPopup()
                self.get_Goal_details()
                break
                
            case .failure(let error):
                print(error)
            }
        }
    }
    //--------function to save rating code ends---------
}
