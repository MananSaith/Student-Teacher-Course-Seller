// routes/totalAmountRoutes.js
import express from 'express';
import {
  createTotalAmount,
  getTotalAmount,
  updateTotalAmount,
  deleteTotalAmount
} from '../../controllers/studentsController/totalAmountController.js';

const router = express.Router();

router.post('/post', createTotalAmount);             // Create
router.get('/get/:uid', getTotalAmount);             // Read
router.put('/update/:uid', updateTotalAmount);          // Update
router.delete('/delete/:uid', deleteTotalAmount);       // Delete

export default router;
