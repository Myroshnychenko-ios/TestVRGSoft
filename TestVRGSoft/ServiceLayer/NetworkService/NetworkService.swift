//
//  NetworkService.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 05.10.2021.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func requestFilms(completion: @escaping (Result<Results, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    private var urlString = String()
    private var parameters = [String: String]()
    private var dateWith = String()
    private var dateOn = String()
    private var openingDates = String()
    
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
    
    func requestFilms(completion: @escaping (Result<Results, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        AF.request(url, method: .get, parameters: self.parameters).responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                let results = try JSONDecoder().decode(Results.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
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
    
}
