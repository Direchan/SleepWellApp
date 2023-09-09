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
    
    private(set) var likedVideos: [Video] = []

    func add(video: Video) {
        if !likedVideos.contains(where: { $0.id == video.id }) {
            likedVideos.append(video)
        }
    }

    func remove(video: Video) {
        if let index = likedVideos.firstIndex(where: { $0.id == video.id }) {
            likedVideos.remove(at: index)
        }
    }

    func isLiked(video: Video) -> Bool {
        return likedVideos.contains(where: { $0.id == video.id })
    }
}
