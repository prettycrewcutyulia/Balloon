//
//  DataMeneger.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 15.12.2023.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DiabetNoteCoreData")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        })
        return container
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveNote(note: DiabetNoteModel) {
        let diabetNote = DiabetNote(context: persistentContainer.viewContext)
        diabetNote.fill(note: note)
           do {
               try persistentContainer.viewContext.save()
               print("save")
           } catch {
               print("Failed to save movie \(error)")
           }     
       }
    func getAllNotes() -> [DiabetNote] {
            let fetchRequest: NSFetchRequest<DiabetNote> = DiabetNote.fetchRequest()
            
            do {
                return try persistentContainer.viewContext.fetch(fetchRequest)
            } catch {
                return []
            }
            
        }
}

extension DiabetNote {
    func fill(note: DiabetNoteModel) {
        self.id = UUID()
        self.blood = note.Blood
        self.comment = note.Comment
        self.date = note.Date
        self.longInsulin = note.LongInsulin
        self.shortInsulin = note.ShortInsulin
        self.xe = note.XE
    }
}
