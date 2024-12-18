import mongoose from "mongoose";
import { type } from "os";

const studentProgressSchema = new mongoose.Schema({
    uid: {
        type: String,
        required: true, // Only ensures the field is not empty
        ref :"Student"
      },
    courcename:{
        type:String,
        required:true
    },
    percentage: {
        type: Number,
        required: true,
        min: 0,
        max: 100
    }
}
);

const StudentProgress = mongoose.model('StudentProgress', studentProgressSchema);

export default StudentProgress;
