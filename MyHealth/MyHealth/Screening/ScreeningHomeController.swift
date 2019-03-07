//
//  ScreeningHomeController.swift
//  MyHealth
//
//  Created by Satabhisha on 07/02/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation
import SystemConfiguration

class ScreeningHomeController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var label_wait: UILabel!
    
    @IBOutlet weak var label_No_screening: UILabel!
    @IBOutlet weak var btn_menu: UIBarButtonItem!
    var arrRes = [[String:AnyObject]]()
    let cellspacingheight:CGFloat = 5
    
    //--------Declaring shared preference-------
    let sharedpreference=UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
       self.tableview.delegate=self
        self.tableview.dataSource=self
        //--Hiding labels etc by default----
        label_No_screening.isHidden=true
        //--Hiding labels etc by default ends----
    //------calling sideMenus() function on page load--------
//        sideMenus()  //-----30th aug
        addSlideMenuButton() //---30th aug
    //------calling get_Screening_details() function to get the screening details------------
      get_Screening_details()
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
    
    //--------here viewDidAppear(_ animated: Bool) is used to check internet connectivity----------
    override func viewDidAppear(_ animated: Bool) {
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
     //--------viewDidAppear(_ animated: Bool) for checking internet connectivity code ends----------
    
    
    
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
    
    //-----------function to get screening details from api using Alamofire and Jsonswifty---------------
    func get_Screening_details(){
        //-----creating loader till the data loads---------
     /*  let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil) */
       
     //   dismiss(animated: true, completion:nil)
        //-----loader code ends----------
        Alamofire.request("https://www.savantcare.com/v2/screening/api/public/index.php/api/showPatientScreen/\(UserSingletonModel.sharedInstance.publicUid!)").responseJSON{ (responseData) -> Void in
            if((responseData.result.value) != nil){
                self.label_wait.isHidden=true
                self.loader.stopAnimating()
                let swiftyJsonVar=JSON(responseData.result.value!)
                print(swiftyJsonVar)
                if let resData = swiftyJsonVar["patientAssignedScreens"].arrayObject{
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count>0 {
                    self.tableview.reloadData()
                }else{
                    self.label_wait.isHidden=true
                    self.loader.stopAnimating()
                    self.label_No_screening.isHidden=false
                }
            }
            
        }
    }
     //-----------function to get screening details from api using Alamofire and Jsonswifty code ends---------------
    
    //---------tableview code starts here---------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ScreeningTableViewCell
       /* cell.layer.cornerRadius=10
        cell.layer.borderWidth=1
        cell.layer.borderColor=UIColor.blue.cgColor*/
        var dict = arrRes[indexPath.row]
       // cell.screeningname.text = dict["name"] as? String
        cell.view.layer.cornerRadius=10.0
         cell.label_screening_name.text=dict["name"] as? String
       
        return cell
    }
    //-------onclick tableview cell---------------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var row=arrRes[indexPath.row]
        print(row)
        print("tap is working")
        let screen_name=row["name"] as? String
        let tableName=row["tblName"] as? String
        let id1=row["id"] as? Int
        
        
        UserSingletonModel.sharedInstance.screening_mastertblGroups=row["mastertblGroups"] as? String
        UserSingletonModel.sharedInstance.screening_mastertblQuestions=row["mastertblQuestions"] as? String
        UserSingletonModel.sharedInstance.screening_screenId=row["screenId"] as? Int
        UserSingletonModel.sharedInstance.screening_mastertbl=row["mastertbl"] as? String
        UserSingletonModel.sharedInstance.screening_id=row["id"] as? Int  //------screening id should be used as previously I have used "screening_screenId" and this is causing a bug
        UserSingletonModel.sharedInstance.screening_tblName=row["tblName"] as? String
        UserSingletonModel.sharedInstance.screening_name=row["name"] as? String
        UserSingletonModel.sharedInstance.screening_created_at=row["created_at"] as? String
        print(id1!)
        // print(UserModel.sharedInstance.screening_screenId!)
        print(UserSingletonModel.sharedInstance.screening_tblName!)
        print(screen_name!)
        print(tableName!)
        
        
        //---------code to set data into jsonobject which is required as a parameter "activeScreenData" in question part api----------------
        let screenId=UserSingletonModel.sharedInstance.screening_screenId
        let id=UserSingletonModel.sharedInstance.screening_id
        let mastertbl=UserSingletonModel.sharedInstance.screening_mastertbl
        let mastertblGroups=UserSingletonModel.sharedInstance.screening_mastertblGroups
        let mastertblQuestions=UserSingletonModel.sharedInstance.screening_mastertblQuestions
        let tblName=UserSingletonModel.sharedInstance.screening_mastertbl
        let name=UserSingletonModel.sharedInstance.screening_name
        let created_at=UserSingletonModel.sharedInstance.screening_created_at
        let jsonObject: [String:Any] = [
            "screenId": screenId,
            "id": id,
            "mastertbl": mastertbl,
            "mastertblGroups": mastertblGroups,
            "mastertblQuestions": mastertblQuestions,
            "tblName": tblName,
            "name": name,
            "created_at": created_at
        ]
        if let data=try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
            var str=String(data: data, encoding: .utf8){
            UserSingletonModel.sharedInstance.screening_screen_data=str
            sharedpreference.set(str, forKey: "activescreendata")
            sharedpreference.synchronize()
            print("activescreendata \(UserSingletonModel.sharedInstance.screening_screen_data!)")
            
        }
        //---------code to set data into jsonobject which is required as a parameter "activeScreenData" in question part api ends----------------
        
        
        
        //-------code to go from one controller to another controller-----------
        self.performSegue(withIdentifier: "questionanswer", sender: self)
    }
    //-------onclick tableview cell code ends---------------
    //--------------tableview code ends--------------------
    
    
   
}
