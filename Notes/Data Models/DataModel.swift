//
//  DataModel.swift
//  Notes
//
//  Created by anita on 16.03.2022.
//

import UIKit

class DataModel {
    var notes = [NoteItem]()
     
    //MARK: - Save file path

    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Notes.plist")
    }


    // MARK: - Save data to a file

    func saveNotes() {
       
       let encoder = PropertyListEncoder()
       do {
          
           let data = try encoder.encode(notes)
           try data.write(
               to: dataFilePath(),
               options: Data.WritingOptions.atomic)
       } catch {
           print("Error encoding item array: \(error.localizedDescription)")
       }
       
    }
       
       //MARK: - Read data from a file
       
       func loadNotes() {
           
           let path = dataFilePath()
           if let data = try? Data(contentsOf: path) {
               let decoder = PropertyListDecoder()
               do {
                   notes = try decoder.decode([NoteItem].self, from: data)
               } catch {
                   print("Error decoding item array: \(error.localizedDescription)")
               }
           }
       }
    init() {
        loadNotes()
    }
}
