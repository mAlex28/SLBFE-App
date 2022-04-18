import mongoose from 'mongoose'

const companySchema = mongoose.Schema({
  name: String,
  employees: [String],
})

const CompanyModel = mongoose.model('Company', companySchema)

export default CompanyModel
