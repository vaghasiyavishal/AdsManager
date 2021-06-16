//
//  AdsInfo.swift
//  AdsManager
//
//  Created by VISHAL VAGHASIYA on 15/06/21.
//

import Foundation
import Foundation
public class AdInfo {
    public init() {}
    
    public var isRemoveAds: Bool {
        get {
            return (UserDefaults.standard.bool(forKey: "isRemoveAds"))
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isRemoveAds")
            UserDefaults.standard.synchronize()
        }
    }
    
    public var isLiveAds: Bool {
        get {
            return (UserDefaults.standard.bool(forKey: "isLive"))
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isLive")
            UserDefaults.standard.synchronize()
        }
    }
    
    public var openApp_Ads: String {
        get {
            return (UserDefaults.standard.string(forKey: "openApp_Ads") ?? "")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "openApp_Ads")
            UserDefaults.standard.synchronize()
        }
    }
    
    public var banner_Ads: String {
        get {
            return (UserDefaults.standard.string(forKey: "banner_Ads") ?? "")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "banner_Ads")
            UserDefaults.standard.synchronize()
        }
    }
    
    public var interstitial_Ads: String {
        get {
            return (UserDefaults.standard.string(forKey: "interstitial_Ads") ?? "")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "interstitial_Ads")
            UserDefaults.standard.synchronize()
        }
    }
    
    public var native_Ads: String {
        get {
            return (UserDefaults.standard.string(forKey: "native_Ads") ?? "")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "native_Ads")
            UserDefaults.standard.synchronize()
        }
    }
    
    public static let shared: AdInfo = {
        let instance = AdInfo()
        return instance
    }()
}
