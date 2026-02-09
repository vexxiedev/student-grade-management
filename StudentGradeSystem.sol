// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
 * @title TeacherManaged
 * @dev Base contract that provides teacher-only access control
 * @notice The deployer of the contract becomes the teacher
 */
contract TeacherManaged {
    address public teacher;
    
    constructor() {
        teacher = msg.sender;
    }
    
    /**
     * @dev Modifier to restrict function access to teacher only
     * @notice Reverts if caller is not the teacher
     */
    modifier onlyTeacher() {
        require(msg.sender == teacher, "Only Teacher Allowed!");
        _;
    }
}

/**
 * @title Student
 * @dev Contract for managing individual student grades
 * @notice Inherits teacher access control from TeacherManaged
 * @author Saviour VexHappy
 */
contract Student is TeacherManaged {
    // State variables
    string public studentName;
    uint256 public studentID;
    mapping(string => uint256) public gradeMap;
    string[] public subjectNames;

    /**
     * @dev Constructor to initialize student information
     * @param _name The name of the student
     * @param _id The unique ID of the student
     */
    constructor(string memory _name, uint256 _id) {
        studentName = _name;
        studentID = _id;
    }
    
    /**
     * @dev Add or update a grade for a subject
     * @param subject The name of the subject (e.g., "Math", "Science")
     * @param grade The grade value (0-100)
     * @notice Only the teacher can add grades
     * @notice If subject is new, it will be added to subjectNames array
     */
    function addGrade(string calldata subject, uint256 grade) public onlyTeacher {
        require(grade <= 100, "Grade must be between 0 and 100");

        // Only add subject to array if it's new (grade was 0)
        if(gradeMap[subject] == 0) {
            subjectNames.push(subject);
        }
        gradeMap[subject] = grade;
    }
    
    /**
     * @dev Get the grade for a specific subject
     * @param subject The name of the subject
     * @return The grade for that subject
     * @notice Returns 0 if subject doesn't exist or grade is actually 0
     */
    function getGrade(string calldata subject) public view returns(uint256) {
        uint256 grade = gradeMap[subject];
        require(grade > 0, "Grade not found for this subject");
        return grade;
    }
    
    /**
     * @dev Calculate and return the average grade across all subjects
     * @return The average grade
     * @notice Reverts if no grades have been added
     */
    function getAverageGrade() public view returns(uint256) {
        require(subjectNames.length > 0, "No grades added yet!");
        
        uint256 total = 0;
        for(uint256 i = 0; i < subjectNames.length; i++) {
            total += gradeMap[subjectNames[i]];
        }
        
        return total / subjectNames.length;
    }
    
    /**
     * @dev Get student information
     * @return name The student's name
     * @return id The student's ID
     */
    function getStudentInfo() external view returns(string memory name, uint256 id) {
        return (studentName, studentID);
    }
}
