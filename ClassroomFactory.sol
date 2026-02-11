// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./StudentGradeSystem.sol";

/**
 * @title ClassroomFactory
 * @dev Factory contract for creating and managing multiple Student contracts
 * @notice This contract allows a teacher to deploy and manage multiple students in a classroom
 * @author Saviour VexHappy
 */
contract ClassroomFactory {
    // State variables
    Student[] public listOfStudents;
    address public owner;
    
    // Events
    event StudentCreated(
        address indexed studentAddress,
        string name,
        uint256 indexed id,
        uint256 index,
        uint256 timestamp
    );
    
    event GradeAdded(
        uint256 indexed studentIndex,
        string subject,
        uint256 grade,
        uint256 timestamp
    );
    
    /**
     * @dev Constructor sets the contract deployer as the owner (teacher)
     */
    constructor() {
        owner = msg.sender;
    }
    
    /**
     * @dev Modifier to restrict function access to owner only
     * @notice Reverts if caller is not the owner
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }
    
    /**
     * @dev Creates a new Student contract and adds it to the classroom
     * @param _name The name of the student
     * @param _id The unique ID of the student
     * @notice Only the owner (teacher) can create students
     * @notice Emits a StudentCreated event upon success
     */
    function createStudent(string memory _name, uint256 _id) public onlyOwner {
        Student student = new Student(_name, _id);
        listOfStudents.push(student);
        
        emit StudentCreated(
            address(student),
            _name,
            _id,
            listOfStudents.length - 1,
            block.timestamp
        );
    }
    
    /**
     * @dev Retrieves a Student contract by its index
     * @param _index The position of the student in the array (0-based)
     * @return The Student contract at the specified index
     * @notice Reverts if index is out of bounds
     */
    function getStudent(uint256 _index) public view returns(Student) {
        require(_index < listOfStudents.length, "Index Unavailable");
        return listOfStudents[_index];
    }
    
    /**
     * @dev Gets a grade for a specific student and subject
     * @param _studentIndex The position of the student in the array
     * @param _subject The name of the subject (e.g., "Math", "Science")
     * @return The grade for that subject (0-100)
     * @notice Reverts if student index is out of bounds or subject not found
     */
    function getStudentGrade(uint256 _studentIndex, string calldata _subject) 
        external 
        view 
        returns(uint256) 
    {
        require(_studentIndex < listOfStudents.length, "Index Unavailable");
        return listOfStudents[_studentIndex].getGrade(_subject);
    }
    
    /**
     * @dev Returns the total number of students in the classroom
     * @return The number of Student contracts created
     */
    function getStudentCount() public view returns(uint256) {
        return listOfStudents.length;
    }
    
    /**
     * @dev Adds or updates a grade for a specific student
     * @param _studentIndex The position of the student in the array
     * @param _subject The name of the subject
     * @param _grade The grade value (0-100)
     * @notice Only the owner (teacher) can add grades
     * @notice Reverts if student index is out of bounds
     * @notice Emits a GradeAdded event upon success
     */
    function addGradeToStudent(uint256 _studentIndex, string calldata _subject, uint256 _grade) 
        external 
        onlyOwner 
    {
        require(_studentIndex < listOfStudents.length, "Index Unavailable");
        listOfStudents[_studentIndex].addGrade(_subject, _grade);
        
        emit GradeAdded(
            _studentIndex,
            _subject,
            _grade,
            block.timestamp
        );
    }
    
    /**
     * @dev Gets information about a specific student
     * @param _studentIndex The position of the student in the array
     * @return name The student's name
     * @return id The student's ID
     * @notice Reverts if student index is out of bounds
     */
    function getStudentInfo(uint256 _studentIndex) 
        public 
        view 
        returns(string memory name, uint256 id) 
    {
        require(_studentIndex < listOfStudents.length, "Index Unavailable");
        return listOfStudents[_studentIndex].getStudentInfo();
    }
    
    /**
     * @dev Calculates the average grade for a specific student
     * @param _studentIndex The position of the student in the array
     * @return The average grade across all subjects
     * @notice Reverts if student index is out of bounds or no grades exist
     */
    function getStudentAverage(uint256 _studentIndex) public view returns(uint256) {
        require(_studentIndex < listOfStudents.length, "Index Unavailable");
        return listOfStudents[_studentIndex].getAverageGrade();
    }
}
