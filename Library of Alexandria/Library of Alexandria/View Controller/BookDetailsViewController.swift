//
//  BookDetailsViewController.swift
//  Library of Alexandria
//
//  Created by Jenna on 5/4/18.
//  Copyright © 2018 Hsin-Ping Lin. All rights reserved.
//

import UIKit
import CoreData

class BookDetailsViewController: UIViewController {
    //Attributes
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var isbnLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var editionLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    var currentBook: Book?
    var currentISBN: String?
    private var managedObjectContext: NSManagedObjectContext?
    
    private let SECTION_BOOKS = 0
    private let SECTION_COUNT = 1
    
    required init(coder aDecoder: NSCoder) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = (appDelegate?.persistentContainer.viewContext)!
        super.init(coder: aDecoder)!
    }
    
    //Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Book")
        let predicate = NSPredicate(format: "isbn == %@", currentISBN!)
        fetchRequest.predicate = predicate
        
        do {
            let books = try managedObjectContext?.fetch(fetchRequest) as! [Book]
            currentBook = books.first!
            
            /*
             nameLabel.text = currentBook?.name ?? ""
             
             is same as
             
             if currentBook?.isbn == nil {
             isbnLabel.text = ""
             } else {
             isbnLabel.text = currentBook?.isbn
             }
             */
            
            //nameLabel is either currentBook?.name value or "" empty
            nameLabel.text = currentBook?.name ?? ""
            isbnLabel.text = "ISBN: \(String(describing: currentBook?.isbn ?? ""))"
            authorLabel.text = "Author: \(String(describing: currentBook?.author ?? ""))"
            publisherLabel.text = "Publisher: \(String(describing: currentBook?.publisher ?? ""))"
            editionLabel.text = "Edition: \(String(describing: currentBook?.edition ?? ""))"
            yearLabel.text = "Year: \(String(describing: currentBook?.year ?? 0))"
            genreLabel.text = "Genre: \(String(describing: currentBook?.genre ?? ""))"
            descLabel.text = "\(String(describing: currentBook?.desc ?? ""))"
        }
        catch {
            fatalError("Failed to fetch books: \(error)")
        }
    }
    
    func saveData() {
        do {
            try managedObjectContext?.save()
        }
        catch let error {
            print("Could not save Core Data: \(error)")
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editSegue" {
            let addBookViewController: AddBookViewController = segue.destination as! AddBookViewController
            addBookViewController.currentBook = currentBook
        }
    }
}
