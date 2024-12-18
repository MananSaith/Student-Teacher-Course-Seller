// controllers/courseController.js
import upload from '../../config/multerConfig.js';
import Course from '../../models/teacherModels/courcesModel.js';

// Create a new course
    export const createCourse = async (req, res) => {
        upload(req, res, async (err) => {
        if (err) {
            return res.status(400).json({ message: err });
        }

        const { title, description, price, uid } = req.body;
        const image = req.files['image'] ? req.files['image'][0].path : null;
        const videoLectures = req.files['videoLectures'] ? req.files['videoLectures'].map(file => file.path) : [];
        const files = req.files['files'] ? req.files['files'].map(file => file.path) : [];

        try {
            const newCourse = new Course({ title, image, description, price, videoLectures, files, uid });
            const savedCourse = await newCourse.save(); 
            res.status(201).json(savedCourse);
        } catch (error) {
            res.status(500).json({ message: error.message });
        }
        });
    
};

// Get all courses
export const getAllCourses = async (req, res) => {
    try {
        const courses = await Course.find();
        res.status(200).json(courses);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};

// Get a single course by ID
export const getCourseById = async (req, res) => {
    try {
        const course = await Course.findById(req.params.id);
        if (!course) return res.status(404).json({ message: 'Course not found' });
        res.status(200).json(course);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};

// Get a specific course by course ID and teacher UID
export const getCourseByIdAndUid = async (req, res) => {
    try {
        const course = await Course.findOne({ _id: req.params.courseId, uid: req.params.uid });  // Find course by ID and teacher UID
        if (!course) {
            return res.status(404).json({ message: 'Course not found for this teacher' });
        }
        res.status(200).json(course);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};


// Get courses by Teacher UID
export const getCoursesByUid = async (req, res) => {
    try {
        const courses = await Course.find({ uid: req.params.uid }); // Find courses for the given teacher UID

        if (courses.length === 0) {
            return res.status(404).json({ message: 'No courses found for this teacher' });
        }

        res.status(200).json(courses); // Return only the courses
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};


// Update a course by ID
export const updateCourseById = async (req, res) => {
    try {
        const updatedCourse = await Course.findByIdAndUpdate(req.params.id, req.body, { new: true });
        if (!updatedCourse) return res.status(404).json({ message: 'Course not found' });
        res.status(200).json(updatedCourse);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};

// Delete a course by ID
export const deleteCourseById = async (req, res) => {
    try {
        const deletedCourse = await Course.findByIdAndDelete(req.params.id);
        if (!deletedCourse) return res.status(404).json({ message: 'Course not found' });
        res.status(200).json({ message: 'Course deleted successfully' });
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};
