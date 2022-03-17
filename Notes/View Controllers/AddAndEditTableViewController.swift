//
//  AddAndEditTableViewController.swift
//  Notes
//
//  Created by anita on 14.03.2022.
//

import UIKit

protocol AddAndEditNoteViewControllerDelegate: AnyObject {
    
    func addAndEditNoteViewControllerDidCancel(_ controller: AddAndEditNoteViewController)
    func addAndEditNoteViewController(_ controller: AddAndEditNoteViewController, didFinishAdding item: NoteItem)
    func addAndEditNoteViewController(_ controller: AddAndEditNoteViewController,didFinishEditing item: NoteItem)
}

class AddAndEditNoteViewController: UIViewController, UITextViewDelegate {
    
    var itemToEdit: NoteItem?
    weak var delegate: AddAndEditNoteViewControllerDelegate?
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit {
            title = "Note"
            textView.text = item.body
            doneBarButton.isEnabled = true
        }
        textView.delegate = self
        doneBarButton.isEnabled = false
    }
    
    //MARK: - Actions
    
    @IBAction func cancel() {
        delegate?.addAndEditNoteViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        
        if let item = itemToEdit {
            item.body = textView.text!
            delegate?.addAndEditNoteViewController(self, didFinishEditing: item)
        } else {
            let item = NoteItem()
            item.body = textView.text!
            delegate?.addAndEditNoteViewController(self, didFinishAdding: item)
        }
    }
    
// MARK: - Text View Delegate
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != nil && textView.text != "" {
            doneBarButton.isEnabled = true
        } else {
            doneBarButton.isEnabled = false
        }
    }
}
