import UIKit


struct Point {
    let x : Int
    let y : Int
    
    func points(inRange range: Int = 0) -> [Point]{
        var results = [Point]()
        
        let lowerBoundOfXRange = x - range
        let upperBoundOfXRange = x + range
        
        let lowerBoundOfYRange = y - range
        let upperBoundOfYRange = y + range
        
        for xCoordinate in lowerBoundOfXRange ... upperBoundOfXRange {
            for yCoordinate in  lowerBoundOfYRange...upperBoundOfYRange {
                let pointToAdd = Point(x: xCoordinate, y: yCoordinate)
                results.append(pointToAdd)
            }
        }
        
        return results
    }
}


var pointInitializer = Point(x: 0, y: 0)
pointInitializer.points()


class Enemy {
    
    var life : Int = 2
    let position : Point
    
    init(x : Int  , y : Int) {
        self.position = Point(x : x , y : y)
    }
    
    func decreaseLife(by factor : Int){
        life -= factor
    }
}

class SuperEnemy : Enemy {
    var isSuper : Bool = true
    
    override init(x: Int, y: Int) {
        super.init(x: x, y: y)
        self.life = 50
    }
}


class Tower {
    let position : Point
    var range : Int = 1
    var strength : Int = 1
    
    init(x : Int , y : Int) {
        self.position = Point(x: x, y: y)
    }
    
    func fire(at enemy : Enemy){
        if isInRange(of: enemy) {
            enemy.decreaseLife(by: strength)
            print("Pum pum")
        }else{
            print("Darn! Out of range")
        }
    }
    
    func isInRange(of enemy : Enemy) -> Bool {
        let availablePositions = position.points(inRange: range)
        for point in availablePositions {
            if point.x == enemy.position.x && point.y == enemy.position.y {
                return true;
            }
        }
        
        return false;
    }
}

class LaserTower : Tower {
    override init(x: Int, y: Int) {
        super.init(x: x, y: y)
        self.range = 100
        self.strength = 100
    }
    
    override func fire(at enemy: Enemy) {
        while enemy.life >= 0 {
            enemy.decreaseLife(by: strength)
        }
        
        print("Enenmy Destroyed")
    }
    
}

let tower = Tower(x: 0, y: 0)
let enemy = Enemy(x: 2, y: 2)
let superEnemy = SuperEnemy(x: 10, y: 10)
let laserTower = LaserTower(x: 2, y: 2)
laserTower.strength

tower.fire(at: enemy)

