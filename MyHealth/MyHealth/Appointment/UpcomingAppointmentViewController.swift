//
//  UpcomingAppointmentViewController.swift
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

class UpcomingAppointmentViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var label_wait: UILabel!
    @IBOutlet weak var label_no_upcoming_appointments: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var btn_menu: UIBarButtonItem!
    var arrRes=[[String:AnyObject]]()
    let cellspacingheight:CGFloat = 5
    override func viewDidLoad() {
        super.viewDidLoad()
//        sideMenus() //--------30th aug
         addSlideMenuButton() //---30th aug
        //---to disable labels etc by default--------
        label_no_upcoming_appointments.isHidden=true
        //---to disable labels etc by default ends--------
        get_upcoming_Appointment_details()
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
    func get_upcoming_Appointment_details(){
        loader.startAnimating()
        Alamofire.request("https://www.savantcare.com/v2/screening/api/public/index.php/api/upcomingPatientAppointments/\(UserSingletonModel.sharedInstance.publicUid!)").responseJSON{ (responseData) -> Void in
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
                    self.label_no_upcoming_appointments.isHidden=false
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UpcomingAppointmentTableViewCell
        var dict = arrRes[indexPath.row]
        cell.upcoming_appointments_hostname.text=dict["hostName"] as? String
        
        //-------to convert Aug 08, 2016 10:08 am format to Aug 08, 2016 code starts here--------
        let date_str=dict["startDateFormate"] as! String
        let date_index=date_str.index(date_str.startIndex, offsetBy: 13)
        cell.upcoming_appointments_date.text="Date: \(String(date_str.prefix(upTo: date_index)))"
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
        
        cell.upcoming_appointments_time.text="Time: \(Date12) to \(Date12_1)"
        //--------String support subscript(access with[]) out of the box and code to convert 24hrs format to 12hrs with am/pm format code ends----------
        
        cell.upcoming_appointments_doctor_image.image = #imageLiteral(resourceName: "male")
        let hostId=dict["hostId"] as! Int
        let url=URL(string: "https://www.savantcare.com/v2/screening/api/public/index.php/api/getDoctorImage/\(hostId)")!
        cell.upcoming_appointments_doctor_image.af_setImage(withURL: url)
        cell.upcoming_appointments_status.text=dict["eventStatus"] as? String
        
        //-------setting the corner radius of view-----------
        cell.view.layer.cornerRadius=10
        
        return cell
    }
    //---------to display some value(No upcoming appointments...) when no data is present in the database regarding to that user-------
   /* func numberOfSections(in tableView: UITableView) -> Int {
        var numofSections: Int=0
        if self.arrRes.count>0{
            numofSections=1
            tableview.backgroundView=nil
        }else{
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No upcoming appointments"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numofSections
    }*/
    //---------to display some value(No upcoming appointments...) when no data is present in the database regarding to that user code ends-------
    //--------------tableview code ends--------------------
    
    
}
