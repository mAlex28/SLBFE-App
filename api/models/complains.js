import mongoose from 'mongoose'

const complainSchema = mongoose.Schema(
  {
    creator: String,
    complainTitle: { type: String, required: true },
    complainText: { type: String, required: true },
    email: { type: String, required: true },
    createdAt: {
      type: Date,
      default: new Date(),
    },
  },
  { timestamps: true }
)

const ComplainModel = mongoose.model('Complains', complainSchema)

export default ComplainModel
