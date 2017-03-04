//
//  TweetTableViewController.swift
//  Smashtag
//
//  Created by Chad on 2/26/17.
//  Copyright © 2017 Chad Williams. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewController: UITableViewController, UITextFieldDelegate
{
  
  var tweets = [Array<Twitter.Tweet>]() {
    didSet {
      tableView.reloadData()
    }
  }
  
  var searchText: String? {
    didSet {
      tweets.removeAll()
      searchForTweets()
      title = searchText
    }
  }
  
  fileprivate var twitterRequest: Twitter.Request? {
    if let query = searchText, !query.isEmpty {
      return Twitter.Request(search: query + " -filter:retweets", count: 100)
    }
    return nil
  }
  
  fileprivate var lastTwitterRequest: Twitter.Request?
  
  fileprivate func searchForTweets() {
    if let request = twitterRequest {
      lastTwitterRequest = request
      request.fetchTweets { [weak weakSelf = self] newTweets in
        DispatchQueue.main.async {
          if request == weakSelf?.lastTwitterRequest {
            if !newTweets.isEmpty {
              weakSelf?.tweets.insert(newTweets, at: 0)
            }
          }
        }
      }
    }
  }

    override func viewDidLoad() {
        super.viewDidLoad()
      tableView.estimatedRowHeight = tableView.rowHeight
      tableView.rowHeight = UITableViewAutomaticDimension
      // test searchText = "#stanford"


    }



    // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return tweets.count
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets[section].count
  }
  
  fileprivate struct Storyboard {
    static let TweetCellIdentifier = "Tweet"
  }

  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.TweetCellIdentifier, for: indexPath)
    
    let tweet = tweets[indexPath.section][indexPath.row]
    // cell.textLabel?.text = tweet.text
    // cell.detailTextLabel?.text = tweet.user.name
    
    if let tweetCell = cell as? TweetTableViewCell {
      tweetCell.tweet = tweet
    }
    
    return cell
  }
  
  @IBOutlet weak var searchTextField: UITextField! {
    didSet {
      searchTextField.delegate = self
      searchTextField.text = searchText
    }

  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    searchText = textField.text
    return true
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
