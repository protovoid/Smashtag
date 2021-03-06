//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Chad on 2/26/17.
//  Copyright © 2017 Chad Williams. All rights reserved.
//

import UIKit
import Twitter


class TweetTableViewCell: UITableViewCell
{
  
  @IBOutlet weak var tweetScreenNameLabel: UILabel!
  

  @IBOutlet weak var tweetTextLabel: UILabel!


  @IBOutlet weak var tweetCreatedLabel: UILabel!


  @IBOutlet weak var tweetProfileImageView: UIImageView!

  var tweet: Twitter.Tweet? {
    didSet {
      updateUI()
    }
  }
  
  fileprivate func updateUI() {
    // reset any existing tweet information
    tweetTextLabel?.attributedText = nil
    tweetScreenNameLabel?.text = nil
    tweetProfileImageView?.image = nil
    tweetCreatedLabel?.text = nil
    
    // load new information from our tweet (if any)
    if let tweet = self.tweet {
      tweetTextLabel?.text = tweet.text
      if tweetTextLabel?.text != nil {
        for _ in tweet.media {
          tweetTextLabel.text! += " 📷"
        }
      }
      
      tweetScreenNameLabel?.text = "\(tweet.user)" // tweet.user.description
      
      if let profileImageURL = tweet.user.profileImageURL {
        if let imageData = NSData(contentsOf: profileImageURL) {
          tweetProfileImageView?.image = UIImage(data: imageData as Data)
        } // blocks main thread! fix with async 
        
      }
    }
    
    let formatter = DateFormatter()
    
    if NSDate().timeIntervalSince((tweet?.created)!) > 24*60*60 {
      formatter.dateStyle = DateFormatter.Style.short
    } else {
      formatter.timeStyle = DateFormatter.Style.short
    }
    tweetCreatedLabel?.text = formatter.string(from: (tweet?.created)!)
  }




}
