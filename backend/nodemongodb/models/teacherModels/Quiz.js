// models/Quiz.js
import mongoose from 'mongoose';

const questionSchema = new mongoose.Schema({
    question: { 
        type: String,
        required: true
    },
    options: [{ 
        type: String,
        required: true
    }],
    correctAnswer: { 
        type: Number, 
        required: true
    }
});

const quizSchema = new mongoose.Schema({
    title: { 
        type: String, 
        required: true 
    },
    courseId: {  // Link to the Course
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Course',
        required: true
    },
    questions: [questionSchema]
});

export default mongoose.model('Quiz', quizSchema);
