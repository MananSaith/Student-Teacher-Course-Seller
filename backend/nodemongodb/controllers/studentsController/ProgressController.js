import StudentProgress from '../../models/studentModel/ProgressModels.js'

// Create a new progress entry
export const createProgress = async (req, res) => {
    try {
        const { uid, percentage,courcename } = req.body;

        if (!uid || !percentage || !courcename) {
            return res.status(400).json({ error: 'Both uid and percentage are required.' });
        }

        const newProgress = new StudentProgress({ uid, percentage,courcename });
        await newProgress.save();
        res.status(201).json({ message: 'Progress created successfully', data: newProgress });
    } catch (err) {
        res.status(500).json({ error: 'Failed to create progress', details: err.message });
    }
};

// Get progress by ID
export const getProgressById = async (req, res) => {
    try {
        const progress = await StudentProgress.findById(req.params.id).populate('uid'); // Populate course details
        if (!progress) {
            return res.status(404).json({ error: 'Progress not found' });
        }
        res.status(200).json({ data: progress });
    } catch (err) {
        res.status(500).json({ error: 'Failed to fetch progress', details: err.message });
    }
};

// Update progress
export const updateProgress = async (req, res) => {
    try {
        const { percentage } = req.body;

        if (percentage == null) {
            return res.status(400).json({ error: 'Percentage is required.' });
        }

        const updatedProgress = await StudentProgress.findByIdAndUpdate(
            req.params.id,
            { percentage },
            { new: true, runValidators: true } // Return the updated document
        );

        if (!updatedProgress) {
            return res.status(404).json({ error: 'Progress not found' });
        }

        res.status(200).json({ message: 'Progress updated successfully', data: updatedProgress });
    } catch (err) {
        res.status(500).json({ error: 'Failed to update progress', details: err.message });
    }
};

// Get all progress records
export const getAllProgress = async (req, res) => {
    try {
        const progressList = await StudentProgress.find().populate('uid'); // Populate course details
        res.status(200).json({ data: progressList });
    } catch (err) {
        res.status(500).json({ error: 'Failed to fetch progress records', details: err.message });
    }
};


// Delete progress
export const deleteProgress = async (req, res) => {
    try {
        const deletedProgress = await StudentProgress.findByIdAndDelete(req.params.id);
        if (!deletedProgress) {
            return res.status(404).json({ error: 'Progress not found' });
        }
        res.status(200).json({ message: 'Progress deleted successfully' });
    } catch (err) {
        res.status(500).json({ error: 'Failed to delete progress', details: err.message });
    }
};

export const getProgressByUid = async (req, res) => {
    try {
        const { uid } = req.params;  // Extracting UID from the URL params

        if (!uid) {
            return res.status(400).json({ error: 'UID is required.' });
        }

        // Find progress records by UID, ensuring you're searching by the `uid` field, not _id
        const progressList = await StudentProgress.find({ uid });  // Match by uid (string), not _id

        if (progressList.length === 0) {
            return res.status(404).json({ error: 'No progress records found for the given UID.' });
        }

        res.status(200).json({ data: progressList });
    } catch (err) {
        res.status(500).json({ error: 'Failed to fetch progress records by UID', details: err.message });
    }
};
