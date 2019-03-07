//
//  HelpdeskAddCommentsPopupViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 16/05/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toaster

class HelpdeskAddCommentsPopupViewController: UIViewController {

    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var txt_comment: UITextView!
    var currentdate:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.black.withAlphaComponent(0.8)
        view_popup.layer.cornerRadius=20
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
    
    
    //---------function to get current date and time-------------
    func currentDate(){
        var todaysDate:Date = Date()
        var dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //var DateInFormat:String = dateFormatter.string(from: todaysDate)
        currentdate=dateFormatter.string(from: todaysDate)
        print(currentdate)
    }
    //---------function to get current date and time code ends-------------
    
    
    //---------function to save comment code starts------------
    public func save_comment(){
        currentDate()
        
        //----------code to get timezone in IST/PDT/PST etc format starts------
        let zoneName = NSTimeZone.abbreviationDictionary
        // Iterate through the dictionary
        let currentAutoUpdateTZ = TimeZone.current.identifier
        var finalTimeZoneName:String!
        for (key,value) in zoneName {
            if(value == currentAutoUpdateTZ){
                finalTimeZoneName = key
            }
        }
        print("\(finalTimeZoneName!)")
        //-------code to get timezone in IST/PDT/PST etc format ends------
        
       /* let apiurl="https://www.savantcare.com/v2/screening/api/public/index.php/api/postComment/\(UserSingletonModel.sharedInstance.publicUid!)"
        Alamofire.request(apiurl, method: .post, parameters: ["comment":txt_comment.text,"ticketId":UserSingletonModel.sharedInstance.helpdesk_public_unique_id!,"created_at":currentdate,"createdTimeZone":finalTimeZoneName,"updated_at":currentdate,"updateTimeZone":finalTimeZoneName],encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success:
                let swiftyJsonVar=JSON(response.result.value!)
                print(swiftyJsonVar)
                break
                
            case .failure(let error):
                print(error)
            }
        }*/
        let apiurl="https://www.savantcare.com/v3/api/helpdesk/public/index.php/api/postNewComment"
        let data: [String: Any] = [
            "comment" : txt_comment.text,
            "createdTimeZone" : finalTimeZoneName!,
            "created_at" : currentdate,
            "isPublish":1,
            "publicUniqueId":UserSingletonModel.sharedInstance.helpdesk_public_unique_id!,
            "publicUniqueUserId":UserSingletonModel.sharedInstance.publicUid!,
            "sourceId":14
        ]
        Alamofire.request(apiurl, method: .post, parameters: data,encoding: JSONEncoding.default, headers: nil).responseString{
            response in
            switch response.result{
            case .success:
                let swiftyJsonVar=JSON(response.result.value!)
                print(swiftyJsonVar)
                var count = HelpdeskDescriptionViewController()
                count.get_Helpdesk_comment_count()
                Toast(text: "Submitted", duration: Delay.short).show()
                break
                
            case .failure(let error):
                Toast(text: "Internal Error", duration: Delay.short).show()
                print(error)
            }
        }
        
    }
    //---------function to save comment code ends-------------
    @IBAction func btn_post_comment(_ sender: Any) {
        if(txt_comment.text == ""){
            Toast(text: "Field can't be left blank", duration: Delay.short).show()
        } else {
        save_comment()
        self.performSegue(withIdentifier: "comment", sender: self)
        self.view.removeFromSuperview()
        }
    }
    
    @IBAction func btn_cancel(_ sender: Any) {
         self.view.removeFromSuperview()
    }
}
