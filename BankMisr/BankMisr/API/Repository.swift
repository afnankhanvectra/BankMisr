//
//  Repository.swift
//  BankMisr
//
//  Created by Afnan Khan on 02/12/2022.
//

import Foundation

typealias GenericResult<T> = (Result<T, Error>) -> Void

protocol RepositoryProtocol {
    
    func callTodoAPI(successHandler: @escaping ((TodoCodable) -> Void),
                     failHandler: @escaping ((BMError?) -> Void))
    
    func callFixerLatestAPI(successHandler: @escaping ((LatestCodable) -> Void),
                     failHandler: @escaping ((BMError?) -> Void))
}

class Repository: RepositoryProtocol {
    
    static let shared = Repository()
    
    private init() { }
    
    func callTodoAPI(successHandler: @escaping ((TodoCodable) -> Void),
                     failHandler: @escaping ((BMError?) -> Void)) {
        
        let apiRequest = ApiCall<TodoCodable>(url: URLCreator.getTodo(todoNumber: "1"), successHandler: {  (todoCodable: TodoCodable) -> Void  in
            successHandler(todoCodable)
            
        }) { (httpStatusCode: HttpStatusCode, errorMessage: BMError?) in
            failHandler(errorMessage)
        }
        apiRequest.callAPI()
    }
    
    func callFixerLatestAPI(successHandler: @escaping ((LatestCodable) -> Void),
                     failHandler: @escaping ((BMError?) -> Void)) {
        
        let apiRequest = ApiCall<LatestCodable>(url: URLCreator.getLatestRates(), successHandler: {  (latestCodable: LatestCodable) -> Void  in
            successHandler(latestCodable)
            
        }) { (httpStatusCode: HttpStatusCode, errorMessage: BMError?) in
            failHandler(errorMessage)
        }
        apiRequest.callAPI()
    }
    
}
