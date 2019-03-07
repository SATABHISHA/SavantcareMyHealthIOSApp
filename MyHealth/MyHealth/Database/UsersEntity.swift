//
//  UsersEntity.swift
//  MyHealth
//
//  Created by Satabhisha on 21/08/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import Foundation
import SQLite3
import SQLite

class UsersEntity{
    static let shared = UsersEntity()
    
    private let tblUsers = Table("tblUsers")
    
    private let id = Expression<Int64>("id")
    private let clarify = Expression<String>("clarify")
    private let currentDate = Expression<String>("currentDate")
    private let feelingType = Expression<String>("feelingType")
    private let image = Expression<String>("image")
    private let moment = Expression<String>("moment")
    private let moodName = Expression<String>("moodName")
    private let moodRating = Expression<String>("moodRating")
    private let recentExp = Expression<String>("recentExp")
    
    private init(){
        //Create table if not exists
        do {
            if let connection = Database.shared.connection {
                try connection.run(tblUsers.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
                    table.column(self.id, primaryKey: true)
                    table.column(self.clarify)
                    table.column(self.currentDate)
                    table.column(self.feelingType)
                    table.column(self.image)
                    table.column(self.moment)
                    table.column(self.moodName)
                    table.column(self.moodRating)
                    table.column(self.recentExp)
                }))
                print("Create table tblDepartment successfully")
            } else {
                print("Create table tblDepartment failed.")
            }
        } catch {
            let nserror = error as NSError
            print("Create table tblDepartment failed. Error is: \(nserror), \(nserror.userInfo)")
        }
    }
    
    //Insert a record to usersTable
    func insert(clarify: String, currentDate: String, feelingType: String, image: String, moment: String, moodName: String, moodRating:String, recentExp:String  ) -> Int64? {
        do {
            let insert = tblUsers.insert(self.clarify <- clarify,
                                              self.currentDate <- currentDate,
                                              self.feelingType <- feelingType,
                                              self.image <- image,
                                              self.moment <- moment,
                                              self.moodName <- moodName,
                                              self.moodRating <- moodRating,
                                              self.recentExp <- recentExp)
            let insertedId = try Database.shared.connection!.run(insert)
            return insertedId
        } catch {
            let nserror = error as NSError
            print("Cannot insert new Department. Error is: \(nserror), \(nserror.userInfo)")
            return nil
        }
        
    }
    //How to query(find) all records in tblUsers ?
    func queryAll() -> AnySequence<Row>? {
        do {
            return try Database.shared.connection?.prepare(self.tblUsers)
        } catch {
            let nserror = error as NSError
            print("Cannot query(list) all tblDepartment. Error is: \(nserror), \(nserror.userInfo)")
            return nil
        }
    }
    }


