# Student Grade Management System 📚

A Solidity smart contract system for managing student grades on the Ethereum blockchain.

## 👨‍💻 Author

**Saviour VexHappy**

Learning blockchain development with:
- [Cyfrin Updraft](https://updraft.cyfrin.io/)
- [Dev3pack](https://www.dev3pack.com/)

## 📝 Project Description

This project implements a decentralized student grade management system using Solidity smart contracts. It demonstrates fundamental blockchain concepts including:

- Contract inheritance
- Access control with custom modifiers
- Mappings and arrays for data storage
- Multiple return values
- Gas optimization techniques

## 🎯 Features

### Current Implementation (v1.0)

- **Teacher Access Control**: Only the contract deployer (teacher) can add/update grades
- **Student Records**: Store student name, ID, and grades for multiple subjects
- **Grade Management**: Add and retrieve grades for different subjects
- **Average Calculation**: Automatically calculate average grade across all subjects
- **Student Information**: Retrieve complete student details

### Coming Soon

- **Factory Pattern**: Deploy and manage multiple student contracts
- **Classroom Management**: Create entire classroom with multiple students
- **Enhanced Features**: Grade history, timestamps, and more

## 🏗️ Contract Structure

### TeacherManaged (Base Contract)
Provides access control functionality:
- `teacher` - Address of the teacher
- `onlyTeacher` - Modifier to restrict function access

### Student (Main Contract)
Inherits from TeacherManaged and implements:
- `studentName` - Student's name
- `studentID` - Unique student identifier
- `gradeMap` - Mapping of subjects to grades
- `subjectNames` - Array tracking all subjects

**Key Functions:**
- `addGrade(subject, grade)` - Add/update grade (teacher only)
- `getGrade(subject)` - View grade for a subject
- `getAverageGrade()` - Calculate average across all subjects
- `getStudentInfo()` - Get student name and ID

## 🚀 How to Use

### Deploying the Contract

1. Open [Remix IDE](https://remix.ethereum.org/)
2. Create a new file `StudentGradeSystem.sol`
3. Copy the contract code
4. Compile with Solidity version `^0.8.18`
5. Deploy the `Student` contract with:
   - `_name`: Student's name (string)
   - `_id`: Student's ID (number)

### Interacting with the Contract

**Adding Grades (Teacher Only):**
```solidity
addGrade("Math", 90);
addGrade("Science", 85);
addGrade("English", 92);
```

**Viewing Grades (Anyone):**
```solidity
getGrade("Math");          // Returns: 90
getAverageGrade();         // Returns: 89 (average of 90, 85, 92)
getStudentInfo();          // Returns: name and ID
```

## 📚 What I Learned

Building this project taught me:

- ✅ **Inheritance** - Using `is` keyword to inherit from base contracts
- ✅ **Modifiers** - Creating custom access control with `onlyTeacher`
- ✅ **Visibility** - Understanding `public`, `external`, `view` keywords
- ✅ **Data Locations** - Using `memory` and `calldata` appropriately
- ✅ **Loops** - Iterating through arrays to calculate averages
- ✅ **Multiple Returns** - Returning multiple values from functions
- ✅ **Mappings & Arrays** - Combining both for efficient data storage

## 🛠️ Technical Details

- **Solidity Version**: ^0.8.18
- **License**: MIT
- **Network**: Ethereum (testnet recommended for learning)

## ⚠️ Known Limitations

- Grade of 0 may cause issues when updating subjects (edge case)
- Integer division means averages are rounded down
- No events emitted (future enhancement)
- No way to remove subjects once added

## 🔮 Future Enhancements

- [ ] Factory contract for managing multiple students
- [ ] Events for grade updates
- [ ] Grade history with timestamps
- [ ] Letter grade conversion (A, B, C, D, F)
- [ ] Maximum/minimum grade tracking
- [ ] Subject removal functionality
- [ ] Multiple teacher support

## 📄 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

Special thanks to:
- **Patrick Collins** and the Cyfrin team for excellent Solidity education
- **Dev3pack** for additional learning resources
- The Ethereum developer community

---

**Note**: This is a learning project and should not be used in production without proper auditing and testing.

*Built with ❤️ while learning Solidity*
