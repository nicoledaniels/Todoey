//
//  ViewController.swift
//  Todoey
//
//  Created by Nicole Letha Daniels on 7/14/18.
//  Copyright © 2018 Nicole Daniels. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.object(forKey: "ToDoListArray") as? NSData {
            itemArray = (NSKeyedUnarchiver.unarchiveObject(with: items as Data) as? [Item])!
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.accessoryType = item.done ? .checkmark : .none
        cell.textLabel?.text = itemArray[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: self.itemArray)
        self.defaults.set(encodedData, forKey: "ToDoListArray")
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen after add item button is clicked
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: self.itemArray)
            self.defaults.set(encodedData, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
            alert.addTextField{ (alertTextField) in
                alertTextField.placeholder = "Create New Item"
                textField = alertTextField
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    
    
    


}

