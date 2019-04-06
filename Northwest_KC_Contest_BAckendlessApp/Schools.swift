//
//  Schools.swift
//  Northwest-KC-App
//
//  Created by rayaan on 14/03/19.
//  Copyright © 2019 Northwest. All rights reserved.
//

@objcMembers
class Schools:NSObject{
    
    let backendless = Backendless.sharedInstance()
    var schoolDataSource:IDataStore!
    var teamDataSource:IDataStore!
    private var schools:[School]
    
    static var shared = Schools()
    
    
    
    private convenience override init(){
        
        self.init(schools: [])
        self.schoolDataSource = backendless!.data.of(School.self)
        self.teamDataSource = backendless!.data.of(Team.self)
    }
    
    private init(schools: [School]) {
        self.schools = schools
        //        self.schools.append(School(name: "Northwest", coach: "Rodgers"))
    }
    
    func numSchools() -> Int{
        return schools.count
    }
    
    subscript(index:Int) -> School {
        return schools[index]
    }
    
    func add(school:School){
        schools.append(schoolDataSource.save(school) as! School)
    }
    
    
    func retreiveAllSchools(){
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setRelated(["teams"])
        queryBuilder!.setPageSize(100)
        Types.tryblock({() -> Void in
            self.schools = self.schoolDataSource.find(queryBuilder) as! [School]
            
        },
                       catchblock: {(fault) -> Void in print(fault ?? "Something has gone wrong  retreiveAllSchools()")}
        )
    }
    
    
    func delete(school:School){
        for i in 0 ..< schools.count {
            if schools[i] == school {
                schools.remove(at:i)
                let querybilder:DataQueryBuilder = DataQueryBuilder()
                querybilder.setRelated(["teams"])
                let schoolDetails = schoolDataSource.find(querybilder) as! [School]
                let teams = schoolDetails[i].teams
                for j in 0..<teams.count{
                    self.teamDataSource.remove(byId: teams[j].objectId)
                }
                self.schoolDataSource.remove(byId: school.objectId)
                break
            }
        }
    }
    
}

@objcMembers
class School:NSObject{
    var name: String?
    var coach: String?
    var teams: [Team] = []
    let backendless = Backendless.sharedInstance()
    var schoolDataSource:IDataStore!
    var teamDataSource:IDataStore!
    var objectId:String?
    func addTeam(_ team:Team){
        
        //        let team = Team()
        teams.append(teamDataSource.save(team) as! Team)
        let teamsIds = teamDataSource.findLast() as! Team
        schoolDataSource.addRelation("teams:Team:n", parentObjectId: self.objectId!, childObjects: [teamsIds.objectId!])
        
        
    }
    
    init(name: String?, coach: String?) {
        self.name = name
        self.coach = coach
        self.teams = []
    }
    
    private override init() {
        schoolDataSource = backendless!.data.of(School.self)
        teamDataSource = backendless!.data.of(Team.self)
    }
    
    static func == (lhs: School, rhs: School) -> Bool {
        return lhs.name == rhs.name && lhs.coach == rhs.coach && lhs.teams == rhs.teams
    }
}


@objcMembers
class Team : NSObject {
    var backendless = Backendless.sharedInstance()
    var teamDataStore:IDataStore!
    
    var name:String?
    var student01:String?
    var student02:String?
    var student03:String?
    
    var objectId:String?
    
    init(name:String?, student01:String?, student02:String?, student03:String?){
        self.name=name
        self.student01=student01
        self.student02=student02
        self.student03=student03
    }
    
    private override init(){
        teamDataStore = backendless!.data.of(Team.self)
    }
    
}
