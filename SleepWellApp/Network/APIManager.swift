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
    static let key: String = "AIzaSyDwk1EAb0wsVr7w4XxGEby6gmj2FSG4tYU"
}

class APIManager {
    static let shared = APIManager()
    private init() {}
    
    // 여기서 찾은 영상의 id를 저장해 영상 정보를 다시 불러와야됨
    // 영상 올린 날짜는 snippet의 publishedAt 필드에서 알 수 있음
    // items.id.videoId / items.snippet.publishedAt, title / items.snippet.thumbnails / items.snippet.channelTitle
    func getVideos(searchKeyword: String , completion: @escaping ([String:Any]?, AFError?) -> Void) {
        let url = API.baseUrl + "search"
        let body = [
            "part": "snippet",
            "type": "video",
            "q": "\(searchKeyword)",
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
    
    // part -> contentDetails일 때 영상 길이를 알 수 있음 (duration 필드: ISO 8601 문자열 형식으로 지정되어 있음)
    // part -> statistics일 때 조회수를 알 수 있음 (viewCount 필드)
    // 여러 영상의 정보를 얻고 싶다면 여러 id를 &로 구분해서 넣으면 됨
    func getVideoInfo(id: [String], part: String, completion: @escaping (Any?, AFError?) -> Void) {
        let url = API.baseUrl + "videos"
        let videoId: String = id.joined(separator: "&")
        
        let body = [
            "id": videoId,
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
