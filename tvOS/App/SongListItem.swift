//
//  SongListItem.swift
//  App
//
//  Created by Carlos Alban on 4/16/16.
//  Copyright © 2016 CGRekt. All rights reserved.
//

import UIKit

class SongListItem: UITableViewCell {
	
	private var avatarIcon: UIImageView
	private var songName: UILabel

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		avatarIcon = UIImageView(frame: CGRect.zero)
		songName = UILabel(frame: CGRect.zero)
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = UIColor.orangeColor()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	
}
