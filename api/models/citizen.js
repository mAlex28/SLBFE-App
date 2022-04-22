import mongoose from 'mongoose'

const citizenSchema = mongoose.Schema(
  {
    nic: { type: String, required: true },
    profilePic: String,
    name: { type: String, required: true },
    age: { type: String, required: true },
    description: { type: String, required: true },
    contact: { type: String, required: true },
    address: { type: String, required: true },
    postalCode: { type: String, required: true },
    city: { type: String, required: true },
    province: { type: String, required: true },
    location: {
      latitude: { type: String, required: true },
      longitude: { type: String, required: true },
    },
    profession: { type: String, required: true },
    email: { type: String, required: true },
    qualifications: [String],
    password: { type: String, required: true },
    birthCertificate: String,
    cv: String,
    passport: String,
    isVerified: {
      type: Boolean,
      default: false,
    },
    id: { type: String },
  },
  { timestamps: true }
)

const CitizenModel = mongoose.model('Citizen', citizenSchema)

export default CitizenModel
