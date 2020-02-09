//
//  ViewController.swift
//  LearnCoreDataAgain
//
//  Created by IMCS2 on 2/8/20.
//  Copyright © 2020 Tanishk. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var students = [NSManagedObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
       // saveData(name: "tanishk", age: 23)
        fetchFromCoreData()
       
    }

    func saveData(name: String , age: Int) {
        
       // 1. Refer to persistentContainer
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 2. Create the context
        let context = appDelegate.persistentContainer.viewContext
        
       //  3. Create an entity
        let entity = NSEntityDescription.entity(forEntityName: "Student", in: context)
        let student = NSManagedObject(entity: entity!, insertInto: context)
        
        // 4. Create new record
        student.setValue(name, forKey: "name")
        student.setValue(age, forKey: "age")
        
        // 5. Save the data
        do {
            try context.save()
            print("saved name \(name) and age \(age)")
        } catch {
            print("Failed saving")
        }
        
    }
    
    func fetchFromCoreData() {
        
       // 1. Refer to persistentContainer
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 2. Create the context
        let context = appDelegate.persistentContainer.viewContext
        
        // 3. Prepare the request of type NSFetchRequest for the entity
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Student")
        
        // 4. Fetch the result from context in the form of array of [NSManagedObject] Iterate through an array to get value for the specific key
        
        do {
            students = try context.fetch(fetchRequest)
            for person in students{
                let name = person.value(forKeyPath: "name") as? String
                let age = person.value(forKeyPath: "age") as? Int
                print("this is fetched",name,age)
                
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    

}

