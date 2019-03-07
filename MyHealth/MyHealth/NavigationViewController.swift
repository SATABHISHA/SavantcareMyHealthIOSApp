//
//  NavigationViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 22/02/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit
import AlamofireImage

class NavigationViewController: UIViewController {

    @IBOutlet weak var view_menu_home_item: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label_menu_home: UILabel!
    
    @IBOutlet weak var label_username: UILabel!
    @IBOutlet weak var label_mobilenumber: UILabel!
    
    @IBOutlet weak var label_emailid: UILabel!
    //----------these are the function which would work on tapping the Home label(Note: This function is not in use anymore)------------------
    @objc func tapFunction(sender:UITapGestureRecognizer){
        performSegue(withIdentifier: "navigatetohome", sender: self)
       
    }
    //----------function which would work on tapping the Home label code ends(Note: This function is not in use anymore)------------------
    //----------these are the function which would work on tapping the view------------------
    @objc func view_tapFunction(sender:UITapGestureRecognizer){
        print("tapped successfully")
        self.performSegue(withIdentifier: "navigatetohome", sender: self)
        
    }
    //----------function which would work on tapping the view code ends------------------
    
    
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
        label_emailid.text=UserSingletonModel.sharedInstance.emailAddress
        
        //-----calling function to navigate to corresponding controller on clicking the menu item----------
        onMenuClick()
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   // navigatetohome
    //self.performSegue(withIdentifier: "home", sender: self)

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
        let tap = UITapGestureRecognizer(target: self, action: #selector(NavigationViewController.view_tapFunction))
        view_menu_home_item.isUserInteractionEnabled = true
        view_menu_home_item.addGestureRecognizer(tap)
    }
 //------------function to navigate to another controller on menu item click code ends-----------
    
    //--------to lock screen rotation, here shouldAutorotate is made false----------------
    override var shouldAutorotate: Bool{
        return false
    }
    //--------autorotation code ends--------------
}
