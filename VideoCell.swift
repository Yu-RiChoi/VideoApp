//
//  VideoCell.swift
//  VideoApp
//
//  Created by 최유리 on 1/24/24.
//

import UIKit

class VideoCell: UITableViewCell {
    
    private let thumbnailImage: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 2
        
        return label
    }()
    
    // MARK: - 코드로 셀을 만들면 init을 생성해줘야 한다.
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - auto layout
    
    private func setConstraint() {
        contentView.addSubview(thumbnailImage)
        contentView.addSubview(titleLabel)
        
        thumbnailImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thumbnailImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            thumbnailImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            thumbnailImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            thumbnailImage.widthAnchor.constraint(equalToConstant: 100),
            thumbnailImage.heightAnchor.constraint(equalToConstant: 100),
            titleLabel.leftAnchor.constraint(equalTo: thumbnailImage.rightAnchor, constant: 30),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: thumbnailImage.centerYAnchor)
        ])
    }
    
    // MARK: - 썸네일 / 타이틀
    
    func setThumbnail(imageURL: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: imageURL),
               let image = UIImage(data: data) {
                // ui업데이트는 main thread에서
                DispatchQueue.main.async {
                    self?.thumbnailImage.contentMode = .scaleAspectFill
                    self?.thumbnailImage.image = image
                }
            }  else {
                DispatchQueue.main.async {
                    self?.thumbnailImage.contentMode = .scaleAspectFit
                    self?.thumbnailImage.tintColor = .lightGray
                    self?.thumbnailImage.image = UIImage(systemName: "play.rectangle.fill")
                }
            }
        }
    }
    
    func setTitle(title: String) {
        self.titleLabel.text = title
    }
}
