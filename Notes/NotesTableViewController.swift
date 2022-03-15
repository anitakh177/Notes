//
//  NotesTableViewController.swift
//  Notes
//
//  Created by anita on 14.03.2022.
//

import UIKit

class NotesTableViewController: UITableViewController, AddAndEditNoteViewControllerDelegate {
    
    func addAndEditNoteViewControllerDidCancel(_ controller: AddAndEditNoteViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addAndEditNoteViewController(_ controller: AddAndEditNoteViewController, didFinishAdding item: NoteItem) {
        let newRowIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
   func addAndEditNoteViewController(_ controller: AddAndEditNoteViewController, didFinishEditing item: NoteItem) {
       if let index = items.firstIndex(of: item) {
           let indexPath = IndexPath(row: index, section: 0)
           if let cell = tableView.cellForRow(at: indexPath) {
               let item = items[indexPath.row]
               cell.textLabel?.text = item.body
           }
       }
       navigationController?.popViewController(animated: true)
    }
    
    var items = [NoteItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath) != nil {
            _ = items[indexPath.row]
            performSegue(withIdentifier: "EditItem", sender: indexPath.row)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .fade)
    }
    
    
    // MARK: - Navigation
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! AddAndEditNoteViewController
            controller.delegate = self
        }
       else if segue.identifier == "EditItem" {
           let controller = segue.destination as! AddAndEditNoteViewController
           controller.delegate = self
           let index = sender as! Int
           controller.itemToEdit = items[index]
       }
    }

}
