//
//  APICall.swift
//  BankMisr
//
//  Created by Afnan Khan on 02/12/2022.
//

import Foundation


public class ApiCall<T> : NSObject , URLSessionDelegate  where T: Codable {
    
    private let url:URL;
    private let successHandler: (T) -> Void;
    private let errorHandler: (HttpStatusCode, BMError?) -> Void;
    
    init( successHandler: @escaping (T) -> Void, errorHandler: @escaping (HttpStatusCode, BMError?) -> Void) {
        self.url =  URLCreator.getBaseURL()
        self.successHandler = successHandler;
        self.errorHandler = errorHandler;
    }
    
    init(url:URL, successHandler: @escaping (T) -> Void, errorHandler: @escaping (HttpStatusCode, BMError?) -> Void) {
        self.url = url
        self.successHandler = successHandler;
        self.errorHandler = errorHandler;
    }
    
    @discardableResult func callAPI(withData data:[String: Any] = [:], methodType _methodType : String = FGET  ) -> URLSessionDataTask? {
        
        let info = ProcessInfo.processInfo
        let begin = info.systemUptime
        
        let parameters = data
        print(url)
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30
        sessionConfig.timeoutIntervalForResource = 60
        let session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        
   
//        let url2 = "https://api.apilayer.com/fixer/latest?symbols=EUR,PKR,AFN&base=USD"
//        var request = URLRequest(url: URL(string: url2)!,timeoutInterval: Double.infinity)

        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        
        request.httpMethod = _methodType
        
        if parameters.count > 0 {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // Add Token of user here
         request.addValue(apiKey, forHTTPHeaderField: FTOKEN_HEADER)
        
        let task = session.dataTask(with: request as URLRequest) { (data, urlResponse, error) in
            
            guard error == nil else {
                // if timeout error then send timeout for token refresh
                if  ( error! as NSError  ).code == HttpStatusCode.Timeout.rawValue {
                    self.errorHandler(HttpStatusCode.Timeout, BMError(error: error) )
                }  else {
                    self.errorHandler(HttpStatusCode.Unknown,  BMError(error: error))
                }
                return
            }

            guard let data = data else {
                return
            }
   
            print("JSON String: \(String(data: data, encoding: .utf8) ?? "")")

            do {
                let decoder = JSONDecoder();
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let dataObject = try self.decodeObject(T.self, from: data) {
                    let diff = (info.systemUptime - begin)
                    print("API  \(self.url)  response time  is   \(diff)")
                    self.successHandler(dataObject)
                    return
                }
            } catch let error {
                let bmError = try? self.decodeObject(BMError.self, from: data)
                print("Error is \(error.localizedDescription)")
                self.errorHandler(HttpStatusCode.Unknown, bmError)
            }
        }
        task.resume()
        return task
    }
    
    func decodeObject<T: Decodable>(_ model: T.Type,
                                    from data: Data) throws -> T? {
        let decoder = JSONDecoder()
        let objects = try decoder.decode(model.self, from: data)
        return objects
    }
    
    
    private var apiKey: String {
        get {
            // 1
            guard let filePath = Bundle.main.path(forResource: "Keys-Info", ofType: "plist") else {
                fatalError("Couldn't find file 'Keys-Info.plist'.")
            }
            // 2
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "FixerAPI") as? String else {
                fatalError("Couldn't find key 'FixerAPI' in 'Keys-Info.plist'.")
            }
            return value
        }
    }
    
}
