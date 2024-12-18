import express from 'express';
import {
    createProgress,
    getProgressById,
    updateProgress,
    deleteProgress,
    getAllProgress,
    getProgressByUid
} from '../../controllers/studentsController/ProgressController.js';

const router = express.Router();

// Routes
router.post('/create', createProgress); // Create progress
router.get('/uid/:uid', getProgressByUid); // Get progress by UID (specific route)
router.get('/', getAllProgress); // Get all progress records
router.get('/:id', getProgressById); // Get progress by ID (generic route)
router.put('/:id', updateProgress); // Update progress
router.delete('/:id', deleteProgress); // Delete progress

export default router;
