//
//  AddRequestViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 02/05/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toaster

class AddRequestViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var txt_title: UITextField!
    @IBOutlet weak var txt_desc: UITextView!
    
    var helpdesk_title: String!
    var helpdesk_desc:String!
   // var helpdesk_status:String!
    var helpdesk_date:String!
    var priority:String!
    var selectPriority:String!="1"
    var currentdate:String!
    var arrRes = [[String:AnyObject]]()
    
    
    @IBAction func btn_back(_ sender: Any) {
         self.performSegue(withIdentifier: "helpdeskhome", sender: nil)
    }
    @IBAction func btn_save_addrequest(_ sender: Any) {
        print("tapped")
        if(txt_title.text == "" && txt_desc.text == ""){
            Toast(text: "Field can't be left blank", duration: Delay.short).show()
        }else if(txt_title.text == "" || txt_desc.text == ""){
            Toast(text: "Field can't be left blank", duration: Delay.short).show()
        }else{
        //-------calling function to save the data to the server-----------
        save_add_request_data()
        }
       
    }
    let priorities = ["normal","urgent"]
    override func viewDidLoad() {
        pickerView.delegate = self
        pickerView.dataSource=self
        super.viewDidLoad()
        print(selectPriority)
        //--------- code to make the text with rounded edges code starts -------------
        txt_desc.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        txt_desc.layer.borderWidth = 1.0
        txt_desc.layer.cornerRadius = 10
        
        txt_title.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        txt_title.layer.borderWidth = 1.0
        txt_title.layer.cornerRadius = 10
         //--------- code to make the text with rounded edges code ends -------------
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
    // returns the number of 'columns' to display.
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    // returns the # of rows in each component..
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return priorities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priorities[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //  countrylbl.text = countries[row]
        priority="\(priorities[row])"
        if(priority == "normal"){
            selectPriority="1"
        }else{
            selectPriority="2"
        }
        print(selectPriority)
    }
    
    //---------function to get current date and time-------------
    func currentDate(){
        var todaysDate:Date = Date()
        var dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //var DateInFormat:String = dateFormatter.string(from: todaysDate)
        currentdate=dateFormatter.string(from: todaysDate)
        print(currentdate)
    }
    //---------function to get current date and time code ends-------------
    
    
    //----------function to save the Add Request data----------
    public func save_add_request_data(){
        currentDate()
       /* let currentAutoUpdateTZ = TimeZone.current.identifier
        print(currentAutoUpdateTZ)*/
        
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
        
        
        helpdesk_title="\(String(describing: txt_title.text!))"
        helpdesk_desc="\(txt_desc.text!)"
        
        let apiurl="https://www.savantcare.com/v3/api/helpdesk/public/index.php/api/postNewTicket"
        let data: [String: Any] = [
            "assignedId" : 0,
            "createdTimeZone" : finalTimeZoneName!,
            "created_at" : currentdate,
            "description":helpdesk_desc,
            "priority":selectPriority,
            "publicUniqueId":UserSingletonModel.sharedInstance.publicUid!,
            "sourceId":14,
            "statusId":1,
            "title":helpdesk_title,
            "typeId":1
            
        ]
        Alamofire.request(apiurl, method: .post, parameters: data,encoding: JSONEncoding.default, headers: nil).responseString{
            response in
            switch response.result{
            case .success:
                let swiftyJsonVar=JSON(response.result.value!)
                print(swiftyJsonVar)
                Toast(text: "Submitted", duration: Delay.short).show()
                self.performSegue(withIdentifier: "helpdeskhome", sender: nil)
                break
                
            case .failure(let error):
                Toast(text: "Internal Error", duration: Delay.short).show()
                print(error)
            }
        }
    }
    //----------function to save the Add Request data ends--------
    
    //-----------function to get the priority details----------
    public func getPriority(){
        Alamofire.request("https://www.savantcare.com/v1/screening/api/public/index.php/api/getPriority/\(UserSingletonModel.sharedInstance.publicUid!)").responseJSON{ (responseData) -> Void in
            if((responseData.result.value) != nil){
                let swiftyJsonVar=JSON(responseData.result.value!)
                print("Priority names: \(swiftyJsonVar)")
                if let resData = swiftyJsonVar["data"].arrayObject{
                    self.arrRes = resData as! [[String:AnyObject]]
                }
            }
            
        }
    }
    
    //------------function to get the priority details code ends--------

}
