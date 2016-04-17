//
//  SongListItem.swift
//  App
//
//  Created by Carlos Alban on 4/16/16.
//  Copyright © 2016 CGRekt. All rights reserved.
//

import UIKit

class SongListItem: UITableViewCell {
	
	var songName = "Untitled Song"
	var songArtist = "Unknown Artist"
	private var avatarIcon: UIImageView
	private var songLabel: UILabel
	
	struct Constants {
		static let avatarIconSize = CGSize(width: 40, height: 40)
		static let padding: CGFloat = 20
	}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		avatarIcon = UIImageView(frame: CGRect.zero)
		songLabel = UILabel(frame: CGRect.zero)
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
		songLabel.textColor = UIColor.whiteColor()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		configureSubviews()
	}
	
	override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
		super.didUpdateFocusInContext(context, withAnimationCoordinator: coordinator)
		if self == context.previouslyFocusedView {
			updatePreviousFocusItem()
		} else if self ==  context.nextFocusedView {
			updateNextFocusItem()
		}
	}
	
	func updatePreviousFocusItem() {
		songLabel.textColor = UIColor.whiteColor()
	}
	
	func updateNextFocusItem() {
		songLabel.textColor = UIColor.blackColor()
	}
	
	private func configureSubviews() {
		songLabel.text = "\(songName) - \(songArtist)"
		songLabel.font = UIFont(name: "Avenir-Medium", size: 20.0)
		songLabel.textAlignment = .Center
		songLabel.numberOfLines = 1
		
		// TODO: Get custom image
		avatarIcon = UIImageView(image: UIImage(named: "ninjaAvatar"))
		
		let songLabelMaxWidth = bounds.width - Constants.avatarIconSize.width - (3 * Constants.padding)
		let maxSize = CGSize(width: songLabelMaxWidth, height: CGFloat.max)
		let labelSize = songLabel.sizeThatFits(maxSize)
		
		avatarIcon.frame = CGRect(x: Constants.padding, y: ceil((bounds.height - Constants.avatarIconSize.height) / 2), width: Constants.avatarIconSize.width, height: Constants.avatarIconSize.height)
		songLabel.frame = CGRect(x: avatarIcon.frame.maxX + Constants.padding, y: ceil((bounds.height - labelSize.height) / 2), width: labelSize.width, height: labelSize.height)
		
		contentView.addSubview(avatarIcon)
		contentView.addSubview(songLabel)
	}
	
}
