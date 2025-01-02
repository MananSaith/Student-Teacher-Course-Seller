import Student from '../../models/studentModel/studentsInfo.js';

// Create a new student
export const createStudent = async (req, res) => {
  try {
    const student = new Student(req.body);
    await student.save();
    res.status(201).json(student);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Get all students
export const getStudents = async (req, res) => {
  try {
    const students = await Student.find();
    res.status(200).json(students);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Get a single student by UID
export const getStudentByUid = async (req, res) => {
  try {
    const student = await Student.findOne({ uid: req.params.uid });
    if (!student) return res.status(404).json({ error: 'Student not found' });
    res.status(200).json(student);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

export const getByEmail = async  (req, res) => {
    const { email } = req.body;
    try {
      const user = await Student.findOne({ email });
      if (user) {
        res.status(200).json({ success: true });
      } else {
        res.status(404).json({ success: false });
      }
    } catch (error) {
      res.status(500).json({ success: false, message: 'Server error', error });
    }
  };

// Update a student
export const updateStudent = async (req, res) => {
  try {
    const student = await Student.findOneAndUpdate({ uid: req.params.uid }, req.body, { new: true });
    if (!student) return res.status(404).json({ error: 'Student not found' });
    res.status(200).json(student);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Delete a student
export const deleteStudent = async (req, res) => {
  try {
    const student = await Student.findOneAndDelete({ uid: req.params.uid });
    if (!student) return res.status(404).json({ error: 'Student not found' });
    res.status(200).json({ message: 'Student deleted successfully' });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};
