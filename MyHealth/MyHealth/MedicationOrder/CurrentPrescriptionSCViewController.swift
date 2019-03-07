//
//  CurrentPrescriptionSCViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 14/09/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CurrentPrescriptionSCViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableview: UITableView!
    var arrRes = [[String:AnyObject]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        self.tableview.delegate=self
        self.tableview.dataSource=self
        // Do any additional setup after loading the view.
        get_Medication_details()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //---------tableview code starts here---------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CurrentPrescriptionSCTableViewCell
        /* cell.layer.cornerRadius=10
         cell.layer.borderWidth=1
         cell.layer.borderColor=UIColor.blue.cgColor*/
//        var dict = arrRes[indexPath.row]
//        var dict = medicationDetailsDictionary[indexPath.row]
//        cell.labelDrugName.text = dict["orderingProviderName"] as? String
//        cell.labelDrugName.text = dict["recommendationDescription"] as? String
//        print("Drugname",arrRes[indexPath.row])
        // cell.screeningname.text = dict["name"] as? String
        var dict = medicationDetailsDictionary
        cell.labelDrugName.text = dict["orderingProviderName"] as? String
        
//        cell.view.layer.cornerRadius=10.0
        // cell.view.frame.size.height = 20.0
//        cell.label_recommendations.text=dict["recommendationDescription"] as? String
       
        
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
    
    //-----------function to get medication details prescribed by SC from api using Alamofire and Jsonswifty---------------
    var medicationDetailsDictionary = [String:Any]()
    func get_Medication_details(){
//        loader.startAnimating()
//        let apiurl = "https://www.savantcare.com/v2/screening/api/public/index.php/api/getRecommendationFromDoctor/\(UserSingletonModel.sharedInstance.publicUid!)"
        let apiurl = "https://www.savantcare.com/v2/screening/api/public/index.php/api/getActiveOrders/\(UserSingletonModel.sharedInstance.publicUid!)"
        Alamofire.request(apiurl).responseJSON{ (responseData) -> Void in
            if((responseData.result.value) != nil){
//                self.label_wait.isHidden=true
//                self.loader.stopAnimating()
                let swiftyJsonVar=JSON(responseData.result.value!)
//                print("Medication description: \(swiftyJsonVar.dictionaryObject!)")
               /* if let resData = swiftyJsonVar["data"].dictionaryObject{
                    self.medicationDetailsDictionary = resData
                    print("Medication description",self.medicationDetailsDictionary)
                }*/
              
                
              /*  for (key,subJson) in swiftyJsonVar["data"]{
                    self.arrRes = subJson
                    if let name = subJson["drugName"].string{
                        print("Medicine name",name)
                    }
                }*/
//                self.arrRes = swiftyJsonVar["data"][]
                if let resData = swiftyJsonVar["data"].dictionary {
                    self.medicationDetailsDictionary = resData
                }
                if self.arrRes.count>0 {
                    self.tableview.reloadData()
                }else{
//                    self.label_wait.isHidden=true
//                    self.loader.stopAnimating()
//                    self.label_no_recommendation.isHidden=false
                }
            }
            
        }
    }
    //-----------function to get medication details prescribed by SC from api using Alamofire and Jsonswifty code ends---------------

}
