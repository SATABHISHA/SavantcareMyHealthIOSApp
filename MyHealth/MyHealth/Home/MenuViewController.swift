//
//  MenuViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 30/08/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit
protocol SlideMenuDelegate{
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController {

    var btnMenu : UIButton!
    
    @IBOutlet weak var menu_feedback: UIView!
    @IBOutlet weak var menu_aboutus: UIView!
    @IBOutlet weak var menu_logout: UIView!
    
    @IBOutlet weak var menu_home: UIView!
    @IBOutlet weak var btnCloseMenuOverlay: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label_username: UILabel!
    @IBOutlet weak var label_mobilenumber: UILabel!
    @IBOutlet weak var label_email: UILabel!
    
    var delegate: SlideMenuDelegate?
    
    //---Declaring shared preferences----
    let sharedpreferences=UserDefaults.standard  //------27th aug newly added
    
    /* @objc func tapFunction(sender:UITapGestureRecognizer){
     performSegue(withIdentifier: "screeninghome", sender: self)
     }*/
    
    //----------these are the function which would work on tapping the view code starts------------------
    @objc func tapFunction_HomeView(sender:UITapGestureRecognizer){
        self.performSegue(withIdentifier: "home", sender: self)
    }
    @objc func tapFunction_FeedbackView(sender:UITapGestureRecognizer){
        self.performSegue(withIdentifier: "customMenuFeedback", sender: self)
    }
    @objc func tapFunction_AboutUsView(sender:UITapGestureRecognizer){
        self.performSegue(withIdentifier: "customAboutUs", sender: self)
    }
    @objc func tapFunction_LogOutView(sender:UITapGestureRecognizer){
        removeUserDefaults()
    }
    //----------these are the function which would work on tapping the view code ends------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //-----setting the image(fetched from api) in the imageView---------
        /*let url=URL(string: UserSingletonModel.sharedInstance.userImageUrl!)!
         imageView.af_setImage(withURL: url)*/
        imageView.image=#imageLiteral(resourceName: "profile")
        if UserSingletonModel.sharedInstance.userImageUrl! != "" && UserSingletonModel.sharedInstance.gender! == "Male" {
            let url=URL(string: UserSingletonModel.sharedInstance.userImageUrl!)!
            imageView.af_setImage(withURL: url)
        }else if UserSingletonModel.sharedInstance.userImageUrl! != "" && UserSingletonModel.sharedInstance.gender! == "Female" {
            let url=URL(string: UserSingletonModel.sharedInstance.userImageUrl!)!
            imageView.af_setImage(withURL: url)
        }else if UserSingletonModel.sharedInstance.userImageUrl! == "" && UserSingletonModel.sharedInstance.gender! == "Male"{
            //var image=UIImageView(image: #imageLiteral(resourceName: "male"))
            imageView.image=#imageLiteral(resourceName: "male")
        }else if UserSingletonModel.sharedInstance.userImageUrl! == "" && UserSingletonModel.sharedInstance.gender! == "Female"{
            imageView.image=#imageLiteral(resourceName: "female")
        }else{
            imageView.image=#imageLiteral(resourceName: "profile")
        }
        //-----setting the image(fetched from api) in the imageView code ends---------
        
        //----setting the name(fetched from api) in the label--------
        label_username.text=UserSingletonModel.sharedInstance.userFullName
        label_mobilenumber.text=UserSingletonModel.sharedInstance.mobilenumber
        label_email.text=UserSingletonModel.sharedInstance.emailAddress
        
        
        //-----calling function to navigate to corresponding controller on clicking the menu item----------
        onMenuClick()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func btnCloseTapped(_ sender: UIButton) {
        btnMenu.tag = 0
        btnMenu.isHidden = false
        if (self.delegate != nil){
            var index = Int32(sender.tag)
            if (sender == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        UIView.animate(withDuration: 0.3, animations: {() -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y:0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        },completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //------------function to navigate to another controller on menu item click-----------
    func onMenuClick(){
        let tap_home = UITapGestureRecognizer(target: self, action: #selector(tapFunction_HomeView))
        //  label_menu_home.isUserInteractionEnabled = true
        //   label_menu_home.addGestureRecognizer(tap)
        menu_home.isUserInteractionEnabled=true
        menu_home.addGestureRecognizer(tap_home)
        
        
        let tap_feedback = UITapGestureRecognizer(target: self, action: #selector(tapFunction_FeedbackView))
        //  label_menu_home.isUserInteractionEnabled = true
        //   label_menu_home.addGestureRecognizer(tap)
        menu_feedback.isUserInteractionEnabled=true
        menu_feedback.addGestureRecognizer(tap_feedback)
        
        let tap_aboutus = UITapGestureRecognizer(target: self, action: #selector(tapFunction_AboutUsView))
        //  label_menu_home.isUserInteractionEnabled = true
        //   label_menu_home.addGestureRecognizer(tap)
        menu_aboutus.isUserInteractionEnabled=true
        menu_aboutus.addGestureRecognizer(tap_aboutus)
        
        let tap_logout = UITapGestureRecognizer(target: self, action: #selector(tapFunction_LogOutView))
        //  label_menu_home.isUserInteractionEnabled = true
        //   label_menu_home.addGestureRecognizer(tap)
        menu_logout.isUserInteractionEnabled=true
        menu_logout.addGestureRecognizer(tap_logout)
    }
    //------------function to navigate to another controller on menu item click code ends-----------

    //--------to lock screen rotation, here shouldAutorotate is made false----------------
    override var shouldAutorotate: Bool{
        return false
    }
    //--------autorotation code ends--------------
    
    //----------27th aug newly added code starts(for logout)----------
    func removeUserDefaults(){
        //        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        sharedpreferences.removeObject(forKey: "publicUid")
        sharedpreferences.synchronize()
        btnMenu.tag = 0
        btnMenu.isHidden = true
        self.performSegue(withIdentifier: "customLogin", sender: self)
    }
    //---------27th aug newly added code ends---------
}
