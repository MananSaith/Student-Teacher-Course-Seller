import { Router } from 'express';
import {
    createQuiz,
    getAllQuizzes,
    getQuizzesByTeacherAndCourse,
    getQuizzesByCourseId
} from '../../controllers/teacherController/quizController.js';
const router = Router();

// Route to create a new quiz for a specific course
router.post('/quizzes', createQuiz);
router.get('/getall', getAllQuizzes)
// Route to get quizzes by teacher uid and courseId // one teacher cource related quiz 
router.get('/teacher/:uid/course/:courseId', getQuizzesByTeacherAndCourse);
router.get('/course/:courseId', getQuizzesByCourseId);

export default router;
