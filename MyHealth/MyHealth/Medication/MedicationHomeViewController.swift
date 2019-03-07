//
//  MedicationHomeViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 24/05/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MedicationHomeViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
   

     @IBOutlet weak var btn_menu: UIBarButtonItem!
    @IBOutlet weak var tableview: UITableView!
    var arrRes = [[String:AnyObject]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //------calling sideMenus() function on page load--------
//        sideMenus() //------30th aug
          addSlideMenuButton() //---30th aug
        
        getMedicationDetails()
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
    
    
    //===========tableview code starts==========
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MedicationTableViewCell
//        cell.layer.cornerRadius = 10
        //        cell.layer.borderWidth=1
        
        //        cell.layer.borderColor=UIColor.blue.cgColor
        
        //        cell.view_linedraw.
        cell.view.layer.cornerRadius = 10
        var dict = arrRes[indexPath.row]
        cell.labelMedicineName.text = dict["name"] as? String
        cell.labelQuantityRefilSupply.text = "\(dict["quantity"] as! String) |  Refill: \(dict["numberOfRefills"] as! String)  |  Days of Supply: \(dict["daysSupply"] as? String ?? "")"
        cell.labelPatient.text = dict["noteToPharmacist"] as? String ?? ""
        cell.labelPatient.text = dict["directionToPatient"] as? String ?? ""
        cell.labelPrescribedBy.text = "\(dict["userFullName"] as? String ?? "")  \(dict["created_at"] as? String ?? "")"
        return cell
        
    }
    //==========tableview code ends===============
    
    //===========function to get medication details from api using Alamofire and Jsonswifty code starts==========
    func getMedicationDetails(){
//        var api = "https://www.savantcare.com/v2/screening/api/public/index.php/api/getDetailsMedication/ef0844e8-8b70-4fae-861d-ea7af21301b8"
        var api = "https://www.savantcare.com/v2/screening/api/public/index.php/api/getDetailsMedication/\(UserSingletonModel.sharedInstance.publicUid!)"
        Alamofire.request(api).responseJSON{ (responseData) -> Void in
            if((responseData.result.value) != nil){
//                self.label_wait.isHidden=true
//                self.loader.stopAnimating()
                let swiftyJsonVar=JSON(responseData.result.value!)
                print("Medication description: \(swiftyJsonVar)")
                if let resData = swiftyJsonVar["data"].arrayObject{
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count>0 {
                    self.tableview.reloadData()
                }else{
                    //                    self.tableview.reloadData()
                    //                    Toast(text: "No data", duration: Delay.short).show()
                    let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableview.bounds.size.width, height: self.tableview.bounds.size.height))
                    noDataLabel.text          = "No Medications"
                    noDataLabel.textColor     = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.tableview.backgroundView  = noDataLabel
                    self.tableview.separatorStyle  = .none
                }
            }
            
        }
    }
    //===========function to get medication details from api using Alamofire and Jsonswifty code ends=========

}
