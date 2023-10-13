//
//  main.swift
//  CollegeAdmin
//
//  Created by Burhanuddin Jinwala on 10/13/23.
//

import Foundation

//Defining Classes for all entities
class Course {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Program {
    var name: String
    var courses: [Course] = []
    init(name: String) {
        self.name = name
    }
}

class College {
    var name: String
    var programs: [Program] = []
    init(name: String) {
        self.name = name
    }
}

struct Admin {
    var email: String
    var password: String
}

//display options with option number
func displayOptions(_ options: [String]) {
    for (index, option) in options.enumerated() {
        print("\(index + 1). \(option)")
    }
}

// login fuction
func login(admin: Admin) -> Bool {
    print("Enter email:")
    let email = readLine() ?? ""
    print("Enter password:")
    let password = readLine() ?? ""
    return admin.email == email && admin.password == password
}

//Display all the colleges function
func displayColleges(colleges: [College]) {
    print("Colleges:")
    for (index, college) in colleges.enumerated() {
        print("\(index + 1). \(college.name)")
    }
}

//Select College functions
func selectCollege(colleges: inout [College]) {
    displayColleges(colleges: colleges)
    print("Enter the number of the college you want to manage programs for:")
    if let choice = readLine(), let index = Int(choice), index > 0, index <= colleges.count {
        manageProgramsMenu(programs: &colleges[index - 1].programs)
    } else {
        print("Invalid choice. Please enter a number corresponding to a college.")
        selectCollege(colleges: &colleges)
    }
}

//Add new college function
func addCollege(colleges: inout [College]) {
    print("Enter the name of the new college:")
    if let newName = readLine(), !newName.isEmpty {
        colleges.append(College(name: newName))
        print("College added successfully!")
    } else {
        print("Invalid input. Please enter a non-empty name.")
    }
}

//Update College function
func updateCollege(colleges: inout [College]) {
    displayColleges(colleges: colleges)
    print("Enter the number of the college you want to update:")
    if let choice = readLine(), let index = Int(choice), index > 0, index <= colleges.count {
        print("Enter the new name of the college:")
        if let newName = readLine(), !newName.isEmpty {
            colleges[index - 1].name = newName
            print("College updated successfully!")
        } else {
            print("Invalid input. Please enter a non-empty name.")
        }
    } else {
        print("Invalid choice. Please enter a number corresponding to a college.")
    }
}


//Delete college with no programs function
func deleteCollege(colleges: inout [College]) {
    displayColleges(colleges: colleges)
    print("Enter the number of the college you want to delete:")
    if let choice = readLine(), let index = Int(choice), index > 0, index <= colleges.count {
        if colleges[index - 1].programs.isEmpty {
            colleges.remove(at: index - 1)
            print("College deleted successfully!")
        } else {
            print("Cannot delete a college with 1 or more programs.")
        }
    } else {
        print("Invalid choice. Please enter a number corresponding to a college.")
    }
}

//Display all the programs in selected college function
func displayPrograms(programs: [Program]) {
    print("Programs:")
    for (index, program) in programs.enumerated() {
        print("\(index + 1). \(program.name)")
    }
}

//add new program function
func addProgram(programs: inout [Program]) {
    print("Enter the name of the new program:")
    if let newName = readLine(), !newName.isEmpty {
        programs.append(Program(name: newName))
        print("Program added successfully!")
    } else {
        print("Invalid input. Please enter a non-empty name.")
    }
}

//update program function
func updateProgram(programs: inout [Program]) {
    displayPrograms(programs: programs)
    print("Enter the number of the program you want to update:")
    if let choice = readLine(), let index = Int(choice), index > 0, index <= programs.count {
        print("Enter the new name of the program:")
        if let newName = readLine(), !newName.isEmpty {
            programs[index - 1].name = newName
            print("Program updated successfully!")
        } else {
            print("Invalid input. Please enter a non-empty name.")
        }
    } else {
        print("Invalid choice. Please enter a number corresponding to a program.")
    }
}

//Delete program with no courses function
func deleteProgram(programs: inout [Program]) {
    displayPrograms(programs: programs)
    print("Enter the number of the program you want to delete:")
    if let choice = readLine(), let index = Int(choice), index > 0, index <= programs.count {
        if programs[index - 1].courses.isEmpty {
            programs.remove(at: index - 1)
            print("Program deleted successfully!")
        } else {
            print("Cannot delete a program with 1 or more courses.")
        }
    } else {
        print("Invalid choice. Please enter a number corresponding to a program.")
    }
}

//select program function
func selectProgram(programs: inout [Program]) {
    while true {
        displayPrograms(programs: programs)
        print("Enter the number of the program you want to manage courses for (or type 'back' to go back):")
        if let choice = readLine() {
            if choice.lowercased() == "back" {
                print("Going back...")
                return
            } else if let index = Int(choice), index > 0, index <= programs.count {
                manageCoursesMenu(courses: &programs[index - 1].courses)
            } else {
                print("Invalid choice. Please enter a number corresponding to a program or 'back' to go back.")
            }
        }
    }
}

//Display all the courses in selected program functions
func displayCourses(courses: [Course]) {
    print("Courses:")
    for (index, course) in courses.enumerated() {
        print("\(index + 1). \(course.name)")
    }
}

//Add ne course function
func addCourses(courses: inout [Course]) {
    print("Enter the name of the new course:")
    if let newName = readLine(), !newName.isEmpty {
        courses.append(Course(name: newName))
        print("course added successfully!")
    } else {
        print("Invalid input. Please enter a non-empty name.")
    }
}

//delete course function
func deleteCourses(courses: inout [Course]) {
    displayCourses(courses: courses)
    print("Enter the number of the course you want to delete:")
    if let choice = readLine(), let index = Int(choice), index > 0, index <= courses.count {
            courses.remove(at: index - 1)
            print("Course deleted successfully!")
        
    } else {
        print("Invalid choice. Please enter a number corresponding to a course.")
    }
}




//Login Menu of start program
func startMenu(admin: Admin, colleges: inout [College]) {
    print("Welcome to the University Admin System")
    displayOptions(["Login", "Exit"])
    let choice = readLine() ?? ""
    switch choice {
    case "1":
        if login(admin: admin) {
            manageCollegesMenu(colleges: &colleges)
        } else {
            print("Invalid credentials. Try again.")
            startMenu(admin: admin, colleges: &colleges)
        }
    case "2":
        print("Exiting...")
    default:
        print("Invalid choice. Try again.")
        startMenu(admin: admin, colleges: &colleges)
    }
}

//Manage college option menu function
func manageCollegesMenu(colleges: inout [College]) {
    while true {
    print("Select Option to Manage Colleges")
    displayOptions(["Display All Colleges", "Add a College", "Update a College", "Delete a College","Select College", "Go back"])
    let choice = readLine() ?? ""
    switch choice {
    case "1":
        displayColleges(colleges: colleges)
    case "2":
        addCollege(colleges: &colleges)
    case "3":
        updateCollege(colleges: &colleges)
    case "4":
        deleteCollege(colleges: &colleges)
    case "5":
        selectCollege(colleges: &colleges)
    case "6":
        print("Loging Out...")
        return
    default:
        print("Invalid choice. Try again.")
    }
    
    }
    
}

//Manage program options menu function
func manageProgramsMenu(programs: inout [Program]) {
    while true {
        print("Select Option to Manage Programs")
        displayOptions(["Display All Programs", "Add a Program", "Update a Program", "Delete a Program", "Select Program","Go back"])
        let choice = readLine() ?? ""
        switch choice {
        case "1":
            displayPrograms(programs: programs)
        case "2":
            addProgram(programs: &programs)
        case "3":
            updateProgram(programs: &programs)
        case "4":
            deleteProgram(programs: &programs)
        case "5":
            selectProgram(programs: &programs)
        case "6":
            print("Going back...")
            return
        default:
            print("Invalid choice. Try again.")
        }
    }
}

//manage courses option menu function
func manageCoursesMenu(courses: inout [Course]) {
    while true {
        print("Manage Courses")
        displayOptions(["Display All Courses", "Add New Course", "Delete Course", "Go back"])
        let choice = readLine() ?? ""
        switch choice {
        case "1":
            displayCourses(courses: courses)
        case "2":
            addCourses(courses: &courses)
        case "3":
            deleteCourses(courses: &courses)
        case "4":
            print("Going back...")
            return
        default:
            print("Invalid choice. Try again.")
        }
    }
}



// intitially created college, program, and course
let admin = Admin(email: "admin@neu.edu", password: "admin123")

let initialCourse = Course(name: "Smartphone Based Web Development")
let initialProgram = Program(name: "Information Systems")
initialProgram.courses.append(initialCourse)
let initialCollege = College(name: "College of Engineering")
initialCollege.programs.append(initialProgram)

var colleges = [initialCollege]

startMenu(admin: admin, colleges: &colleges)

