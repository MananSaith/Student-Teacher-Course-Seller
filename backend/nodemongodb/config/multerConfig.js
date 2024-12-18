// config/multerConfig.js
import multer from 'multer';
import path from 'path';

// Set storage engine
const storage = multer.diskStorage({
    destination: './uploads/',
    filename: (req, file, cb) => {
        cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
    }
});

// Initialize upload
const upload = multer({
    storage: storage,
    limits: { fileSize: 100000000}, 
    fileFilter: (req, file, cb) => {
        checkFileType(file, cb);
    }
}).fields([
    { name: 'image', maxCount: 1 },
    { name: 'videoLectures', maxCount: 10 },
    { name: 'files', maxCount: 10 }
]);

// Check file type
function checkFileType(file, cb) {
    const filetypes = /jpeg|jpg|png|gif|mp4|avi|mkv|pdf|doc|pptx|docx/;
    const extname = filetypes.test(path.extname(file.originalname).toLowerCase());
    const mimetype = filetypes.test(file.mimetype);

    if (mimetype && extname) {
        return cb(null, true);
    } else {
        cb('Error: Files Only!');
    }
}

export default upload;
