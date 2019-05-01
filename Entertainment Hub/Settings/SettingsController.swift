//
//  SettingsController.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 2/23/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
import SafariServices

class SettingsController: UITableViewController {
    
    let cellId = "cellId"
    
    let items = [
        ["Wi-Fi Only", "Streaming & Downloading", "Auto Play"],
        [ "Parental Controls", "Registered Devices", "Notifications"],
        ["My Account", "Contact Us", "Help", "About & Legal"]
    ]
    
    @objc func switchIsChanged(mySwitch: UISwitch) {
        if mySwitch.isOn {
            let alert = UIAlertController(title: "Notifications Enabled", message: "You will receive updates for your favorite titles", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
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
        
        /* Wifi and Notification switch*/
        if (indexPath.section == 0 && indexPath.item == 0) ||  (indexPath.section == 1 && indexPath.item == 2) {
            let customSwitch = UISwitch(frame: .zero)
            customSwitch.onTintColor = UIColor.App.orange
            cell.addSubview(customSwitch)
            cell.accessoryView = customSwitch
            
            if (indexPath.item == 2) {
                print("as")
                customSwitch.addTarget(self, action: #selector(switchIsChanged), for: .valueChanged)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /* Will work on a Real Device */
        if indexPath.section == 2 && indexPath.row == 1 {
            sendEmail()
        }
        
        if (indexPath.section == 2 && indexPath.row == 3) {
            let svc = SFSafariViewController(url: URL(string:"https://api.guidebox.com/terms")!)
            self.present(svc, animated: true, completion: nil)
        }
    }
}

extension SettingsController: MFMailComposeViewControllerDelegate {
    fileprivate func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["you@yoursite.com"])
            mail.setMessageBody("<p>Report Bug</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            print("failed")
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}


