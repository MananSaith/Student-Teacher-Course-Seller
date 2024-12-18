
import TotalAmount from '../../models/studentModel/totalAmountModel.js';
import Student from '../../models/studentModel/studentsInfo.js';

// Create a new total amount record
export const createTotalAmount = async (req, res) => {
  const { uid, amount } = req.body;

  try {
    // Check if the student exists
    const student = await Student.findOne({ uid });
    if (!student) return res.status(404).json({ message: 'Student not found' });

    const newTotalAmount = new TotalAmount({ uid, amount });
    await newTotalAmount.save();
    res.status(201).json(newTotalAmount);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

// Get a total amount record by UID
export const getTotalAmount = async (req, res) => {
  const { uid } = req.params;

  try {
    const totalAmount = await TotalAmount.findOne({ uid });
    if (!totalAmount) return res.status(404).json({ message: 'Record not found' });

    res.json(totalAmount);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Update a total amount record by UID
export const updateTotalAmount = async (req, res) => {
  const { uid } = req.params;
  const { amount } = req.body;

  try {
    const updatedTotalAmount = await TotalAmount.findOneAndUpdate(
      { uid },
      { amount },
      { new: true }
    );
    if (!updatedTotalAmount) return res.status(404).json({ message: 'Record not found' });

    res.json(updatedTotalAmount);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

// Delete a total amount record by UID
export const deleteTotalAmount = async (req, res) => {
  const { uid } = req.params;

  try {
    const deletedTotalAmount = await TotalAmount.findOneAndDelete({ uid });
    if (!deletedTotalAmount) return res.status(404).json({ message: 'Record not found' });

    res.json({ message: 'Record deleted successfully' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
