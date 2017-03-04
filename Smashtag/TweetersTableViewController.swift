//
//  TweetersTableViewController.swift
//  Smashtag
//
//  Created by Chad on 3/4/17.
//  Copyright © 2017 Chad Williams. All rights reserved.
//

import UIKit

class TweetersTableViewController: UITableViewController {



  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)


        return cell
    }
 

}
