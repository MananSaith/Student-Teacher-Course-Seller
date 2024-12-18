import mongoose from 'mongoose';

const courceEnrolledSchema = new mongoose.Schema({
  uid: {
    type: String,
    ref: 'Student', // Reference to the Student model
    required: true, // Only ensures the field is not empty
  },
  objectId: {
    type: String,
    ref: 'Course', // Reference to the Course model
    required: true, // Only ensures the field is not empty
  },
}, {
  timestamps: true, // Adds createdAt and updatedAt timestamps
});


const CourceEnrolled = mongoose.model('CourceEnrolled', courceEnrolledSchema);

export default CourceEnrolled;
