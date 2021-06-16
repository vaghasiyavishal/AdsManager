//
//  AdsManager.swift
//  AdsManager
//
//  Created by VISHAL VAGHASIYA on 15/06/21.
//

import Foundation
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport
protocol UINativeAdDelegate {
    func adLoader(didFinish nativeAd: GADNativeAd)
}
public class AdManager: NSObject {
    public static let shared = AdManager()
    
    //MARK: - GADInterstitial
    var interstitial: GADInterstitialAd!
    public var isShowAd = false {
        didSet {
            if isShowAd {
                if AdInfo.shared.isLiveAds {
                    presentInterstitial()
                }
            }
        }
    }
    
    public func requestIDFA() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                
            })
        }
    }
    
    var openAdvt = false
    public func createAndLoadInterstitial(){
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: AdInfo.shared.interstitial_Ads, request: request) { (ad, error) in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            self.interstitial = ad
            self.interstitial.fullScreenContentDelegate = self
        }
    }
    
    func presentInterstitial() {
        if let ad = interstitial {
            ad.present(fromRootViewController: UIApplication.shared.windows.first!.rootViewController!)
            isShowAd = false
        } else {
            print("Ad wasn't ready")
        }
    }
    
    var appOpenAd: GADAppOpenAd?
    public func requestAppOpenAd() {
        appOpenAd = nil
        GADAppOpenAd.load(
            withAdUnitID: AdInfo.shared.openApp_Ads,
            request: GADRequest(),
            orientation: UIInterfaceOrientation.portrait,
            completionHandler: { [self] appOpenAd, error in
                if error != nil {
                    return
                }
                self.appOpenAd = appOpenAd
                self.appOpenAd?.fullScreenContentDelegate = self
            })
    }
    
    public func tryToPresentAd() {
        if (appOpenAd != nil) {
            let rootController = UIApplication.shared.windows.first!.rootViewController
            appOpenAd!.present(fromRootViewController: rootController!)
        } else {
            requestAppOpenAd()
        }
    }
    
    //MARK: - Native Ad
    var adLoader: GADAdLoader!
    var nativeAd = GADNativeAd()
    var nativeAdView: GADNativeAdView!
    var delegate: UINativeAdDelegate?
    
   public func createNativeAds(_ vc: UIViewController) {
        let options = GADMultipleAdsAdLoaderOptions()
        self.adLoader = GADAdLoader.init(adUnitID: AdInfo.shared.native_Ads, rootViewController: vc, adTypes: [GADAdLoaderAdType.native], options: [options])
        self.adLoader.delegate = self
        self.adLoader.load(GADRequest.init())
    }
    
    //MARK: - Banner View
    public func loadBannerAd(in bannerView: GADBannerView, _ vc: UIViewController) {
        if AdInfo.shared.isLiveAds && !AdInfo.shared.isRemoveAds{
            bannerView.isHidden = false
        }
        
        bannerView.adUnitID = AdInfo.shared.banner_Ads
        bannerView.rootViewController = vc
        
        let frame = { () -> CGRect in
            let rect = CGRect()
            DispatchQueue.main.async {
                vc.view.frame.inset(by: vc.view.safeAreaInsets)
            }
            return rect
        }()
        let viewWidth = frame.size.width
        DispatchQueue.main.async {
            bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        }
        
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    class func showAdvt() -> Bool {
        return true
    }
}
extension AdManager: GADFullScreenContentDelegate {
    public func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        openAdvt = true
        self.requestAppOpenAd()
    }
    
    public func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("adDidPresentFullScreenContent")
    }
    
    public func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        self.requestAppOpenAd()
        createAndLoadInterstitial()
    }
}

extension AdManager: GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        
    }
}

extension AdManager: GADAdLoaderDelegate, GADNativeAdLoaderDelegate, GADNativeAdDelegate, GADVideoControllerDelegate {
    public func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
        
    }
    
    public func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
        self.nativeAd = nativeAd
        nativeAd.delegate = self
    }
    
    public func adLoaderDidFinishLoading(_ adLoader: GADAdLoader) {
        delegate?.adLoader(didFinish: self.nativeAd)
    }
}
