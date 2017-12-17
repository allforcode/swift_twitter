//
//  TweetCell.swift
//  twitter
//
//  Created by Paul Dong on 17/12/17.
//  Copyright © 2017 Paul Dong. All rights reserved.
//

import LBTAComponents

class TweetCell: DatasourceCell {
    var user: User?
    
    override var datasourceItem: Any? {
        didSet {
            guard let tweet = datasourceItem as? Tweet else { return }
            user = tweet.user
            profileImageView.loadImage(urlString: tweet.user.profileImageUrl)
            
            let attributedText = NSMutableAttributedString(string: tweet.user.name, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)])
            
            attributedText.append(NSAttributedString(string: " \(tweet.user.username)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.gray]))
            
            attributedText.appendNewLine()
            
            //paragraph style
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            let range = NSMakeRange(0, attributedText.string.count)
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
            
            attributedText.append(NSAttributedString(string: tweet.messageText, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))

            messageTextView.attributedText = attributedText
        }
    }
    
    let profileImageView: CachedImageView = {
        let civ = CachedImageView()
        civ.layer.cornerRadius = 5
        civ.clipsToBounds = true
        return civ
    }()
    
    let messageTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.backgroundColor = .clear
        return tv
    }()
    
    let directMessageButton: UIButton = {
        return TweetCell.createButton(image: #imageLiteral(resourceName: "send_message"))
    }()
    
    let likeButton: UIButton = {
        return TweetCell.createButton(image: #imageLiteral(resourceName: "like"))
    }()
    
    let replyButton: UIButton = {
        return TweetCell.createButton(image: #imageLiteral(resourceName: "reply"))
    }()
    
    let retweetButton: UIButton = {
        return TweetCell.createButton(image: #imageLiteral(resourceName: "retweet"))
    }()
    
    static func createButton(image: UIImage) -> UIButton {
        let b = UIButton(type: .system)
        b.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        return b
    }
    
    override func setupViews() {
        super.setupViews()
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        backgroundColor = .white
        
        addSubview(profileImageView)
        addSubview(messageTextView)
        addSubview(replyButton)
        addSubview(retweetButton)
        
        profileImageView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)

        messageTextView.anchor(topAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 4, leftConstant: 4, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        setupBottomButtons()
    }
    
    private func setupBottomButtons() {
//        var views: [UIView] = []
//
//        let replyButtonContainerView = UIView()
//        replyButtonContainerView.backgroundColor = .red
//        views.append(replyButtonContainerView)
//
//        let retweetButtonContainerView = UIView()
//        retweetButtonContainerView.backgroundColor = .blue
//        views.append(retweetButtonContainerView)
//
//        let likeButtonContainerView = UIView()
//        likeButtonContainerView.backgroundColor = .green
//        views.append(likeButtonContainerView)
//
//        let directMessageButtonContainerView = UIView()
//        directMessageButtonContainerView.backgroundColor = .purple
//        views.append(directMessageButtonContainerView)
        
        let buttonStackView = UIStackView(arrangedSubviews: [replyButton, retweetButton, likeButton, directMessageButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        
        addSubview(buttonStackView)
        buttonStackView.anchor(nil, left: messageTextView.leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 20)
    }
}


