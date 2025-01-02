import { Router } from 'express';
import {
    createStudent,
    deleteStudent,
    getStudentByUid,
    getByEmail,
    getStudents,
    updateStudent
} from '../../controllers/studentsController/studentsInfo.js';

const router = Router();

router.post('/create', createStudent);
router.get('/read', getStudents);
router.post('/email', getByEmail);
router.get('/single/:uid', getStudentByUid); // Get student by UID
router.put('/update/:uid', updateStudent); // Update student by UID
router.delete('/delete/:uid', deleteStudent); // Delete student by UID

export default router;
