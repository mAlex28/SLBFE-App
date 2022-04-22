import mongoose from 'mongoose'

const complainSchema = mongoose.Schema(
  {
    userId: { type: String, required: true },
    complainTitle: { type: String, required: true },
    complainText: { type: String, required: true },
    email: { type: String, required: true },
  },
  { timestamps: true }
)

const ComplainModel = mongoose.model('Complains', complainSchema)

export default ComplainModel
