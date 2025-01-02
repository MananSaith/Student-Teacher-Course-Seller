
import express from 'express';
import {addAverage , getAverageByCourse} from '../../controllers/teacherController/averageController.js';

const router = express.Router();
router.post('/add', addAverage);
router.get('/course/:courseId', getAverageByCourse);

export default router;