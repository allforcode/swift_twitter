//
//  UserCell.swift
//  twitter
//
//  Created by Paul Dong on 16/12/17.
//  Copyright © 2017 Paul Dong. All rights reserved.
//

import LBTAComponents

let twitterBlue = UIColor(r: 61, g: 167, b: 244)

class UserFooter: DatasourceCell {
    let showMeMoreLabel: UILabel = {
        let l = UILabel()
        l.text = "Show me more"
        l.font = UIFont.boldSystemFont(ofSize: 15)
        l.textColor = twitterBlue
        return l
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        addSubview(showMeMoreLabel)
        showMeMoreLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

class UserHeader: DatasourceCell {
    
    let textLabel: UILabel = {
        let l = UILabel()
        l.text = "WHO TO FOLLOW"
        l.font = UIFont.boldSystemFont(ofSize: 14)
        return l
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        addSubview(textLabel)
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        textLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

class UserCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard let user = datasourceItem as? User else { return }
            nameLabel.text = user.name
            usernameLabel.text = user.username
            bioTextView.text = user.bioText
            profileImageView.loadImage(urlString: user.profileImageUrl)
        }
    }
    
    let profileImageView: CachedImageView = {
        let civ = CachedImageView()
        civ.layer.cornerRadius = 5
        civ.clipsToBounds = true
        return civ
    }()
    
    let usernameLabel: UILabel = {
        let l = UILabel()
        l.text = "@username"
        l.font = UIFont.boldSystemFont(ofSize: 16)
        l.textColor = UIColor(r: 130, g: 130, b: 130)
        return l
    }()
    
    let nameLabel: UILabel = {
        let l = UILabel()
        l.text = "Brian Voong"
        l.font = UIFont.boldSystemFont(ofSize: 16)
        return l
    }()
    
    let bioTextView: UITextView = {
        let tv = UITextView()
        tv.text = "iPhone, iPad, iOS Programming Community. Join us to learn Swift, Objective-C and build iOS apps!"
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.backgroundColor = .clear
        return tv
    }()
    
    let followButton: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 5
        b.layer.borderColor = twitterBlue.cgColor
        b.layer.borderWidth = 1
        b.setTitle("Follow", for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        b.setTitleColor(twitterBlue, for: .normal)
        b.setImage(#imageLiteral(resourceName: "follow"), for: .normal)
        b.imageView?.contentMode = .scaleAspectFit
        b.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        return b
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(usernameLabel)
        addSubview(bioTextView)
        addSubview(followButton)
        
        profileImageView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        followButton.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 120, heightConstant: 34)
        
        nameLabel.anchor(profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: followButton.leftAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        usernameLabel.anchor(nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nameLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        bioTextView.anchor(usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: -4, leftConstant: -4, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
    }
}
