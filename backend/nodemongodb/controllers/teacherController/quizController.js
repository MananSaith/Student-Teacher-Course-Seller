// controllers/quizController.js
import Quiz from '../../models/teacherModels/Quiz.js';


// Create a new quiz for a specific course
export const createQuiz = async (req, res) => {
    const { title, questions, courseId } = req.body;

    try {
        const newQuiz = new Quiz({ title, courseId, questions });
        const savedQuiz = await newQuiz.save();
        res.status(201).send({
            success: true,
            message: "Quiz created successfully",
            savedQuiz
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

//find by course id 

// Get quizzes by courseId
export const getQuizzesByCourseId = async (req, res) => {
    const { courseId } = req.params;

    try {
        const quizzes = await Quiz.find({ courseId }).populate('courseId', 'title');
        
        if (!quizzes || quizzes.length === 0) {
            return res.status(404).json({ success: false, message: 'No quizzes found for this course' });
        }

        res.status(200).json({
            success: true,
            quizzes
        });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
};


// Get all quizzes

export const getAllQuizzes = async (req, res) => {
    try {
        const quizzes = await Quiz.find().populate('courseId', 'name email'); // Change 'id' to 'courseId'
        res.status(200).json({ quizzes });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};


// Get quizzes by teacher uid and courseId
export const getQuizzesByTeacherAndCourse = async (req, res) => {
    const { uid, courseId } = req.params;
    try {
        const quizzes = await Quiz.find({ courseId })
            .populate({
                path: 'courseId',
                match: { uid },  // Filter by teacher UID in the Course reference
                select: 'title uid'
            });

        // Filter quizzes where the courseId matches the teacher UID
        const filteredQuizzes = quizzes.filter(quiz => quiz.courseId);
        
        if (filteredQuizzes.length === 0) return res.status(404).json({ message: 'No quizzes found for this teacher and course' });
        
        res.status(200).json(filteredQuizzes);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
