//
//  MoodAddDetailsViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 14/08/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit
import CoreData

class MoodAddDetailsViewController: UIViewController {

    @IBOutlet weak var labelSave: UILabel!
    @objc func tapFunction_ViewSave(sender:UITapGestureRecognizer){
        print("tapped")
        
        //Storing core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        newUser.setValue("testClarify", forKey: "clarify")
        newUser.setValue("21-08-2018", forKey: "currentDate")
        newUser.setValue("positive", forKey: "feelingType")
        newUser.setValue(2, forKey: "id")
//        newUser.setValue("", forKey: "image")
        newUser.setValue("test moment", forKey: "moment")
        newUser.setValue("Cheerful", forKey: "moodName")
        newUser.setValue("15", forKey: "moodRating")
        newUser.setValue("test exp", forKey: "recentExp")
        do{
            try context.save()
            print("SAVED")
        }catch{
            //PROCESS ERROR
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapClose = UITapGestureRecognizer(target: self,action: #selector(tapFunction_ViewSave))
        labelSave.isUserInteractionEnabled = true
        labelSave.addGestureRecognizer(tapClose)
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(request)
            if results.count > 0
            {
                for result in results as! [NSManagedObject]
                {
                    if let feelingType = result.value(forKey: "feelingType") as? String{
                        print(feelingType)
                    }
                    print("All results: ",result)
                }
            }
            
        }
        catch{
            //Process Error
        }
    }
    
    func autoincrement(){
        
      /*  let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
         Sort Descriptor
        var idDescriptor: NSSortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        fetchRequest.sortDescriptors = [idDescriptor]  Note this is a array, you can put multiple sort conditions if you want
        
         Set limit
        fetchRequest.fetchLimit = 1
        
        var newId = 0;  Default to 0, so that you can check if do catch block went wrong later
        
        do {
            let results = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            
            Compute the id
            if(results.count == 1) {
                newId = results[0].id + 1
            }
             slightly odd notation here, .id can be used if you use custom model. or you can use .valueForKey("id")
            else{
              newId = 1
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }*/

    }
}
