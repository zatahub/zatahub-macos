//
//  MockSession.swift
//  ZataHubTests
//
//  Created by Macbook on 07/02/2024.
//

import Alamofire
import Foundation

final class MockSession: Session {
    var requestIsCalled: Bool = false
    var url: URLConvertible?
    var method: HTTPMethod?
    var parameters: Parameters?
    var encoding: ParameterEncoding?
    var uploadIsCalled: Bool = false
    var uploadUrl: URLRequestConvertible?
    var multipartFormData: MultipartFormData?

    override func request(_ convertible: URLConvertible, method: HTTPMethod = .get, 
                          parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default,
                          headers: HTTPHeaders? = nil, interceptor: RequestInterceptor? = nil,
                          requestModifier: Session.RequestModifier? = nil) -> DataRequest {
        requestIsCalled = true
        url = convertible
        self.method = method
        self.parameters = parameters
        self.encoding = encoding
        return super.request(convertible, method: method,
                             parameters: parameters, encoding: encoding)
    }

    override func upload(multipartFormData: @escaping (MultipartFormData) -> Void, to url: URLConvertible, usingThreshold encodingMemoryThreshold: UInt64 = MultipartFormData.encodingMemoryThreshold, method: HTTPMethod = .post, headers: HTTPHeaders? = nil, interceptor: RequestInterceptor? = nil, fileManager: FileManager = .default, requestModifier: Session.RequestModifier? = nil) -> UploadRequest {
        uploadIsCalled = true
        let formData = MultipartFormData(fileManager: fileManager)
        multipartFormData(formData)
        self.multipartFormData = formData
        return super.upload(multipartFormData: multipartFormData, to: url)
    }
}

extension ParameterEncoding {
    func isEqual(rhs: ParameterEncoding) {
        
    }
}
