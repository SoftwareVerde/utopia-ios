
import Foundation

open class ProvinceNews {
    open static func fromUtopiaNews(_ utopiaNews: ComSoftwareverdeUtopiaNewsNewsEvent) -> ProvinceNews {
        return ProvinceNews(utopiaNews: utopiaNews)
    }

    fileprivate let _provinceNews : ComSoftwareverdeUtopiaNewsNewsEvent

    fileprivate init(utopiaNews: ComSoftwareverdeUtopiaNewsNewsEvent) {
        _provinceNews = utopiaNews
    }

    open func toUtopiaNews() -> ComSoftwareverdeUtopiaNewsNewsEvent {
        return _provinceNews
    }

    open func getDate() -> String {
        return _provinceNews.getDate()
    }

    open func getNews() -> String {
        return _provinceNews.getNews()
    }
}
