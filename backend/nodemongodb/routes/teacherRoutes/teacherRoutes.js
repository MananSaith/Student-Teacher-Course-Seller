// routes/teacherRoutes.js
import express from 'express';
import {
    createUser,
    deleteUser,
    getAllUsers,
    getUserById,
    getByEmail,
    getUserWithCourses,
    updateUser,
} from '../../controllers/teacherController/teacherController.js';

const router = express.Router();

// CRUD routes for users
router.post('/create', createUser);
//read all teacher available in DB 
router.get('/read', getAllUsers);
// get single teacher by uid 
router.get('/:uid', getUserById);
// get teacher by email
router.post('/email', getByEmail);
// get all teacher and his cources available in DB 
router.get('/:uid/courses', getUserWithCourses);

// update and delete 
router.put('/update/:uid', updateUser);
router.delete('/delete/:uid', deleteUser);

export default router;
