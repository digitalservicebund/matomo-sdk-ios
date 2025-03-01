import Foundation

/// MatomoUserDefaults is a wrapper for the UserDefaults with properties
/// mapping onto values stored in the UserDefaults.
/// All getter and setter are sideeffect free and automatically syncronize
/// after writing.
internal struct MatomoUserDefaults {
    let userDefaults: UserDefaults

    init(suiteName: String?) {
        userDefaults = UserDefaults(suiteName: suiteName)!
    }
    
    var totalNumberOfVisits: Int {
        get {
            return userDefaults.integer(forKey: MatomoUserDefaults.Key.totalNumberOfVisits)
        }
        set {
            userDefaults.set(newValue, forKey: MatomoUserDefaults.Key.totalNumberOfVisits)
            userDefaults.synchronize()
        }
    }
    
    var firstVisit: Date? {
        get {
            return userDefaults.object(forKey: MatomoUserDefaults.Key.firstVistsTimestamp) as? Date
        }
        set {
            userDefaults.set(newValue, forKey: MatomoUserDefaults.Key.firstVistsTimestamp)
            userDefaults.synchronize()
        }
    }
    
    var previousVisit: Date? {
        get {
            return userDefaults.object(forKey: MatomoUserDefaults.Key.previousVistsTimestamp) as? Date
        }
        set {
            userDefaults.set(newValue, forKey: MatomoUserDefaults.Key.previousVistsTimestamp)
            userDefaults.synchronize()
        }
    }
    
    var currentVisit: Date? {
        get {
            return userDefaults.object(forKey: MatomoUserDefaults.Key.currentVisitTimestamp) as? Date
        }
        set {
            userDefaults.set(newValue, forKey: MatomoUserDefaults.Key.currentVisitTimestamp)
            userDefaults.synchronize()
        }
    }
    
    var optOut: Bool {
        get {
            return userDefaults.bool(forKey: MatomoUserDefaults.Key.optOut)
        }
        set {
            userDefaults.set(newValue, forKey: MatomoUserDefaults.Key.optOut)
            userDefaults.synchronize()
        }
    }
    
    var clientId: String? {
        get {
            return userDefaults.string(forKey: MatomoUserDefaults.Key.clientID)
        }
        set {
            userDefaults.setValue(newValue, forKey: MatomoUserDefaults.Key.clientID)
            userDefaults.synchronize()
        }
    }
    
    var forcedVisitorId: String? {
        get {
            return userDefaults.string(forKey: MatomoUserDefaults.Key.forcedVisitorID)
        }
        set {
            userDefaults.setValue(newValue, forKey: MatomoUserDefaults.Key.forcedVisitorID)
            userDefaults.synchronize()
        }
    }
    
    var visitorUserId: String? {
        get {
            return userDefaults.string(forKey: MatomoUserDefaults.Key.visitorUserID);
        }
        set {
            userDefaults.setValue(newValue, forKey: MatomoUserDefaults.Key.visitorUserID);
            userDefaults.synchronize()
        }
    }
    
    var lastOrder: Date? {
        get {
            return userDefaults.object(forKey: MatomoUserDefaults.Key.lastOrder) as? Date
        }
        set {
            userDefaults.set(newValue, forKey: MatomoUserDefaults.Key.lastOrder)
        }
    }
    
    func reset() {
        userDefaults.removeObject(forKey: Key.totalNumberOfVisits)
        userDefaults.removeObject(forKey: Key.currentVisitTimestamp)
        userDefaults.removeObject(forKey: Key.previousVistsTimestamp)
        userDefaults.removeObject(forKey: Key.firstVistsTimestamp)
        userDefaults.removeObject(forKey: Key.clientID)
        userDefaults.removeObject(forKey: Key.forcedVisitorID)
        userDefaults.removeObject(forKey: Key.visitorUserID)
        userDefaults.removeObject(forKey: Key.optOut)
        userDefaults.removeObject(forKey: Key.lastOrder)
    }
}

extension MatomoUserDefaults {
    public mutating func copy(from userDefaults: UserDefaults) {
        totalNumberOfVisits = userDefaults.integer(forKey: MatomoUserDefaults.Key.totalNumberOfVisits)
        firstVisit = userDefaults.object(forKey: MatomoUserDefaults.Key.firstVistsTimestamp) as? Date
        previousVisit = userDefaults.object(forKey: MatomoUserDefaults.Key.previousVistsTimestamp) as? Date
        currentVisit = userDefaults.object(forKey: MatomoUserDefaults.Key.currentVisitTimestamp) as? Date
        optOut = userDefaults.bool(forKey: MatomoUserDefaults.Key.optOut)
        clientId = userDefaults.string(forKey: MatomoUserDefaults.Key.clientID)
        forcedVisitorId = userDefaults.string(forKey: MatomoUserDefaults.Key.forcedVisitorID)
        visitorUserId = userDefaults.string(forKey: MatomoUserDefaults.Key.visitorUserID)
        lastOrder = userDefaults.object(forKey: MatomoUserDefaults.Key.lastOrder) as? Date
    }
}

extension MatomoUserDefaults {
    internal struct Key {
        static let totalNumberOfVisits = "PiwikTotalNumberOfVistsKey"
        static let currentVisitTimestamp = "PiwikCurrentVisitTimestampKey"
        static let previousVistsTimestamp = "PiwikPreviousVistsTimestampKey"
        static let firstVistsTimestamp = "PiwikFirstVistsTimestampKey"
        
        // Note:    To be compatible with previous versions, the clientID key retains its old value,
        //          even though it is now a misnomer since adding visitorUserID makes it a bit confusing.
        static let clientID = "PiwikVisitorIDKey"
        static let forcedVisitorID = "PiwikForcedVisitorIDKey"
        static let visitorUserID = "PiwikVisitorUserIDKey"
        static let optOut = "PiwikOptOutKey"
        static let lastOrder = "PiwikLastOrderDateKey"
    }
}
