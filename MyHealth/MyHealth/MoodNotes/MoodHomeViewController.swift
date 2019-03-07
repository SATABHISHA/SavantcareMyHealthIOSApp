//
//  MoodHomeViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 25/07/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit

class MoodHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var btn_menu: UIBarButtonItem!
    @IBAction func btn_add(_ sender: Any) {
        self.performSegue(withIdentifier: "moodtrack", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         sideMenus()  //------calling function for navigation
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MoodTableViewCell
        //        cell.layer.cornerRadius = 10
        //        cell.layer.borderWidth=1
        
        //        cell.layer.borderColor=UIColor.blue.cgColor
        
        //        cell.view_linedraw.
       /* cell.view.layer.cornerRadius = 10
        var dict = arrRes[indexPath.row]
        cell.labelMedicineName.text = dict["name"] as? String
        cell.labelQuantityRefilSupply.text = "\(dict["quantity"] as! String) |  Refill: \(dict["numberOfRefills"] as! String)  |  Days of Supply: \(dict["daysSupply"] as? String ?? "")"
        cell.labelPatient.text = dict["noteToPharmacist"] as? String ?? ""
        cell.labelPatient.text = dict["directionToPatient"] as? String ?? ""
        cell.labelPrescribedBy.text = "\(dict["userFullName"] as? String ?? "")  \(dict["created_at"] as? String ?? "")"*/
        return cell
        
    }
    //==========tableview code ends===============
    
}
