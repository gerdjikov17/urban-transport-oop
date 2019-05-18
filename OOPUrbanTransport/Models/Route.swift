import Cocoa
import Realm
import RealmSwift

class Route: Object {
//За маршрута трябва да се знае възловите му точки  и колко километра е дълъг и колко пъти на ден се обикаля.
    dynamic private var name: String = ""
    dynamic private var points: List<String> = List()
    dynamic private var length: Double = -1
    dynamic private var lapsPerDay: Int = -1
    
    init(name: String, points: [String], length: Double, lapsPerDay: Int) {
        super.init()
        self.name = name
        self.points = List<String>()
        self.points.append(objectsIn: points)
        self.length = length
        self.lapsPerDay = lapsPerDay
    }
    
    required init() {
        super.init()
        self.name = "name"
        self.points = List()
        self.length = -1
        self.lapsPerDay = -1
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init()
    }
    override var description: String {
        return String(format:"name: \(name)\npoints: \(points)\nlength:\(length)\nlapsPerDay:\(lapsPerDay)")
    }
}
