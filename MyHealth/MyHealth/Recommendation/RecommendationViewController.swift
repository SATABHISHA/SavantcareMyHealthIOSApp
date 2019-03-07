//
//  RecommendationViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 07/03/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation
import SystemConfiguration

class RecommendationViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var label_wait: UILabel!
    @IBOutlet weak var label_no_recommendation: UILabel!
    @IBOutlet weak var tableview: UITableView!
    var arrRes = [[String:AnyObject]]()
    let cellspacingheight:CGFloat = 5
    @IBOutlet weak var btn_menu: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.estimatedRowHeight=44.0
        tableview.rowHeight=UITableViewAutomaticDimension
        
        //--Hiding labels etc by default----
        label_no_recommendation.isHidden=true
        //--Hiding labels etc by default ends----
      //  self.tableview.delegate=self
      //  self.tableview.dataSource=self
        //------calling sideMenus() function on page load--------
//        sideMenus() //------30th aug
        addSlideMenuButton() //---30th aug
        // Do any additional setup after loading the view.
        
        get_Recommendation_details()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
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
    
    
    

    //-----------function to get recommendation details from api using Alamofire and Jsonswifty---------------
    func get_Recommendation_details(){
        loader.startAnimating()
        Alamofire.request("https://www.savantcare.com/v2/screening/api/public/index.php/api/getRecommendationFromDoctor/\(UserSingletonModel.sharedInstance.publicUid!)").responseJSON{ (responseData) -> Void in
            if((responseData.result.value) != nil){
                self.label_wait.isHidden=true
                self.loader.stopAnimating()
                let swiftyJsonVar=JSON(responseData.result.value!)
                print("Recommendation description: \(swiftyJsonVar)")
                if let resData = swiftyJsonVar["data"].arrayObject{
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count>0 {
                    self.tableview.reloadData()
                }else{
                    self.label_wait.isHidden=true
                    self.loader.stopAnimating()
                    self.label_no_recommendation.isHidden=false
                }
            }
            
        }
    }
    //-----------function to get recommendation details from api using Alamofire and Jsonswifty code ends---------------
    
    //---------tableview code starts here---------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RecommendationTableViewCell
        /* cell.layer.cornerRadius=10
         cell.layer.borderWidth=1
         cell.layer.borderColor=UIColor.blue.cgColor*/
        var dict = arrRes[indexPath.row]
        // cell.screeningname.text = dict["name"] as? String
        
        cell.view.layer.cornerRadius=10.0
       // cell.view.frame.size.height = 20.0
        cell.label_recommendations.text=dict["recommendationDescription"] as? String
        
        return cell
    }
    //---------to display some value(No recommendations...) when no data is present in the database regarding to that user-------
   /* func numberOfSections(in tableView: UITableView) -> Int {
        var numofSections: Int=0
        if self.arrRes.count>0{
            numofSections=1
            tableview.backgroundView=nil
        }else{
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No recommendations"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numofSections
    }*/
     //---------to display some value(No recommendations...) when no data is present in the database regarding to that user code ends-------
    //-----------table view code ends------------
}
