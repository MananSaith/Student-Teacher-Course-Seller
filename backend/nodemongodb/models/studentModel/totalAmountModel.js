// models/TotalAmount.js
import mongoose from 'mongoose';

const totalAmountSchema = new mongoose.Schema({
  uid: {
    type: String,
    ref: 'Student',  // Reference to the Student model
    required: true,
    unique: true
  },
  amount: {
    type: Number,
    required: true
  }
});

const TotalAmount = mongoose.model('TotalAmount', totalAmountSchema);

export default TotalAmount;
