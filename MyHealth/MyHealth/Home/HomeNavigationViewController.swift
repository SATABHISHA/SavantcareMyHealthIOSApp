//
//  HomeNavigationViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 27/08/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit

class HomeNavigationViewController: UIViewController {

    @IBOutlet weak var label_username: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label_mobilenumber: UILabel!
    
   
    
    @IBOutlet weak var menu_feedback: UIView!
    @IBOutlet weak var menu_item: UIView!
    @IBOutlet weak var menu_aboutus: UIView!
    @IBOutlet weak var menu_logout: UIView!
    
    //---Declaring shared preferences----
    let sharedpreferences=UserDefaults.standard  //------27th aug newly added
    
   /* @objc func tapFunction(sender:UITapGestureRecognizer){
        performSegue(withIdentifier: "screeninghome", sender: self)
    }*/
    
    //----------these are the function which would work on tapping the view code starts------------------
    @objc func tapFunction_FeedbackView(sender:UITapGestureRecognizer){
        self.performSegue(withIdentifier: "menuFeedback", sender: self)
    }
    @objc func tapFunction_AboutUsView(sender:UITapGestureRecognizer){
        self.performSegue(withIdentifier: "menuAboutUs", sender: self)
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
        
        
        //-----calling function to navigate to corresponding controller on clicking the menu item----------
        onMenuClick()
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
    //------------function to navigate to another controller on menu item click-----------
    func onMenuClick(){
        let tap_feedback = UITapGestureRecognizer(target: self, action: #selector(HomeNavigationViewController.tapFunction_FeedbackView))
        //  label_menu_home.isUserInteractionEnabled = true
        //   label_menu_home.addGestureRecognizer(tap)
        menu_feedback.isUserInteractionEnabled=true
        menu_feedback.addGestureRecognizer(tap_feedback)
        
        let tap_aboutus = UITapGestureRecognizer(target: self, action: #selector(HomeNavigationViewController.tapFunction_AboutUsView))
        //  label_menu_home.isUserInteractionEnabled = true
        //   label_menu_home.addGestureRecognizer(tap)
        menu_aboutus.isUserInteractionEnabled=true
        menu_aboutus.addGestureRecognizer(tap_aboutus)
       
        let tap_logout = UITapGestureRecognizer(target: self, action: #selector(HomeNavigationViewController.tapFunction_LogOutView))
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
        self.performSegue(withIdentifier: "login", sender: self)
    }
    //---------27th aug newly added code ends---------
}
