import mongoose from 'mongoose';

const userSchema = new mongoose.Schema({
    name: { 
        type: String, 
        required: true 
    },
    email: { 
        type: String, 
        required: true, 
        unique: true 
    },
    uid: { 
        type: String, 
        required: true, 
        unique: true 
    },
    mcid: { 
        type: String, 
        required: true 
    },
    verify: { 
        type: Boolean, 
        default: false 
    },
    earn:{
        type:String,
        default:"0"
    }
});

export default mongoose.model('teacher', userSchema);
