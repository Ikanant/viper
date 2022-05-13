//
//  View.swift
//  viper
//
//  Created by Jonathan Hernandez on 5/11/22.
//

import Foundation
import UIKit // Will allow us to use UiView

// View will take care of handling the User Interface
// VIPER: You can have a ViewController as a part of the architecture
// I will create a protocol to outline what this view should have on it.
// The important thing is that the VIEW should have a reference to the PRESENTER

protocol AnyView {
    // Should have a reference to my Presenter
    var presenter: AnyPresenter? { get set }
    
    var users: [User] { get set }
    
    func update(with users: [User]) // Will show the list of Users retrieved from the API
    func update(with error: String) // Will show whatever error we will want to show in the ViewController
}

// UITableViewDelegate: Methods for managing selections, configuring section headers and footers, deleting and reordering cells, and performing other actions in a table view.
// UITableViewDataSource: he methods that an object adopts to manage data and provide cells for a table view.
class UserViewController: UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource {
    var presenter: AnyPresenter?
    
    // Will create the table view using the anonymous closure pattern - Nothing to do with VIPER
    // Crating a very basic vanilla TableView
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true // Will default to hidden since we might want to NOT show the table if an error occures
        return table
    }()
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func update(with users: [User]) {
        print ("GOT RESULTS")
        
        // This is not enough
        // self.users = users
        
        // We want to do the change on the MAIN THREAD
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    func update(with error: String) {
        // Print the error if it got returned
        print(error)
    }
    
    // Table - Conform to the protocols I referenced for the controller (UITableViewDataSource)
    // We need this function to return the NUMBER OF ROWS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    // Properly DEQUE the cell... I am not 100% what dequeue does... so:
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
}
