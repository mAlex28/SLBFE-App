import mongoose from 'mongoose'

const officerSchema = mongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, required: true },
  password: { type: String, required: true },
  id: { type: String },
})

const OfficerModel = mongoose.model('Officer', officerSchema)

export default OfficerModel
