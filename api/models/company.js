import mongoose from 'mongoose'

const companySchema = mongoose.Schema(
  {
    companyName: { type: String, required: true },
    description: { type: String, required: true },
    contact: { type: String, required: true },
    address: { type: String, required: true },
    city: { type: String, required: true },
    province: { type: String, required: true },
    country: { type: String, required: true },
    email: { type: String, required: true },
    password: { type: String, required: true },
    companyFields: [String],
    id: { type: String },
  },
  { timestamps: true }
)

const CompanyModel = mongoose.model('Company', companySchema)

export default CompanyModel
