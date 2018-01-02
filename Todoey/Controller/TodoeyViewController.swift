//
//  ViewController.swift
//  Todoey
//
//  Created by Irawan Kuncoro on 12/25/17.
//  Copyright © 2017 Irawan Kuncoro. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemLists = [TodoeyItemLists]()
    let itemListKey = "TodoItemsArrayLists"
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: itemListKey) as? [TodoeyItemLists] {
            itemLists = items
        }
        /*
        let firstItem = TodoeyItemLists()
        firstItem.item = "My first task"
        itemLists.append(firstItem)
        
        
        for index in 0...15 {
        let item = TodoeyItemLists()
        item.item = "Test todo lists \(index)"
        item.done = false
        
        itemLists.append(item)
        }*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark - TableView Datasource Method
    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Create new cell
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "TodoItemCell")
        //Reuse the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        if let item = itemLists[indexPath.row] as? TodoeyItemLists {
            
            //Ternary operator
            // value = condition ? valueIfTrue : valueIfFalse
            
            cell.accessoryType = item.done == true ? .checkmark : .none
            
            /*if item.done == true {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }*/
            
            //cell.textLabel?.text = itemLists.item[indexPath.row]
            cell.textLabel?.text = item.item
            //print("Row = \(indexPath.row), value = \(item.item)")
        }
        
        return cell
    }
    
    
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Return how many cells we want to display
        
        return itemLists.count
    }
    
    //MARK - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        let item = itemLists[indexPath.row]
        
        print("Before Cell \(indexPath.row) clicked and \(item.done)")
        
        item.done = !item.done
        
        print("Cell \(indexPath.row) clicked and \(item.done)")
        
        tableView.cellForRow(at: indexPath)?.accessoryType = item.done == true ? .checkmark : .none
        
        /* if item.done == true {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } */
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var todoTextField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let todoItem = TodoeyItemLists()
            
            todoItem.item = todoTextField.text!
            
            //self.itemArray.append(todoTextField.text!)
            self.itemLists.append(todoItem)
            
            self.defaults.set(self.itemLists, forKey: self.itemListKey)
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            todoTextField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

