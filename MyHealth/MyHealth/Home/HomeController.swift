//
//  HomeController.swift
//  MyHealth
//
//  Created by Satabhisha on 07/02/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toaster
import Foundation
import SystemConfiguration

class HomeController: BaseViewController {
    //---Declaring shared preferences----
    let sharedpreferences=UserDefaults.standard
    
    @IBOutlet weak var btn_menu: UIBarButtonItem!
    
    @IBOutlet weak var btn_moodnotes: UIButton!
    // @IBOutlet weak var img: UIImageView!
    //@IBOutlet weak var txt: UITextView!
  //  let remoteImageUrl=URL(string: UserModel.sharedInstance.userImageUrl!)
    
   
    @IBAction func btn_screening(_ sender: Any) {
      //  self.dismiss(animated: true, completion: nil) //--------this would dismiss this controller
         self.performSegue(withIdentifier: "homescreening", sender: self)
         
        //screeninghome
       // self.performSegue(withIdentifier: "screeninghome", sender: self)
    }
    
    @IBAction func btn_recommendation(_ sender: Any) {
        self.performSegue(withIdentifier: "recommendation", sender: self)
    }
    
    @IBAction func btn_Goal(_ sender: Any) {
//        self.performSegue(withIdentifier: "goalhome", sender: self)
        self.performSegue(withIdentifier: "goalModified", sender: self)
    }
    
    
    @IBAction func btn_appointment(_ sender: Any) {
        self.performSegue(withIdentifier: "appointment", sender: self)
    }
    
    @IBAction func btn_helpdesk(_ sender: Any) {
         self.performSegue(withIdentifier: "helpdesk", sender: self)
    }
    
    @IBAction func btn_medication(_ sender: Any) {
//        self.performSegue(withIdentifier: "medicationhome", sender: self)
        self.performSegue(withIdentifier: "medicationOrder", sender: self)
    }
//
//    @IBAction func btn_feedback(_ sender: Any) {
//        self.performSegue(withIdentifier: "feedback", sender: self)
//    }
//
//    @IBAction func btn_aboutus(_ sender: Any) {
//        self.performSegue(withIdentifier: "aboutus", sender: self)
//    }
    
    @IBAction func btn_moodnotes(_ sender: Any) {
        self.performSegue(withIdentifier: "moodsplashscreen", sender: self)
    }
    /* @IBAction func btn_helpdesk(_ sender: Any) {
        self.performSegue(withIdentifier: "helpdesk", sender: self)
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // sideMenus()   //-------30th aug changes
        
        get_user_emailid()
        addSlideMenuButton()
        // Do any additional setup after loading the view.
        //print(UserSingletonModel.sharedInstance.firebaseInstanceId!)
        //let str=sharedpreferences.object(forKey: "instanceId") as? String
        print("Fiirebaseinstance shared: \(sharedpreferences.object(forKey: "instanceId") as! String as Any)")
      //  print("Fiirebaseinstance shared: \(str!)")
        //--------storing firebase instanceId to the server using Alamofire and JsonSwifty----------
        let apiUrl = "https://www.savantcare.com/v1/screening/api/public/index.php/api/storeUsersInstanceId/\(UserSingletonModel.sharedInstance.userid!)"
        Alamofire.request(apiUrl, method: .post, parameters: ["instanceId":sharedpreferences.object(forKey: "instanceId") as! String as Any],encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success:
                let swiftyJsonVar=JSON(response.result.value!)
                print(swiftyJsonVar)
                break
            case .failure(let error):
                print(error)
            }
        }
        
        //--------storing firebase instanceId to the server using Alamofire and JsonSwifty code ends----------
      /*  txt.text=UserModel.sharedInstance.userid!
        txt.text=UserModel.sharedInstance.userFullName!
        //---------Code to fetch image from json and display----------------
            Alamofire.request(remoteImageUrl!).responseData{ (response) in
                if response.error == nil {
                    print(response.result)
                    
                    if let data = response.data {
                      //  self.img.image=UIImage(data: data)
                    }
                }
                
            }*/
        //---------Code to fetch image from json and display ends----------------
//         Toast(text: "\(UserSingletonModel.sharedInstance.mobilenumber!)", duration: Delay.short).show()
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
    //--------to lock screen rotation, here shouldAutorotate is made false----------------
    override var shouldAutorotate: Bool{
        return false
    }
   //--------autorotation code ends--------------
    
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
    
    //==============function to get email_id code starts=============
    func get_user_emailid(){
        Alamofire.request("https://www.savantcare.com/v2/screening/api/public/index.php/api/getUserEmail/\(UserSingletonModel.sharedInstance.publicUid!)").responseJSON{ (responseData) -> Void in
            if((responseData.result.value) != nil){
                let swiftyJsonVar=JSON(responseData.result.value!)
                print("Email address: \(swiftyJsonVar)")
                print("Email id: \(swiftyJsonVar["data"]["emailAddress"])")
                UserSingletonModel.sharedInstance.emailAddress = swiftyJsonVar["data"]["emailAddress"].string ?? ""
            }
            
        }
    }
    //============function to get email_id code ends==========================
}
