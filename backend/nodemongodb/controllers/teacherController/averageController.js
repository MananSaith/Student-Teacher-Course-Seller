import Average from '../../models/teacherModels/average.js';
import Course from '../../models/teacherModels/courcesModel.js';

// Add new average
export const addAverage = async (req, res) => {
    try {
        const { courseId, value } = req.body;

        // Validate if course exists
        const course = await Course.findById(courseId);
        if (!course) {
            return res.status(404).json({ error: 'Course not found' });
        }

        // Create new average
        const average = new Average({
            courseId,
            value
        });

        await average.save();
        res.status(201).json(average);
    } catch (error) {
        res.status(500).json({ error: 'Server error: ' + error.message });
    }
};

// Get averages by course
export const getAverageByCourse = async (req, res) => {
    try {
        const { courseId } = req.params;
        
        // Find all averages for the course
        const averages = await Average.find({ courseId });
        
    
        const totalValue = averages.reduce((sum, avg) => sum + avg.value, 0);
        const overallAverage = totalValue / averages.length;

        res.json({
            courseId,
            averages,
            overallAverage: Math.round(overallAverage * 100) / 100
        });
    } catch (error) {
        res.status(500).json({ error: 'Server error: ' + error.message });
    }
};
