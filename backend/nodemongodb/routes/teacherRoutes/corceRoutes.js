// routes/courseRoutes.js
import express from 'express';
import {
    createCourse,
    deleteCourseById,
    getAllCourses,
    getCourseById,
    getCourseByIdAndUid,
    getCoursesByUid,
    updateCourseById
} from '../../controllers/teacherController/courceController.js';

const router = express.Router();

// CRUD routes for courses
router.post('/createCourse', createCourse);
// get all cources available in database
router.get('/getAllCourses', getAllCourses); 
/// get single cource without any reference available in database by id
router.get('/getCourseById/:id', getCourseById);
// Route to get a specific course by course ID and teacher UID
router.get('/teacher/:uid/:courseId', getCourseByIdAndUid);
/// get all cources acording to specific teacher uid
router.get('/teacher/:uid', getCoursesByUid);

//update and delete by id 
router.put('/updateCourseById/:id', updateCourseById);
router.delete('/deleteCourseById/:id', deleteCourseById);

export default router;
