

import Foundation
import RxSwift

class NetworkManager{
    
    static let shared = NetworkManager(baseUrlEndpoint)
    
    private let baseUrl: String

    private init(_ baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    enum HttpError: Error {
        case badUrl
        case emptyResponseHttp
        case bodyParsingFailed
        case responseParsingFailed
    }
    
    enum HttpMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    private func buildRequest<T: Codable>(_ urlString: String,_ httpMethod: HttpMethod, _ parameters: Dictionary<String, String>, _ emitter: AnyObserver<T>? = nil) -> URLSessionDataTask? {
        
        var requestUrl: String = urlString
        var body: Data?
        switch httpMethod {
        case .GET:
            requestUrl = createGetUrl(requestUrl, parameters)
        default:
            do{
                body = try JSONSerialization.data(withJSONObject: parameters, options: [])
            }
            catch{
                emitter?.onError(HttpError.bodyParsingFailed)
            }
        }
        guard let url = URL(string: requestUrl) else {
                emitter?.onError(HttpError.badUrl)
                return nil
        }
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        if body != nil {
            urlRequest.httpBody = body
        }
        return URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            guard error == nil else {
                emitter?.onError(error!)
                return
            }
            guard let responseData = data else {
                emitter?.onError(HttpError.emptyResponseHttp)
                return
            }
            do {
                let responseObject = try JSONDecoder().decode(T.self, from: responseData)
                emitter?.onNext(responseObject)
                emitter?.onCompleted()
            } catch  {
                emitter?.onError(HttpError.responseParsingFailed)
                return
            }
        }
        
    }
    
    private func createGetUrl(_ url: String,_ parameters: Dictionary<String, String>) -> String{
        return "\(url)?\(parameters.map{"\(String(describing: urlEncode($0.key)))=\(String(describing: urlEncode($0.value)))"}.joined(separator: "&"))"
    }
    
    private func urlEncode(_ value: String) -> String? {
        return value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
    private func createObservable<T: Codable>(_ path: String, _ parameters: Dictionary<String, String>, _ httpMethod: HttpMethod, _ retryCount: Int) -> Observable<T>{
        return Observable.create { emitter in
            let request: URLSessionDataTask? = self.buildRequest("\(self.baseUrl)\(path)", httpMethod, parameters, emitter)
            request?.resume()
            return Disposables.create() {
                request?.cancel();
            }
            }.retry(retryCount)
    }
    
    func get<T: Codable>(_ path: String, _ parameters: Dictionary<String, String>, _ retryCount: Int = 1) -> Observable<T>  {
        return createObservable(path, parameters, .GET, retryCount)
    }
    
    func post<T: Codable>(_ path: String, _ parameters: Dictionary<String, String>,_ retryCount: Int = 1) -> Observable<T> {
       return createObservable(path, parameters, .POST, retryCount)
    }
    
    func put<T: Codable>(_ path: String, _ parameters: Dictionary<String, String>,_ retryCount: Int = 1) -> Observable<T> {
        return createObservable(path, parameters, .PUT, retryCount)
    }
    
    func delete<T: Codable>(_ path: String, _ parameters: Dictionary<String, String>,_ retryCount: Int = 1) -> Observable<T> {
        return createObservable(path, parameters, .DELETE, retryCount)
    }
    

    
}
