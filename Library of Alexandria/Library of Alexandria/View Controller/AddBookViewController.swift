//
//  ViewAddBookController.swift
//  Library of Alexandria
//
//  Created by Jenna on 10/3/18.
//  Copyright © 2018 Hsin-Ping Lin. All rights reserved.
//

import UIKit
import CoreData

class AddBookViewController: UIViewController {

    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputISBN: UITextField!
    @IBOutlet weak var inputAuthor: UITextField!
    @IBOutlet weak var inputPublisher: UITextField!
    @IBOutlet weak var inputEdition: UITextField!
    @IBOutlet weak var inputYear: UITextField!
    @IBOutlet weak var inputGenre: UITextField!
    @IBOutlet weak var inputDesc: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var updateBtn: UIButton!
    var bookList: [Book] = []
    var filteredList = [Book]()
    var currentBook: Book?
    var currentISBN: String?
    
    

    private var managedObjectContext: NSManagedObjectContext?
    
    required init(coder aDecoder: NSCoder) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = (appDelegate?.persistentContainer.viewContext)!
        super.init(coder: aDecoder)!
    }
    
    @IBAction func createBook(_ sender: Any) {
        if inputName.text != "" && inputISBN.text != ""
        {
            
            //managedObjectContext
            // display message for book
            let name = inputName.text
            let isbn = inputISBN.text
            let author = inputAuthor.text
            let publisher = inputPublisher.text
            let edition = inputEdition.text
            let year = Int64(inputYear.text!)
            let genre = inputGenre.text
            let desc = inputDesc.text
            
            let book = NSEntityDescription.insertNewObject(forEntityName: "Book", into: managedObjectContext!) as! Book
            
            book.name = name
            book.isbn = isbn
            book.author = author ?? ""
            book.publisher = publisher ?? ""
            book.edition = edition ?? ""
            book.year = year ?? 0
            book.genre = genre ?? ""
            book.desc = desc ?? ""
            
            bookList.append(book)
            
            do {
                try managedObjectContext?.save()
            }
            catch let error {
                print("Could not save Core Data: \(error)")
            }
             
            //let book = Book(name: name!, isbn: isbn!, author: author!, publisher: publisher!, edition: edition!, year: year!, genre: genre!, desc: desc!)
 
            // messageString = currentBook.saveNotification()
            
            // Setup an alert to show sucessful save details about the Book
            // UIAlertController manages an alert instance
            let alertController = UIAlertController(title: "Saved", message: "Book had created.", preferredStyle:UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler:
                nil))
            
            self.present(alertController, animated: true, completion: nil)
            
            
            // To do: After click on save should back to Main Page.
        }else{
            let alertController = UIAlertController(title: "Ooops!", message: "Book name and ISBN cannot be empty.", preferredStyle:UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler:
                nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func updateBook(_ sender: Any) {
        // To do: How to find the index and save the data into same index?
        // Reference:https:\//stackoverflow.com/questions/38458195/delete-and-update-data-in-core-data-in-ios/38459233#38459233
        //let entity = NSEntityDescription, entityForName:@"Book" managedObjectContext:context
        let entityDescription = NSEntityDescription.entity(forEntityName: "Book", in:managedObjectContext!)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Book")
        let predicate = NSPredicate(format: "isbn == %@", currentISBN!)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        fetchRequest.entity = entityDescription
        
        do {
            let book = try managedObjectContext?.fetch(fetchRequest) as! [Book]
            
            let name = inputName.text
            let isbn = inputISBN.text
            let author = inputAuthor.text
            let publisher = inputPublisher.text
            let edition = inputEdition.text
            let year = Int64(inputYear.text!)
            let genre = inputGenre.text
            let desc = inputDesc.text


            book[0].name = name
            book[0].isbn = isbn
            book[0].author = author
            book[0].publisher = publisher
            book[0].edition = edition
            book[0].year = year!
            book[0].genre = genre
            book[0].desc = desc

            do {
                try managedObjectContext?.save()
            }
            catch let error {
                print("Could not save Core Data: \(error)")
            }
        }
        catch {
            fatalError("Failed to fetch books: \(error)")
        }
        
        let alertController = UIAlertController(title: "Updated", message: "Book had updated.", preferredStyle:UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler:
            nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Book")
        
        // if ISBN is not in DB
        if currentBook == nil {
            // Display Create view
            // hide update btn
            updateBtn.isHidden = true
        } else {
            // Display Update view
            
            let predicate = NSPredicate(format: "currentBook == %@", currentBook!)
            fetchRequest.predicate = predicate
            
            currentISBN = currentBook?.isbn
            
            inputName.text = currentBook?.name
            inputISBN.text = currentBook?.isbn
            inputAuthor.text = currentBook!.author
            inputPublisher.text = currentBook!.publisher
            inputEdition.text = currentBook!.edition
            inputYear.text = String(currentBook!.year)
            inputGenre.text = currentBook!.genre
            inputDesc.text = currentBook!.desc
            
            // hide create btn
            createBtn.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
