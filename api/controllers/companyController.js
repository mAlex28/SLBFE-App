import mongoose from 'mongoose'
import CompanyModel from '../models/company.js'

export const getAllCompanies = async (req, res) => {
  try {
    const companies = await CompanyModel.find()
    res.status(200).json(companies)
  } catch (error) {
    res.status(404).json({ message: error.message })
  }
}
export const getCompany = async (req, res) => {
  const { id } = req.params

  // to make sure the id is valid
  if (!mongoose.Types.ObjectId.isValid(id))
    return res.status(404).send('No company found')

  try {
    const company = await CompanyModel.findById(id)
    res.status(200).json(company)
  } catch (error) {
    res.status(404).json({ message: error.message })
  }
}
export const createCompany = async (req, res) => {
  const company = req.body
  const newCompany = new CompanyModel(company)

  try {
    await newCompany.save()
    res.status(201).json(newCompany)
  } catch (error) {
    res.status(409).json({ message: error.message })
  }
}
export const updateCompany = async (req, res) => {
  // renamed the id
  const { id: _id } = req.params
  const company = req.body

  // to make sure the id is valid
  if (!mongoose.Types.ObjectId.isValid(_id))
    return res.status(404).send('No company found')

  const updatedCompany = await CompanyModel.findByIdAndUpdate(
    _id,
    { ...company, _id },
    {
      new: true,
    }
  )
  res.json(updatedCompany)
}
export const deleteCompany = async (req, res) => {
  const { id } = req.params

  // to make sure the id is valid
  if (!mongoose.Types.ObjectId.isValid(id))
    return res.status(404).send('No company found')

  await CompanyModel.findByIdAndRemove(id)
}
export const getCompanyEmployees = async (req, res) => {}
