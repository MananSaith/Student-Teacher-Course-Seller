import CourceEnrolled from '../../models/studentModel/courceEnrolledModel.js';

// Get all records by UID
export const getAllByUid = async (req, res) => {
  const { uid } = req.params;
  try {
    const records = await CourceEnrolled.find({ uid });
    if (records.length === 0) {
      return res.status(404).json({ message: 'No records found for the provided UID' });
    }
    res.status(200).json(records);
  } catch (error) {
    res.status(500).json({ message: `Error fetching records by UID: ${error.message}` });
  }
};

// Get one record by UID
export const getOneByUid = async (req, res) => {
  const { uid } = req.params;
  try {
    const record = await CourceEnrolled.findOne({ uid });
    if (!record) {
      return res.status(404).json({ message: 'No record found for the provided UID' });
    }
    res.status(200).json(record);
  } catch (error) {
    res.status(500).json({ message: `Error fetching record by UID: ${error.message}` });
  }
};

export const createRecord = async (req, res) => {
  const { uid, objectId } = req.body;

  try {
    // Directly create the new record
    const newRecord = await CourceEnrolled.create({ uid, objectId });
    res.status(201).json(newRecord);
  } catch (error) {
    console.error("Error creating record:", error);
    res.status(500).json({ message: `Error creating record: ${error.message}` });
  }
};



// Update a record by ID
export const updateById = async (req, res) => {
  const { id } = req.params;
  const updateData = req.body;
  try {
    const updatedRecord = await CourceEnrolled.findByIdAndUpdate(
      id,
      { $set: updateData },
      { new: true, runValidators: true }
    );
    if (!updatedRecord) {
      return res.status(404).json({ message: 'No record found with the provided ID' });
    }
    res.status(200).json(updatedRecord);
  } catch (error) {
    res.status(500).json({ message: `Error updating record: ${error.message}` });
  }
};

// Delete a record by ID
export const deleteById = async (req, res) => {
  const { id } = req.params;
  try {
    const deletedRecord = await CourceEnrolled.findByIdAndDelete(id);
    if (!deletedRecord) {
      return res.status(404).json({ message: 'No record found with the provided ID' });
    }
    res.status(200).json({ message: 'Record deleted successfully', deletedRecord });
  } catch (error) {
    res.status(500).json({ message: `Error deleting record: ${error.message}` });
  }
};
