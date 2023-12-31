//
//  APIManager.swift
//  SleepWellApp
//
//  Created by 배은서 on 2023/09/08.
//

import Foundation
import Alamofire

enum API {
    
    static let baseUrl: String = "https://youtube.googleapis.com/youtube/v3/"
    static let key: String = "AIzaSyArLP_uYpYk83gX8s_6F25NCVH9-7k--a0"
    //AIzaSyCDrHPlc_iwEnPoV0wL9kzc6cwbRZ5Rjgw
}
//AIzaSyDwk1EAb0wsVr7w4XxGEby6gmj2FSG4tYU
class APIManager {
    static let shared = APIManager()
    private init() {}
    
    // 여기서 찾은 영상의 id를 저장해 영상 정보를 다시 불러와야됨
    // 영상 올린 날짜는 snippet의 publishedAt 필드에서 알 수 있음
    // items.id.videoId / items.snippet.publishedAt, title / items.snippet.thumbnails / items.snippet.channelTitle
    
    func getChannelInfo(channelId: String, completion: @escaping((_ thumbnailUrl: String?) -> ())) {
        let url = API.baseUrl + "channels"
        
        let parameters: [String: Any] = [
            "part": "snippet",
            "id": channelId,
            "key": API.key
        ]
        
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let response):
                    do {
                        let data = try JSONSerialization.jsonObject(with: response, options: []) as? [String: Any]
                        if let items = data?["items"] as? [[String: Any]],
                           let snippet = items.first?["snippet"] as? [String: Any],
                           let thumbnails = snippet["thumbnails"] as? [String: Any],
                           let defaultThumbnail = thumbnails["default"] as? [String: Any],
                           let thumbnailUrl = defaultThumbnail["url"] as? String {
                            
                            completion(thumbnailUrl)
                        } else {
                            completion(nil)
                        }
                    } catch(let error) {
                        print(error)
                        completion(nil)
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    completion(nil)
                }
            }
    }
    
    
    func getVideos(searchKeyword: String, maxResults: Int, completion: @escaping ([String:Any]?, AFError?) -> Void) {
        let url = API.baseUrl + "search"
        let body = [
            "part": "snippet",
            "type": "video",
            "q": "\(searchKeyword)",
            "maxResults": maxResults,
            "regionCode": "KR",
            "key": API.key
        ] as [String: Any]
        
        AF.request(url, method: .get, parameters: body)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let response):
                    do {
                        let data = try JSONSerialization.jsonObject(with: response, options: []) as? [String:Any]
                        completion(data, nil)
                    } catch(let error) {
                        print(error)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
                debugPrint(response)
            }
    }
    
    // part -> contentDetails일 때 영상 길이를 알 수 있음 (duration 필드: ISO 8601 문자열 형식으로 지정되어 있음)
    // part -> statistics일 때 조회수를 알 수 있음 (viewCount 필드)
    // 여러 영상의 정보를 얻고 싶다면 여러 id를 &로 구분해서 넣으면 됨
    func getVideoInfo(id: String, part: String, completion: @escaping ([String:Any]?, AFError?) -> Void) {
        let url = API.baseUrl + "videos"
        
        let body = [
            "id": id,
            "part": part,
            "maxResults": 10,
            "regionCode": "KR",
            "key": API.key
        ] as [String: Any]
        
        AF.request(url, method: .get, parameters: body)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let response):
                    do {
                        let data = try JSONSerialization.jsonObject(with: response, options: []) as? [String:Any]
                        completion(data, nil)
                    } catch(let error) {
                        print(error)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
                debugPrint(response)
            }
    }
}
