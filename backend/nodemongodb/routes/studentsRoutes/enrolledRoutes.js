import express from 'express';
import {
  getAllByUid,
  getOneByUid,
  createRecord,
  updateById,
  deleteById,
} from '../../controllers/studentsController/courceEnrolled.js';

const router = express.Router();

// Get all records by UID
router.get('/getall/:uid', getAllByUid);

// Get one record by UID
router.get('/getone/:uid', getOneByUid);

// Create a new record (by ID)
router.post('/create', createRecord);

// Update a record by ID
router.put('/update/:id', updateById);

// Delete a record by ID
router.delete('/delete/:id', deleteById);

export default router;
