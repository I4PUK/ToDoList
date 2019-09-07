//
//  ToDoListModel.swift
//  ToDoList
//
//  Created by Sergey on 28/08/2019.
//  Copyright © 2019 Sergey. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

var list: [[String: Any]]{
    set{
        //save tasks state
        UserDefaults.standard.set(newValue, forKey: "listDataKey")
        UserDefaults.standard.synchronize()
    }
    get{
        //load tasks state
        if let array = UserDefaults.standard.array(forKey: "listDataKey") as? [[String:Any]]{
            return array
        }
        else{
            return []
        }
    }
}

func addTask(name: String, isCompleted: Bool = false){
    list.append(["Name": name, "isCompleted": false])
    setBadgeCount()
}

func removeItem(at index:Int){
    list.remove(at: index)
    setBadgeCount()
}

func moveItem(fromIndex: Int, toIndex: Int){
    
    let from = list[fromIndex]
    list.remove(at: fromIndex)
    list.insert(from, at: toIndex)
}

func changeState(at item: Int) -> Bool{
    list[item]["isCompleted"] = !(list[item]["isCompleted"] as! Bool)
    setBadgeCount()

    return list[item]["isCompleted"] as! Bool
}

func requestForNotification(){
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) {
        (isEnabled, error) in
        if isEnabled{
            
        }
        else{
            
        }
    }
    
}

func setBadgeCount(){
    var uncompletedTasks = 0
    for task in list{
        if (task["isCompleted"] as? Bool) == false{
            uncompletedTasks = uncompletedTasks + 1;
        }
    }
    //shows uncompleted tasks in badge
    UIApplication.shared.applicationIconBadgeNumber = uncompletedTasks
}


