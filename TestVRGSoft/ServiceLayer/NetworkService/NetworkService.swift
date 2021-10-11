//
//  NetworkService.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 05.10.2021.
//

import Foundation
import Alamofire
import UIKit

protocol NetworkServiceProtocol {
    
    // MARK: - Network service protocol
    
    func requestFilms(search: String?, completion: @escaping (Result<Films, Error>) -> Void)
    func downloadImage(urlString: String, completion: @escaping (UIImage) -> Void)
    
}

class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Variables
    
    private var urlString = String()
    private var parameters = [String: String]()
    private var dateWith = String()
    private var dateOn = String()
    private var openingDates = String()
    
    // MARK: - Lifecycle
    
    init(dateWith: String?, dateOn: String?) {
        self.urlString = DBConstants.nYTimesURL
        guard dateWith != nil else {
            configureDefaultsParameters()
            return
        }
        guard dateOn != nil else {
            configureDefaultsParameters()
            return
        }
        self.openingDates = "\(String(describing: dateWith)):\(String(describing: dateOn))"
        parameters = ["opening-date": openingDates, "api-key": DBConstants.nYTimesKey]
    }
    
    // MARK: - Protocol methods
    
    func requestFilms(search: String?, completion: @escaping (Result<Films, Error>) -> Void) {
        if search != nil {
            configureSearchParameters(search: search ?? "")
        } else {
            configureDefaultsParameters()
        }
        guard let url = URL(string: urlString) else { return }
        AF.request(url, method: .get, parameters: self.parameters).responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                let films = try JSONDecoder().decode(Films.self, from: data)
                completion(.success(films))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func downloadImage(urlString: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: urlString) else { return }
        AF.download(url).responseData(completionHandler: { (response) in
            guard let data = response.value else { return }
            guard let image = UIImage(data: data) else { return }
            completion(image)
        })
    }
    
    // MARK: - Helpers
    
    private func configureDefaultsParameters() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        self.dateWith = dateFormatter.string(from: date) + "-01"
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.dateOn = dateFormatter.string(from: date)
        self.openingDates = "\(self.dateWith):\(self.dateOn)"
        parameters = ["opening-date": openingDates, "api-key": DBConstants.nYTimesKey]
    }
    
    private func configureSearchParameters(search: String) {
        parameters = ["query": search, "api-key": DBConstants.nYTimesKey]
    }
    
}
