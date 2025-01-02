// models/Course.js
import mongoose from 'mongoose';
const courseSchema = new mongoose.Schema({
    title: {
         type: String,
         required: true
         },
    image: { 
         type: String,
         required: true 
         },
         category   : { 
          type: String,
          required: true 
          },
    description: {
         type: String,
         required: true 
         },
    price: { 
        type: Number,
        required: true 
         },
    videoLectures: { 
        type: [String], 
        required: true 
    },
    files: {
        type: [String],
        required: true
         },
         // Reference to teacher model
    uid: {
         type: String,
         required: true, 
         ref: 'teacher' 
        },
        mcid: { 
          type: String,
      }, 
});

export default mongoose.model('Course', courseSchema);
