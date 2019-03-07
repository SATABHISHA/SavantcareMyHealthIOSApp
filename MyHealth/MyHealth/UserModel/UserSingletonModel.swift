//
//  UserSingletonModel.swift
//  MyHealth
//
//  Created by Satabhisha on 21/02/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import Foundation

class UserSingletonModel: NSObject {
    static let sharedInstance = UserSingletonModel()
    
    //------variables for login-------
    var countrycode:String?
    var firebaseInstanceId:String!
    var mobilenumber:String!
    
    
    //--------variables for users details----------
    var userid:String?
    var userFullName:String?
    var gender:String?
    var emailAddress:String!
    var userImageUrl:String?
    var publicUid:String?
    //var userImage:URL?
    
    //---variables for patient screening----
    var screening_name:String?
    var screening_id:Int?
    var screening_mastertblGroups:String?
    var screening_mastertblQuestions:String?
    var screening_screenId:Int?
    var screening_mastertbl:String?
    var screening_tblName:String?
    var screening_created_at:String?
    var screening_screen_data:String?
    
    //-----variables for question part---------
    var question_selectedQuestion:String?
    var question_questionid:String?
    var question_reportid:Int?=0
    var question_selectedquestion_response:Any?
     var question_check_next:Any?
    
    //------variables for submit screen---------
    var submit_screen_message:Any?="0"
    
   //-----countdown------
    var Login_count:String!
    
    //-----goal-------
    var goalID:Int?
    var goalrating:Int?
    var goalPublicUid:String?
    var goalValueOfTheRating:Int?
    
    //-------variables for Helpdesk------------
    var helpdesk_public_unique_id:String?
    var helpdesk_status:String?
    var helpdesk_statusId:Int?
    var helpdesk_created_at:String?
    var helpdesk_description:String?
    var helpdesk_userId:Int?
    var helpdesk_title:String?
    var helpdesk_comment_count:String!=""
    
}
