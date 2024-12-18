import mongoose from 'mongoose';

const studentSchema = new mongoose.Schema({
  uid: {
     type: String, 
     required: true, 
     unique: true 
    }, 
  name: {
     type: String,
     required: true
     },
  email: {
      type: String,
      required: true,
      unique: true
       },
   mcid:{
      type:String,
      require:true,
      unique:true
   }
});

const Student = mongoose.model('Student', studentSchema);

export default Student;
