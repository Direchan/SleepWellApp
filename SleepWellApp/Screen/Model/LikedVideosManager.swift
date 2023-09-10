//
//  LikedVideoManager.swift
//  SleepWellApp
//
//  Created by t2023-m0091 on 2023/09/09.
//

import Foundation


class LikedVideosManager {
    static let shared = LikedVideosManager()
    
    private init() {}
    
    private var likedVideosByUserId: [String: [Video]] = [:]

    func getLikedVideos() -> [Video] {
        guard let currentUser = DataManager.shared.getCurrentUser() else { return [] }
        return likedVideosByUserId[currentUser] ?? []
    }

    
    func add(video: Video) {
        guard let currentUser = DataManager.shared.getCurrentUser() else { return }
        
        var videos = likedVideosByUserId[currentUser] ?? []
        if !videos.contains(where: { $0.id == video.id }) {
            videos.append(video)
        }
        
        likedVideosByUserId[currentUser] = videos
    }

    func remove(video: Video) {
        guard let currentUser = DataManager.shared.getCurrentUser() else { return }
        
        var videos = likedVideosByUserId[currentUser] ?? []
        if let index = videos.firstIndex(where: { $0.id == video.id }) {
            videos.remove(at: index)
        }
        
        likedVideosByUserId[currentUser] = videos
    }

    func isLiked(video: Video) -> Bool {
        guard let currentUser = DataManager.shared.getCurrentUser() else { return false }
        
        let videos = likedVideosByUserId[currentUser] ?? []
        return videos.contains(where: { $0.id == video.id })
    }
}

