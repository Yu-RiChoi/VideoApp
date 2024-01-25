//
//  ViewController.swift
//  VideoApp
//
//  Created by 최유리 on 1/24/24.
//

import UIKit
import AVKit

class ViewController: UITableViewController {
    
    var data: [VideoData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // 셀 등록
        tableView.register(VideoCell.self, forCellReuseIdentifier: "VideoCell")
    }
    
    private func fetchData() {
        guard let url = URL(string: "https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json")
        else { return }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let videoInfoList = try JSONDecoder().decode([VideoData].self, from: data)
                self.data = videoInfoList
                self.tableView.reloadData()
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    private func presentPlayerViewController(videoURL: URL) {
        let playerController = AVPlayerViewController()
        let player = AVPlayer(url: videoURL as URL)
        
        playerController.player = player
        
        self.present(playerController, animated: true) {
            player.play()
        }
    }
    
    private func setConstraint() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? VideoCell
        else { return UITableViewCell() }
        
        let video = self.data[indexPath.row]
        
        cell.setThumbnail(imageURL: video.thumbnailUrl)
        cell.setTitle(title: video.title)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video = self.data[indexPath.row]
        presentPlayerViewController(videoURL: video.videoUrl)
    }
}

