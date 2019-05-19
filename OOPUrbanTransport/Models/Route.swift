import Cocoa
import Realm
import RealmSwift

class Route: Object {
    
    @objc dynamic private var name: String = ""
    @objc dynamic private var length: Double = -1
    @objc dynamic private var lapsPerDay = -1
    @objc dynamic private var points: String = ""
    
    convenience init(name: String, points: String, length: Double, lapsPerDay: Int) {
        self.init()
        self.points = points
        self.name = name
        self.length = length
        self.lapsPerDay = lapsPerDay
    }
    
    override static func primaryKey() -> String {
        return "name"
    }
    
    override var description: String {
        return "name: \(name), points: \(points), length:\(length), lapsPerDay:\(lapsPerDay)"
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func getPoints() -> String {
        return self.points
    }
    
    public func getLength() -> Double {
        return length
    }
    
    public func getLaps() -> Int {
        return lapsPerDay
    }
    
    override var debugDescription: String {
        return "\(name), \(points), \(length), \(lapsPerDay)"
    }
}
