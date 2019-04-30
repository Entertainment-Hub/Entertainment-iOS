//
//  SettingsController.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 2/23/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class SettingsController: UITableViewController {
    
    let cellId = "cellId"
    
    let items = [
        ["Streaming & Downloading", "Auto Play"],
        [ "Parental Controls", "Registered Devices", "Notifications"],
        ["My Account", "Contact Us", "Help", "About & Legal"]
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        tableView.backgroundColor = UIColor.App.gray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()

    }
    
    fileprivate func setupNavBar() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title  = "Settings"
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = " "
        label.backgroundColor = UIColor.clear
        return label
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = items[indexPath.section][indexPath.item]
        return cell
    }
    
}



