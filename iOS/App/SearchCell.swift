import UIKit
import SnapKit

class SearchCell: UITableViewCell {
    
    let artworkImageView = UIImageView()
    let titleLabel = UILabel()
    let usernameLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        contentView.addSubview(artworkImageView)
        artworkImageView.snp_makeConstraints { (make) in
            make.leading.top.bottom.equalTo(contentView)
            make.width.equalTo(contentView.snp_height)
        }
        
        titleLabel.numberOfLines = 2
        
        contentView.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) in
            make.leading.equalTo(artworkImageView.snp_trailing).offset(10)
            make.top.trailing.equalTo(contentView).inset(10)
        }
        
        usernameLabel.textColor = UIColor.grayColor()
        contentView.addSubview(usernameLabel)
        usernameLabel.snp_makeConstraints { (make) in
            make.leading.equalTo(artworkImageView.snp_trailing).offset(10)
            make.bottom.trailing.equalTo(contentView).inset(10)
        }
    }
    
    func configure(track: SoundCloudTrackModel) {
        if let url = track.artworkURL {
            if let data = NSData(contentsOfURL: url) {
                artworkImageView.image = UIImage(data: data)
            }
        }
        
        titleLabel.text = track.title
        usernameLabel.text = track.username
    }
}
