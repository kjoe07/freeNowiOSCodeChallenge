//
//  NetWorkLoader.swift
//  freeNowiOSCodeChallenge
//
//  Created by kjoe on 11/16/20.
//

import Foundation
protocol NetworkLoader {
    func loadData(request: URLRequest?,completion: @escaping (Result<Data,Error>)->Void) -> NetworkCancelable?
}
protocol NetworkCancelable {
    func cancel()
}
extension URLSessionDataTask: NetworkCancelable { }

struct CustomNetWorkLoader: NetworkLoader{
    var session: URLSession
    
    func loadData(request: URLRequest?, completion: @escaping (Result<Data,Error>) -> Void) -> NetworkCancelable? {
        guard let request = request else {
            completion(.failure(customError.badRequest))
            return nil }
            let task = session.dataTask(with: request){data,response,error in
            if error != nil{
                guard let error = error else { return }
                completion(.failure(error))
            }else {
                guard let data = data else {return}
                completion(.success(data))
            }
        }
        task.resume()
        return task
    }
    init(session: URLSession) {
        self.session = session
    }
    
}
enum customError: Error{
    case badRequest
}
