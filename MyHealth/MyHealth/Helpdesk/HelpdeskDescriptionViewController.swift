//
//  HelpdeskDescriptionViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 09/05/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toaster

class HelpdeskDescriptionViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {

    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_date: UILabel!
    @IBOutlet weak var txt_description: UITextView!
    @IBOutlet weak var label_comment_count: UILabel!
    
    @IBOutlet weak var label_viewcomments_new_line: UILabel!
    @IBOutlet weak var label_addcomments_new_line: UILabel!
    @IBOutlet weak var tableview: UITableView!
    var currentdate:String!
    var arrRes = [[String:AnyObject]]()
    
    @IBOutlet weak var navigationbar: UINavigationBar!
    
    @IBAction func btn_back(_ sender: Any) {
        self.performSegue(withIdentifier: "helpdeskhome", sender: self)
    }
    
    @IBAction func btn_view_comments(_ sender: Any) {
        tableview.isHidden=false
        get_Helpdesk_comments()
    }
    
    
    @IBAction func btn_add_comments(_ sender: Any) {
        
        //==============commented this on 20th sept=======
        //-----------custom popup code starts (this popup will open on clicking the add comments button)------------
     /*   let popOverVC = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "addcomment") as! HelpdeskAddCommentsPopupViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame=self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)*/
        //-----------custom popup code ends (this popup will open on clicking the add comments button)------------
        //==============commented this on 20th sept=======
        openAddGoalFormPopup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate=self
        self.tableview.dataSource=self
        tableview.isHidden=true
        
        
        
        //--------to make the label text rounded------
        label_comment_count.layer.backgroundColor  = UIColor.red.cgColor
        // label_comment_count.layer.masksToBounds=true
        label_comment_count.layer.cornerRadius = label_comment_count.frame.width/2
        //--------to make the label text rounded code ends------
        
        label_viewcomments_new_line.numberOfLines=0
        label_viewcomments_new_line.text="View \nComments"
        
        label_addcomments_new_line.numberOfLines=0
        label_addcomments_new_line.text="Add \nComments"
        
        txt_description.isEditable=false
        label_title.text=UserSingletonModel.sharedInstance.helpdesk_title?.removeHTMLTag()
        label_date.text=UserSingletonModel.sharedInstance.helpdesk_created_at
        label_date.text="\(UserSingletonModel.sharedInstance.helpdesk_created_at!)   Status: \(UserSingletonModel.sharedInstance.helpdesk_status!)"
        // Do any additional setup after loading the view.
       
        txt_description.text=UserSingletonModel.sharedInstance.helpdesk_description?.removeHTMLTag()
        
        print("publicuid: \(UserSingletonModel.sharedInstance.publicUid!) and helpdesk_uniqueid \(UserSingletonModel.sharedInstance.helpdesk_public_unique_id!)")
        
         get_Helpdesk_comments()
        get_Helpdesk_comment_count()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        get_Helpdesk_comments()
        get_Helpdesk_comment_count()
    }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //=============code for placeholder code starts 20th Sept========
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
    //============code for placeholder code ends 20th sept===========
    
    
    //----------function to show helpdesk details using Alamofire and JsonSwifty-------------
    func get_Helpdesk_comments(){
         print("Hello")
        Alamofire.request("https://www.savantcare.com/v2/screening/api/public/index.php/api/displayComment/\(UserSingletonModel.sharedInstance.publicUid!),\(UserSingletonModel.sharedInstance.helpdesk_public_unique_id!)").responseJSON{ (responseData) -> Void in
            if((responseData.result.value) != nil){
               
                let swiftyJsonVar=JSON(responseData.result.value!)
                print("Comment details: \(responseData.result.value!)")
               
                if let resData = swiftyJsonVar["data"].arrayObject{
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count>0 {
                    self.tableview.reloadData()
                }
            }
            
        }
    }
    
    //----------function to show helpdesk details using Alamofire and Jsonswifty code ends---------
    
    
    //----------function to show helpdesk comment count using Alamofire and JsonSwifty-------------
    
    func get_Helpdesk_comment_count(){
        Alamofire.request("https://www.savantcare.com/v2/screening/api/public/index.php/api/displayComment/\(UserSingletonModel.sharedInstance.publicUid!),\(UserSingletonModel.sharedInstance.helpdesk_public_unique_id!)").responseJSON{ (responseData) -> Void in
            if((responseData.result.value) != nil){
                
                let swiftyJsonVar=JSON(responseData.result.value!)
                print("Comment details: \(responseData.result.value!)")
                print("Comment count:\(swiftyJsonVar["count"].stringValue)")
               
//                self.label_comment_count.text="\(swiftyJsonVar["count"].stringValue)"
                UserSingletonModel.sharedInstance.helpdesk_comment_count = swiftyJsonVar["count"].stringValue
                self.label_comment_count.text=UserSingletonModel.sharedInstance.helpdesk_comment_count
            /*    let str=swiftyJsonVar["count"].stringValue
                self.label_comment_count.text=str*/
                
            }
            
        }
        
    }
    
    
    //----------function to show helpdesk comment count using Alamofire and Jsonswifty code ends---------
    
    
    //---------tableview code starts here---------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HelpdeskViewCommentsTableViewCell
        cell.view_comments.layer.cornerRadius=10.0
        var dict = arrRes[indexPath.row]
        let str=dict["comment"] as? String
        cell.label_comments.text=str?.removeHTMLTag()
        cell.label_date.text=dict["created_at"] as? String
        if dict["userId"]?.stringValue == UserSingletonModel.sharedInstance.userid!{
//            cell.view_comments.backgroundColor = UIColor.lightGray
             cell.view_comments.backgroundColor = UIColor(hexString: "#d7dfea")
        }else{
            cell.view_comments.backgroundColor = UIColor(hexString: "#edeff2")
        }
        return cell
    }
  
    //-----------table view code ends------------
    
    
    
    //======================Add Comments function to open and and close popup code starts 20th sept=======
    
    @IBOutlet var addCommentFormView: UIView!
    @IBOutlet weak var addCommentChildFormView: UIView!
    @IBOutlet weak var input_text_area: UITextView!
    
    @IBAction func btn_cancel_form(_ sender: Any) {
        cancelAddGoalFormPopup()
    }
    
    @IBAction func btn_save_form(_ sender: Any) {
        
        if input_text_area.text == "Description..."{
            Toast(text: "Field can't be empty", duration: Delay.short).show()
        }else if input_text_area.text == ""{
            Toast(text: "Field can't be empty", duration: Delay.short).show()
        }else{
            save_comment()
        }
    }
    
    //===============AddGoal openPopup function code starts=============
    func openAddGoalFormPopup(){
        blurEffect()
        self.view.addSubview(addCommentFormView)
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.height
        addCommentFormView.transform = CGAffineTransform.init(scaleX: 1.3,y :1.3)
        addCommentFormView.center = self.view.center
        addCommentFormView.layer.cornerRadius = 10.0
        addCommentChildFormView.layer.cornerRadius = 10.0
        addCommentFormView.alpha = 0
        addCommentFormView.sizeToFit()
        
        UIView.animate(withDuration: 0.3){
            self.addCommentFormView.alpha = 1
            self.addCommentFormView.transform = CGAffineTransform.identity
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
            self.addCommentFormView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.addCommentFormView.alpha = 0
            self.blurEffectView.alpha = 0.3
        }) { (success) in
            self.addCommentFormView.removeFromSuperview();
            self.canelBlurEffect()
        }
    }
    //-----AddGoal close popup code ends-------
    //======================Add Comments function to open and and close popup code ends 20th sept=======
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
    
    
    
    
    
    
    //===================20th Sept newly added code=============
    //---------function to get current date and time-------------
    func currentDate(){
        var todaysDate:Date = Date()
        var dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //var DateInFormat:String = dateFormatter.string(from: todaysDate)
        currentdate=dateFormatter.string(from: todaysDate)
    }
    //---------function to get current date and time code ends-------------
    
    
    //---------function to save comment code starts------------
    public func save_comment(){
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
        
        /* let apiurl="https://www.savantcare.com/v2/screening/api/public/index.php/api/postComment/\(UserSingletonModel.sharedInstance.publicUid!)"
         Alamofire.request(apiurl, method: .post, parameters: ["comment":txt_comment.text,"ticketId":UserSingletonModel.sharedInstance.helpdesk_public_unique_id!,"created_at":currentdate,"createdTimeZone":finalTimeZoneName,"updated_at":currentdate,"updateTimeZone":finalTimeZoneName],encoding: JSONEncoding.default, headers: nil).responseJSON{
         response in
         switch response.result{
         case .success:
         let swiftyJsonVar=JSON(response.result.value!)
         print(swiftyJsonVar)
         break
         
         case .failure(let error):
         print(error)
         }
         }*/
        let apiurl="https://www.savantcare.com/v3/api/helpdesk/public/index.php/api/postNewComment"
        let data: [String: Any] = [
            "comment" : input_text_area.text,
            "createdTimeZone" : finalTimeZoneName!,
            "created_at" : currentdate,
            "isPublish":1,
            "publicUniqueId":UserSingletonModel.sharedInstance.helpdesk_public_unique_id!,
            "publicUniqueUserId":UserSingletonModel.sharedInstance.publicUid!,
            "sourceId":14
        ]
        Alamofire.request(apiurl, method: .post, parameters: data,encoding: JSONEncoding.default, headers: nil).responseString{
            response in
            switch response.result{
            case .success:
                let swiftyJsonVar=JSON(response.result.value!)
                print(swiftyJsonVar)
                self.get_Helpdesk_comment_count()
                self.get_Helpdesk_comments()
                self.cancelAddGoalFormPopup()
                Toast(text: "Submitted", duration: Delay.short).show()
                break
                
            case .failure(let error):
                Toast(text: "Internal Error", duration: Delay.short).show()
                self.cancelAddGoalFormPopup()
                print(error)
            }
        }
        
    }
    //---------function to save comment code ends-------------
};extension String {
    
    func removeHTMLTag() -> String {
        
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
    }
    
};extension UIColor{
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
