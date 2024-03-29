//
//  TableViewController.swift
//  ToDoList
//
//  Created by Sergey on 28/08/2019.
//  Copyright © 2019 Sergey. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBAction func pushEditAction(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        //for animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
            self.tableView.reloadData()
        }
 
 }
    
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Create new item", message: "Message", preferredStyle: .alert)
        
        alertController.addTextField{ (textField) in
            textField.placeholder = "New item name"
        }
        
        let alertAction1 = UIAlertAction(title: "Cancel", style: .default){
            (alert) in
        }
        let alertAction2 = UIAlertAction(title: "Create", style: .cancel){
            (alert) in
            //add new note
            let newItem = alertController.textFields![0].text
            if newItem != ""{
                addTask(name: newItem!)
                self.tableView.reloadData()
            }
        }
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        //table footer without line
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        //change footer background color
        tableView.backgroundColor = UIColor.groupTableViewBackground
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // Configure the cell...
        let currentItem = list[indexPath.row]
        cell.textLabel?.text = currentItem["Name"] as? String
        
        if (currentItem["isCompleted"] as? Bool) == true{
            cell.imageView?.image = UIImage(named: "check")
        }
        else{
            cell.imageView?.image = UIImage(named: "cross")
        }

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if changeState(at: indexPath.row){
            tableView.cellForRow(at: indexPath)?.imageView?.image
            = UIImage(named: "check")
        } else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "cross")
        }
        
        tableView.reloadData()
    }
    //next following 2 methods asks for delete in edit mode
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return tableView.isEditing ? .none : .delete
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        tableView.reloadData()
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
