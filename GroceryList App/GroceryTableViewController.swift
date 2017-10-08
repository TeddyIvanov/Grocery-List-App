//
//  GroceryTableViewController.swift
//  GroceryList App
//
//  Created by Teodor Ivanov on 10/5/17.
//  Copyright © 2017 Teodor Ivanov. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class GroceryTableViewController: UITableViewController {
    
    var shoppingList = [GroceryListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest: NSFetchRequest<GroceryListItem> = GroceryListItem.fetchRequest()
        do{
            self.shoppingList = try PersistentService.context.fetch(fetchRequest)
            self.tableView.reloadData()
        }catch{
            print("Failed To fetch")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryItem", for: indexPath)
        if let shoppingItem = shoppingList[indexPath.row].grocery{
            cell.textLabel?.text = shoppingItem
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            PersistentService.context.delete(shoppingList[indexPath.row])
            self.shoppingList.remove(at: indexPath.row)
            PersistentService.saveContext()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addToGroceryListWhenTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add To Grocery List", message: nil, preferredStyle: .alert)
        
        alert.addTextField{
            (textField) in
            textField.placeholder? = "Name of Grocery Item."
        }
        let action = UIAlertAction.init(title: "Add", style: .default) { (_) in
            if let groceryItem = alert.textFields?.first?.text{
                let groceryEntity = GroceryListItem(context: PersistentService.context)
                groceryEntity.grocery = groceryItem
                PersistentService.saveContext()
                self.shoppingList.append(groceryEntity)
                self.tableView.reloadData()
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
