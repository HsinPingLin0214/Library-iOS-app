//
//  SearchTableViewController.swift
//  Library of Alexandria
//
//  Created by Jenna on 5/4/18.
//  Copyright © 2018 Hsin-Ping Lin. All rights reserved.
//

import UIKit
import CoreData

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var searchController:UISearchController!
    
    var bookList: [Book] = []
    var filteredList = [Book]()
    private var managedObjectContext: NSManagedObjectContext?
    
    private let SECTION_BOOKS = 0
    private let SECTION_COUNT = 1
    
    
    required init(coder aDecoder: NSCoder) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = (appDelegate?.persistentContainer.viewContext)!
        super.init(coder: aDecoder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Book")
        do {
            bookList = try managedObjectContext?.fetch(fetchRequest) as! [Book]
            if bookList.count == 0 {
                addBookData()
                // Load newly added data.
                bookList = try managedObjectContext?.fetch(fetchRequest) as! [Book]
            }
        }
        catch {
            fatalError("Failed to fetch books: \(error)")
        }
        
        filteredList = bookList;
        
        let searchController = UISearchController(searchResultsController: nil);
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search book name"
        searchController.searchBar.searchBarStyle = .minimal
        navigationItem.searchController = searchController
        //To do: Show search bar at first
        //tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true

        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func saveData() {
        do {
            try managedObjectContext?.save()
        }
        catch let error {
            print("Could not save Core Data: \(error)")
        }
    }

    func addBookData(){
        var book = NSEntityDescription.insertNewObject(forEntityName: "Book", into: managedObjectContext!) as! Book
        book.name = "The Lovely Bones"
        book.author = "Alice Sebold"
        book.isbn = "0-316-66634-3"
        book.publisher = "Little, Brown"
        book.edition = "45"
        book.year = 2002
        book.genre = "Novel"
        book.desc = "It is the story of a teenage girl who, after being raped and murdered, watches from her personal Heaven as her family and friends struggle to move on with their lives while she comes to terms with her own death."
        
        book = NSEntityDescription.insertNewObject(forEntityName: "Book", into: managedObjectContext!) as! Book
        book.name = "Harry Potter: The Philosopher's Stone"
        book.author = "J.K. Rowling"
        book.isbn = "0-7475-3269-9"
        book.publisher = "Bloomsbury UK"
        book.edition = "332 2014 UK Edition"
        book.year = 1997
        book.genre = "Fantasy"
        book.desc = "The plot follows Harry Potter, a young wizard who discovers his magical heritage as he makes close friends and a few enemies in his first year at the Hogwarts School of Witchcraft and Wizardry."
        
        book = NSEntityDescription.insertNewObject(forEntityName: "Book", into: managedObjectContext!) as! Book
        book.name = "Harry Potter: The Chamber of Secrets"
        book.author = "J.K. Rowling"
        book.isbn = "0-7475-3849-2"
        book.publisher = "Bloomsbury UK"
        book.edition = "360 2014 UK Edition"
        book.year = 1998
        book.genre = "Fantasy"
        book.desc = "The plot follows Harry's second year at Hogwarts School of Witchcraft and Wizardry, during which a series of messages on the walls of the school's corridors warn that the Chamber of Secrets has been opened and that the heir of Slytherin would kill all pupils who do not come from all-magical families."
        
        book = NSEntityDescription.insertNewObject(forEntityName: "Book", into: managedObjectContext!) as! Book
        book.name = "Harry Potter: The Prisoner of Azkaban"
        book.author = "J.K. Rowling"
        book.isbn = "0-7475-4215-5"
        book.publisher = "Bloomsbury (UK)"
        book.edition = "462 (2014 UK Edition)"
        book.year = 1999
        book.genre = "Fantasy"
        book.desc = "The book follows Harry Potter, a young wizard, in his third year at Hogwarts School of Witchcraft and Wizardry. Along with friends Ronald Weasley and Hermione Granger, Harry investigates Sirius Black, an escaped prisoner from Azkaban who they believe is one of Lord Voldemort's old allies."
        
        book = NSEntityDescription.insertNewObject(forEntityName: "Book", into: managedObjectContext!) as! Book
        book.name = "Harry Potter: The Goblet of Fire"
        book.author = "J.K. Rowling"
        book.isbn = "0-7475-4624-X"
        book.publisher = "Bloomsbury UK"
        book.edition = "636 Original UK Edition"
        book.year = 2000
        book.genre = "Fantasy"
        book.desc = "It follows Harry Potter, a wizard in his fourth year at Hogwarts School of Witchcraft and Wizardry and the mystery surrounding the entry of Harry's name into the Triwizard Tournament, in which he is forced to compete."
        
        book = NSEntityDescription.insertNewObject(forEntityName: "Book", into: managedObjectContext!) as! Book
        book.name = "Harry Potter: The Order of the Phoenix"
        book.author = "J.K. Rowling"
        book.isbn = "0-7475-5100-6"
        book.publisher = "Bloomsbury UK"
        book.edition = "766 Original UK Edition"
        book.year = 2003
        book.genre = "Fantasy"
        book.desc = "It follows Harry Potter's struggles through his fifth year at Hogwarts School of Witchcraft and Wizardry, including the surreptitious return of the antagonist Lord Voldemort, O.W.L. exams, and an obstructive Ministry of Magic."
        
        book = NSEntityDescription.insertNewObject(forEntityName: "Book", into: managedObjectContext!) as! Book
        book.name = "Harry Potter: The Half-Blood Prince"
        book.author = "J.K. Rowling"
        book.isbn = "0-7475-8108-8"
        book.publisher = "Bloomsbury UK"
        book.edition = "607 Original UK Edition"
        book.year = 2005
        book.genre = "Fantasy"
        book.desc = "Set during protagonist Harry Potter's sixth year at Hogwarts, the novel explores the past of Harry's nemesis, Lord Voldemort, and Harry's preparations for the final battle against Voldemort alongside his headmaster and mentor Albus Dumbledore."
        
        book = NSEntityDescription.insertNewObject(forEntityName: "Book", into: managedObjectContext!) as! Book
        book.name = "Harry Potter: The Deathly Hallows"
        book.author = "J.K. Rowling"
        book.isbn = "0-545-01022-5"
        book.publisher = "Bloomsbury UK"
        book.edition = "607 UK"
        book.year = 2007
        book.genre = "Fantasy"
        book.desc = "The novel chronicles the events directly following Harry Potter and the Half-Blood Prince, and the final confrontation between the wizards Harry Potter and Lord Voldemort."
        
        do {
            try managedObjectContext?.save()
        }
        catch let error {
            print("Could not save Core Data: \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Search results updating
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.lowercased(), searchText.count > 0 {
            filteredList = bookList.filter({(book: Book) -> Bool in
                return book.name!.lowercased().contains(searchText);
            })
        }
        else {
            filteredList = bookList;
        }
        tableView.reloadData();
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (section == SECTION_COUNT)
        {
            return 1
        }
        return filteredList.count;
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 64.0;//Choose your custom row height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        var cellResuseIdentifier = "BookCell"
        if indexPath.section == SECTION_COUNT {
            cellResuseIdentifier = "TotalCell"
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: cellResuseIdentifier, for: indexPath)
        
        // Configure the cell...
        if indexPath.section == SECTION_BOOKS {
            let bookCell = cell as? BookTableViewCell
            // Fixed: the search result should use filteredList
            bookCell?.nameLabel.text = filteredList[indexPath.row].name
            bookCell?.authorLabel.text = filteredList[indexPath.row].author
        }
        else {
            cell.textLabel?.text = "\(filteredList.count) records"
        }
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "viewBookFromListSegue" {
            let bookDetailsController: BookDetailsViewController = segue.destination as! BookDetailsViewController
            bookDetailsController.currentISBN = filteredList[(tableView.indexPathForSelectedRow?.row)!].isbn
            //To do: Click on filterList's item, next view page's navigation bar will missing
        }
    }

}
