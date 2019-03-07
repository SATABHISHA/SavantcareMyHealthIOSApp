//
//  HelpdeskViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 26/04/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HelpdeskViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var label_norequest: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var label_wait: UILabel!
    
    @IBOutlet weak var btn_menu: UIBarButtonItem!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var btn_add_request: UIButton!
    
    
    var arrRes = [[String:AnyObject]]()
    
    @IBAction func btn_add_request(_ sender: Any) {
        self.performSegue(withIdentifier: "addrequest", sender: self)
    /*    let popOverVC = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "addrequestpopup") as! PopUpAddRequestViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame=self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        sideMenus()
          addSlideMenuButton() //---30th aug
        self.tableview.delegate=self
        self.tableview.dataSource=self
        label_norequest.isHidden=true
        
        btn_add_request.layer.cornerRadius = self.btn_add_request.frame.height/2.0
        get_Helpdesk_details()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        get_Helpdesk_details()
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
    
    
    //----------function to show helpdesk details using Alamofire and JsonSwifty-------------
    func get_Helpdesk_details(){
        loader.startAnimating()
        Alamofire.request("https://www.savantcare.com/v2/screening/api/public/index.php/api/getHelpDeskDetail/\(UserSingletonModel.sharedInstance.publicUid!)").responseJSON{ (responseData) -> Void in
            if((responseData.result.value) != nil){
                self.loader.stopAnimating()
                self.label_wait.isHidden=true
                let swiftyJsonVar=JSON(responseData.result.value!)
                print("Helpdesk details: \(swiftyJsonVar)")
                if let resData = swiftyJsonVar["data"].arrayObject{
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count>0 {
                    self.tableview.reloadData()
                }else{
                    self.loader.stopAnimating()
                    self.label_wait.isHidden=true
                    // self.label_no_goal.isHidden=false
                    self.label_norequest.isHidden=false 
                    //  self.label_nogoal.text="No Goal"
                    
                }
            }
            
        }
    }
    
    //----------function to show helpdesk details using Alamofire and Jsonswifty code ends---------
    
    //---------tableview code starts here---------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HelpdeskHomeTableViewCell
        /* cell.layer.cornerRadius=10
         cell.layer.borderWidth=1
         cell.layer.borderColor=UIColor.blue.cgColor*/
        var dict = arrRes[indexPath.row]
        // cell.screeningname.text = dict["name"] as? String
        
        //cell.view_goal.layer.cornerRadius=10.0
        // cell.view.frame.size.height = 20.0
        cell.view.layer.cornerRadius=10.0
      /*  cell.title.text=dict["title"] as? String
        cell.status.text="\(dict["status"]!)"
        cell.date.text="\(dict["created_at"]!)"*/
        cell.title.text="Title: \(dict["title"]!)"
        cell.status.text="Status: \(dict["status"]!)"
        cell.date.text="\(dict["created_at"]!)"
        cell.ticket_id.text="\(dict["id"]!)"
        // cell.label_value_of_rating.layer.cornerRadius=15
        return cell
    }
    //---------onClick tableview code starts----------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var row=arrRes[indexPath.row]
        print(row)
        print("tap is working")
        let publicUniqueId=row["publicUniqueId"] as? String
        print(publicUniqueId!)
       // UserSingletonModel.sharedInstance.goalID=row["id"] as? Int
       // UserSingletonModel.sharedInstance.goalPublicUid=row["goalPublicUid"] as? String
       // print(UserSingletonModel.sharedInstance.goalPublicUid!)
        // get_Goal_details()
        UserSingletonModel.sharedInstance.helpdesk_status=row["status"] as? String
        UserSingletonModel.sharedInstance.helpdesk_statusId=row["statusId"] as? Int
        UserSingletonModel.sharedInstance.helpdesk_created_at=row["created_at"] as? String
        UserSingletonModel.sharedInstance.helpdesk_description=row["description"] as? String
        UserSingletonModel.sharedInstance.helpdesk_userId=row["userId"] as? Int
        UserSingletonModel.sharedInstance.helpdesk_title=row["title"] as? String
        UserSingletonModel.sharedInstance.helpdesk_public_unique_id=row["publicUniqueId"] as? String
        
        self.performSegue(withIdentifier: "helpdeskdesc", sender: self)
    }
    //---------onClick tableview code ends----------
    //-----------table view code ends------------
    
    
   

}
