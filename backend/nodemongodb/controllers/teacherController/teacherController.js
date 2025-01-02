import Course from '../../models/teacherModels/courcesModel.js';
import User from '../../models/teacherModels/teacherModel.js';

// Create User
export const createUser = async (req, res) => {
    const { name, email, uid, mcid, verify } = req.body;
    try {
        const newUser = new User({ name, email, uid, mcid, verify });
        if (!newUser.mcid) {
            return res.status(500).send({
                success: false,
                message: "User already registered"
            });
        }
        await newUser.save();
        res.status(201).json(newUser);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};

// Read All Users
export const getAllUsers = async (req, res) => {
    try {
        const users = await User.find();
        res.json(users);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// Read Single User
export const getUserById = async (req, res) => {
    try {
        const user = await User.findOne({ uid: req.params.uid });
        if (!user) {
            console.log("User not found with UID:", req.params.uid);
            return res.status(404).json({ message: 'User not found' });
        }
        console.log("User found:", user);
        res.json(user);
    } catch (error) {
        console.error("Error fetching user:", error);
        res.status(500).json({ message: error.message });
    }
};

export const getByEmail = async  (req, res) => {
    const { email } = req.body;
    try {
      const user = await User.findOne({ email });
      if (user) {
        res.status(200).json({ success: true });
      } else {
        res.status(404).json({ success: false });
      }
    } catch (error) {
      res.status(500).json({ success: false, message: 'Server error', error });
    }
  };


// Get Teacher with Courses by UID
export const getUserWithCourses = async (req, res) => {
    try {
        const user = await User.findOne({ uid: req.params.uid });
        
        if (!user) {
            console.log("Teacher not found with UID:", req.params.uid);
            return res.status(404).json({ message: 'Teacher not found' });
        }

        // Find all courses posted by this teacher
        const courses = await Course.find({ uid: req.params.uid });
        res.json({ teacher:user, courses }); // Respond with both teacher and their courses
    } catch (error) {
        console.error("Error fetching teacher and courses:", error);
        res.status(500).json({ message: error.message });
    }
};

// Update User
export const updateUser = async (req, res) => {
    try {
        const user = await User.findOneAndUpdate(
            { uid: req.params.uid },
            req.body,
            { new: true }
        );
        if (!user) return res.status(404).json({ message: 'User not found' });
        res.json(user);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};

// Delete User
export const deleteUser = async (req, res) => {
    try {
        const user = await User.findOneAndDelete({ uid: req.params.uid });
        if (!user) return res.status(404).json({ message: 'User not found' });
        res.json({ message: 'User deleted successfully' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
