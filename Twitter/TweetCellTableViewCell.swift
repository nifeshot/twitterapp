//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Adam on 2/13/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    
    
    @IBAction func retweetTweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(_isRetweeted: true)
        }, failure: { (Error) in
            print("Error for retweeting")
        })
      
    }
    
    func setRetweeted(_isRetweeted:Bool) {
        if(_isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    
    }
    @IBOutlet weak var likeButton: UIButton!
    
    
    @IBAction func likeTweet(_ sender: Any) {
        let tobeFavorited = !favorited
        if (tobeFavorited) {
            TwitterAPICaller.client?.likeTweet(tweetId: tweetId, success:{ self.setFavorite(true)}, failure: { (Error) in
                print("Favorite did not succed")
            })
        } else {
            TwitterAPICaller.client?.unlikeTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                print("Unfavorite did not succed")
            })
        }
        
    }
    
          
func setFavorite(_ isFavorited:Bool){
    favorited = isFavorited
        if (favorited) {
        likeButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
    }
    else {
        likeButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
              }
}
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
