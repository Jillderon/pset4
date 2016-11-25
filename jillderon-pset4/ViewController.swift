//
//  ViewController.swift
//  jillderon-pset4
//
//  Created by Jill de Ron on 20-11-16.
//  Copyright © 2016 Jill de Ron. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var textfieldNewToDo: UITextField!
    
    private let database = DatabaseHelper()
    private var todos = [String?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if database == nil {
            print("Error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addNewToDo(_ sender: Any) {
        if textfieldNewToDo.text == "" {
            // alert user!!
        }
        else {
            do {
                try database!.create(todo: textfieldNewToDo.text!)
                try todos = database!.read()
                textfieldNewToDo.text = ""
                self.TableView.reloadData()
            } catch {
                print(error)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        // Fill in the cell.
        cell.toDoLabel.text = todos[indexPath.row]
        return cell
    }
    
    // delete todo. Cited from user3182143 (http://stackoverflow.com/questions/29294099/delete-a-row-in-table-view-in-swift)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let name = todos[indexPath.row]
            do {
                try database!.remove(withName: name!)
                todos.remove(at: indexPath.row)

            } catch {
                print(error)
            }
            self.TableView.reloadData()
        }
    }

}

