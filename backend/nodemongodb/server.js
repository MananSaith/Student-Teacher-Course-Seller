import bodyParser from 'body-parser';
import path from 'path';
import cors from 'cors';
import express from 'express';
import mongoose from 'mongoose';
import courseRoutes from './routes/teacherRoutes/corceRoutes.js';
import quizRoutes from './routes/teacherRoutes/quizRoutes.js';
import teacherRoutes from './routes/teacherRoutes/teacherRoutes.js';
// for students 
import studentRoutes from './routes/studentsRoutes/studentsInfoRoutes.js';
import totalAmountRoutes from './routes/studentsRoutes/totalAmountRoutes.js';
import enrolledRoutes from './routes/studentsRoutes/enrolledRoutes.js';
import  StudentProgressRoutes from './routes/studentsRoutes/ProgressRoutes.js';

//app humara instance hai express ka 
const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
// jo humarqa pass reqyuest ati hai wo row form ma hoti hai 
app.use(bodyParser.json());

// Connect to MongoDB
mongoose.connect("mongodb://localhost:27017/prepilly").then(() => {
console.log('MongoDB connected Successfully');
}).catch(err => {
    console.error('MongoDB connection error:', err);
});

// Use Routes
// Teacher Routes
app.use('/api/teacher', teacherRoutes);
app.use('/api/quizzes', quizRoutes);
app.use('/api/courses', courseRoutes);

//Students Routes
app.use('/api/studentsInfo', studentRoutes);
app.use('/api/totalAmount', totalAmountRoutes);
app.use('/api/CourceEnrolled', enrolledRoutes);
app.use('/api/student-progress', StudentProgressRoutes);
// Serve static files
app.use('/uploads', express.static(path.join(path.resolve(), 'uploads')));

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});