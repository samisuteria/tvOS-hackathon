//
//  SongListItem.swift
//  App
//
//  Created by Carlos Alban on 4/16/16.
//  Copyright © 2016 CGRekt. All rights reserved.
//

import UIKit

class SongListItem: UITableViewCell {
	
	var songName = String()
	private var avatarIcon: UIImageView
	private var songLabel: UILabel
	
	struct Constants {
		static let avatarIconSize = CGSize(width: 30, height: 30)
		static let padding: CGFloat = 20
	}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		avatarIcon = UIImageView(frame: CGRect.zero)
		songLabel = UILabel(frame: CGRect.zero)
		// TODO: dynamic names
		songName = "CGRekt song"
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = UIColor.orangeColor()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		configureSubviews()
	}
	
	private func configureSubviews() {
		songLabel.text = songName
		// TODO: Add custom font
		songLabel.font = UIFont.systemFontOfSize(20.0)
		songLabel.textAlignment = .Center
		songLabel.numberOfLines = 1
		
		// TODO: Get custom image
		avatarIcon.backgroundColor = UIColor.redColor()
		
		let songLabelMaxWidth = bounds.width - Constants.avatarIconSize.width - (3 * Constants.padding)
		let maxSize = CGSize(width: songLabelMaxWidth, height: CGFloat.max)
		let labelSize = songLabel.sizeThatFits(maxSize)
		
		avatarIcon.frame = CGRect(x: Constants.padding, y: ceil((bounds.height - Constants.avatarIconSize.height) / 2), width: Constants.avatarIconSize.width, height: Constants.avatarIconSize.height)
		songLabel.frame = CGRect(x: avatarIcon.frame.maxX + Constants.padding, y: ceil((bounds.height - labelSize.height) / 2), width: labelSize.width, height: labelSize.height)
		
		contentView.addSubview(avatarIcon)
		contentView.addSubview(songLabel)
	}
	
}
