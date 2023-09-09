//
//  HomeAPI.swift
//  SleepWellApp
//
//  Created by 배은서 on 2023/09/09.
//

import Foundation
final class HomeAPI {
    static let shared = HomeAPI()
    private init() { }
    
    func getVideos(searchKeyword: String, maxResults: Int, completion: @escaping ((_ video: Video, _ index: Int) -> ())) {
        // items.id.videoId / items.snippet.publishedAt, title / items.snippet.thumbnails / items.snippet.channelTitle
        APIManager.shared.getVideos(searchKeyword: searchKeyword, maxResults: maxResults) { data, error in
            if let data = data, let items = data["items"] as? [[String:Any]] {
                for (index, item) in items.enumerated() {
                    if let id = item["id"] as? [String:Any],
                       let videoId = id["videoId"] as? String,
                       let snippet = item["snippet"] as? [String:Any],
                       let title = snippet["title"] as? String,
                       let thumbnails = snippet["thumbnails"] as? [String:Any],
                       let standard = thumbnails["default"] as? [String:Any],
                       let thumbnailUrl = standard["url"] as? String,
                       let width = standard["width"] as? Int,
                       let height = standard["height"] as? Int,
                       let publishedAt = snippet["publishedAt"] as? String,
                       let channelTitle = snippet["channelTitle"] as? String {
                        
                        completion(Video(id: videoId,
                                         thumbnail: Thumbnail(url: thumbnailUrl, image: nil, width: width, height: height),
                                         title: title,
                                         channelTitle: channelTitle,
                                         publishedAt: publishedAt,
                                         viewCount: "",
                                         duration: ""),
                                    index)
                    }
                }
            }
        }
    }
    
    func getVideoInfo(id: String, index: Int, completion: @escaping((_ duration: String?, _ viewCount: String?) -> ())) {
        // 영상 길이
        APIManager.shared.getVideoInfo(id: id, part: "contentDetails") { data, error in
            if let data = data, let items = data["items"] as? [[String:Any]] {
                for item in items {
                    if let content = item["contentDetails"] as? [String:Any],
                       let duration = content["duration"] as? String {
                        completion(duration, nil)
                    }
                }
            }
        }
        
        // 조회수
        APIManager.shared.getVideoInfo(id: id, part: "statistics") { data, error in
            if let data = data, let items = data["items"] as? [[String:Any]] {
                for item in items {
                    if let statistics = item["statistics"] as? [String:Any],
                       let viewCount = statistics["viewCount"] as? String {
                        completion(nil, viewCount)
                    }
                }
            }
        }
    }
}
