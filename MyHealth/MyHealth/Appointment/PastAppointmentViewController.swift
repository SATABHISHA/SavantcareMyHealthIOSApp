//
//  PastAppointmentViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 16/03/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation
import SystemConfiguration

class PastAppointmentViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate  {
   
    
   
    
    @IBOutlet weak var tableview: UITableView!
    
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var label_wait: UILabel!
    @IBOutlet weak var label_no_past_appointments: UILabel!
    @IBOutlet weak var btn_menu: UIBarButtonItem!
    var arrRes=[[String:AnyObject]]()
    let cellspacingheight:CGFloat = 5
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //---to disable labels etc by default--------
        label_no_past_appointments.isHidden=true
        //---to disable labels etc by default ends--------
//        sideMenus()   //-------30th aug
          addSlideMenuButton() //---30th aug
        
        get_past_Appointment_details()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
    
    
    //-----------function to get upcoming appointment details from api using Alamofire and Jsonswifty---------------
    func get_past_Appointment_details(){
        loader.startAnimating()
        Alamofire.request("https://www.savantcare.com/v2/screening/api/public/index.php/api/getPatientSummaryDataOfAppointments/\(UserSingletonModel.sharedInstance.publicUid!)").responseJSON{ (responseData) -> Void in
            if((responseData.result.value) != nil){
                self.loader.stopAnimating()
                self.label_wait.isHidden=true
                let swiftyJsonVar=JSON(responseData.result.value!)
                print("Recommendation description: \(swiftyJsonVar)")
                if let resData = swiftyJsonVar["data"].arrayObject{
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count>0 {
                    self.tableview.reloadData()
                }else{
                    self.loader.stopAnimating()
                    self.label_wait.isHidden=true
                    self.label_no_past_appointments.isHidden=false
                }
            }
            
        }
    }
    //-----------function to get upcoming appointment details from api using Alamofire and Jsonswifty code ends---------------
    
    
    
      //---------tableview code starts here---------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PastAppointmentTableViewCell
         var dict = arrRes[indexPath.row]
        cell.name.text=dict["hostName"] as? String
        
        //-------to convert Aug 08, 2016 10:08 am format to Aug 08, 2016 code starts here--------
        let date_str=dict["startDateFormate"] as! String
        let date_index=date_str.index(date_str.startIndex, offsetBy: 13)
        cell.date.text="Date: \(String(date_str.prefix(upTo: date_index)))"
        //-------to convert Aug 08, 2016 10:08 am format to Aug 08, 2016 code ends--------
        
        
        //--------String support subscript(access with[]) out of the box and code to convert 24hrs format to 12hrs with am/pm format code starts here----------
        //-------startDateTime code to change the format starts here-------
        let str=dict["startDateTime"] as! String
        let index=str.index(str.startIndex, offsetBy: 11)
        let end_index=str.index(str.endIndex, offsetBy:-3)
        let dateAsString = str[index ..< end_index]
        let dateFormatter=DateFormatter()
        dateFormatter.dateFormat="HH:mm"
        
        let date = dateFormatter.date(from: String(dateAsString))
        dateFormatter.dateFormat = "h:mm a"
        let Date12 = dateFormatter.string(from: date!)
        //-------startDateTime code to change the format ends here-------
        
        //-------endDateTime code to change the format starts here--------
        let str1=dict["endDateTime"] as! String
        let index1=str1.index(str1.startIndex, offsetBy: 11)
        let end_index1=str.index(str1.endIndex, offsetBy:-3)
        let dateAsString1 = str1[index1 ..< end_index1]
        let dateFormatter1=DateFormatter()
        dateFormatter1.dateFormat="HH:mm"
        
        let date1 = dateFormatter1.date(from: String(dateAsString1))
        dateFormatter1.dateFormat = "h:mm a"
        let Date12_1 = dateFormatter.string(from: date1!)
         //-------endDateTime code to change the format ends here--------
        
        cell.time.text="Time: \(Date12) to \(Date12_1)"
       //--------String support subscript(access with[]) out of the box and code to convert 24hrs format to 12hrs with am/pm format code ends----------
         cell.doctor_image.image = #imageLiteral(resourceName: "male")
        let hostId=dict["hostId"] as! Int
        let url=URL(string: "https://www.savantcare.com/v2/screening/api/public/index.php/api/getDoctorImage/\(hostId)")!
        cell.doctor_image.af_setImage(withURL: url)
        
        //-------code to ommit some words in status part code starts------
        let strEventStatus = dict["eventStatus"] as? String ?? ""
        print("strEventStatus",strEventStatus)
        if strEventStatus == ""{
            cell.status.text = "Status: Not Available"
        }else{
        let startIndexEventStatus = strEventStatus.index(strEventStatus.startIndex, offsetBy: 7)
        let endIndexEventStatus = strEventStatus.index(strEventStatus.endIndex, offsetBy: 0)
        let status = strEventStatus[startIndexEventStatus ..< endIndexEventStatus]
        var statusString: String! = ""
        statusString.append(String(status))
            cell.status.text = "Status: \(statusString!)"
        }
        //-------code to ommit some words  in status part code ends------
        
        //-------setting the corner radius of view-----------
        cell.view.layer.cornerRadius=10

        
        return cell
    }
    
    //--------------tableview code ends--------------------
}
