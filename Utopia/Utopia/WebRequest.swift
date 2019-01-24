
import Foundation

open class WebRequest {
    open static func fromUtopiaWebRequest(_ utopiaWebRequest: ComSoftwareverdeUtilWebRequest) -> WebRequest {
        return WebRequest(utopiaWebRequest: utopiaWebRequest)
    }

    public typealias Callback_t = (_ webRequest: WebRequest) -> Void

    public enum `Type` {
        case get, post
    }

    fileprivate class UtopiaWebRequestCallback : NSObject, ComSoftwareverdeUtilWebRequest_Callback {
        fileprivate let _callback : Callback_t?
        init(_ callback: Callback_t?) {
            _callback = callback
        }

        @objc
        func run(with request: ComSoftwareverdeUtilWebRequest!) {
            DispatchQueue.main.async(execute: {
                self._callback?(WebRequest.fromUtopiaWebRequest(request))
            })
        }
    }

    fileprivate let _webRequest : ComSoftwareverdeUtilWebRequest

    fileprivate init(utopiaWebRequest: ComSoftwareverdeUtilWebRequest) {
        _webRequest = utopiaWebRequest
    }

    public init() {
         _webRequest = ComSoftwareverdeUtilWebRequest()
    }

    open func setUrl(_ url: String) {
        _webRequest.setUrlWith(url)
    }

    open func setType(_ type: Type) {
        let getRequestType : ComSoftwareverdeUtilWebRequest_RequestType = ComSoftwareverdeUtilWebRequest_RequestType_fromOrdinal(ComSoftwareverdeUtilWebRequest_RequestType_Enum.GET.rawValue)
        let postRequestType : ComSoftwareverdeUtilWebRequest_RequestType = ComSoftwareverdeUtilWebRequest_RequestType_fromOrdinal(ComSoftwareverdeUtilWebRequest_RequestType_Enum.POST.rawValue)

        _webRequest.setTypeWith((type == .get ? getRequestType : postRequestType))
    }

    open func setPostParam(_ key: String, value: String) {
        _webRequest.setPostParamWith(key, with: value)
    }

    open func getRawResult() -> String? {
        return _webRequest.getRawResult()
    }

    open func execute(_ callback: Callback_t?) {
        _webRequest.execute(withBoolean: true, with: UtopiaWebRequestCallback(callback))
    }
}
