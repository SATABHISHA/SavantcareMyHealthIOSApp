//
//  AppointmentNavigationViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 16/03/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit

class AppointmentNavigationViewController: UIViewController {

    
   
    @IBOutlet weak var appointment_menu_home_item: UIView!
    
    @IBOutlet weak var appointment_navigation_profile_image: UIImageView!
    
    @IBOutlet weak var appointment_navigation_profile_name: UILabel!
    
    @IBOutlet weak var appointment_navigation_mobilenumber: UILabel!
    
    @IBOutlet weak var appointment_navigation_email: UILabel!
    
    //----------these are the function which would work on tapping the view------------------
    @objc func tapFunction(sender:UITapGestureRecognizer){
        print("tapped successfully")
        self.performSegue(withIdentifier: "home", sender: self)
    }
    //----------function which would work on tapping the view code ends------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
    /*    //-----these code will work on tapping the view(appointment_menu_home_item)--------
        let tap = UITapGestureRecognizer(target: self, action: #selector(ScreeningQuestionAnswerController.tapFunction))
        appointment_menu_home_item.isUserInteractionEnabled = true
        appointment_menu_home_item.addGestureRecognizer(tap)
       //-----these code will work on tapping the view(appointment_menu_home_item) code ends--------*/
        
       
        //-----setting the image(fetched from api) in the imageView---------
        /*let url=URL(string: UserSingletonModel.sharedInstance.userImageUrl!)!
         imageView.af_setImage(withURL: url)*/
        appointment_navigation_profile_image.image=#imageLiteral(resourceName: "profile")
        if UserSingletonModel.sharedInstance.userImageUrl! != "" && UserSingletonModel.sharedInstance.gender! == "Male" {
            let url=URL(string: UserSingletonModel.sharedInstance.userImageUrl!)!
            appointment_navigation_profile_image.af_setImage(withURL: url)
        }else if UserSingletonModel.sharedInstance.userImageUrl! != "" && UserSingletonModel.sharedInstance.gender! == "Female" {
            let url=URL(string: UserSingletonModel.sharedInstance.userImageUrl!)!
            appointment_navigation_profile_image.af_setImage(withURL: url)
        }else if UserSingletonModel.sharedInstance.userImageUrl! == "" && UserSingletonModel.sharedInstance.gender! == "Male"{
            //var image=UIImageView(image: #imageLiteral(resourceName: "male"))
            appointment_navigation_profile_image.image=#imageLiteral(resourceName: "male")
        }else if UserSingletonModel.sharedInstance.userImageUrl! == "" && UserSingletonModel.sharedInstance.gender! == "Female"{
            appointment_navigation_profile_image.image=#imageLiteral(resourceName: "female")
        }else{
            appointment_navigation_profile_image.image=#imageLiteral(resourceName: "profile")
        }
        //-----setting the image(fetched from api) in the imageView code ends---------
        
        //----setting the name(fetched from api) in the label--------
        appointment_navigation_profile_name.text=UserSingletonModel.sharedInstance.userFullName
        appointment_navigation_mobilenumber.text=UserSingletonModel.sharedInstance.mobilenumber
        appointment_navigation_email.text=UserSingletonModel.sharedInstance.emailAddress
         //-----calling function to navigate to corresponding controller on clicking the menu item----------
            onMenuClick()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //------------function to navigate to another controller on menu item click-----------
    func onMenuClick(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(AppointmentNavigationViewController.tapFunction))
        appointment_menu_home_item.isUserInteractionEnabled = true
        appointment_menu_home_item.addGestureRecognizer(tap)
    }
    //------------function to navigate to another controller on menu item click code ends-----------

}
