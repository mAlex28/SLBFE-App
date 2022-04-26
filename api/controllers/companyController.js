import mongoose from 'mongoose'
import bcrypt from 'bcryptjs'
import jwt from 'jsonwebtoken'

import CompanyModel from '../models/company.js'

export const getAllCompanies = async (req, res) => {
  const { page } = req.query

  try {
    // paging the response
    const LIMIT = 8
    const startIndex = (Number(page) - 1) * LIMIT

    const total = await CompanyModel.countDocuments()
    const companies = await CompanyModel.find()
      .sort({ _id: -1 })
      .limit(LIMIT)
      .skip(startIndex)

    res.json({
      data: companies,
      currentPage: Number(page),
      numberOfPages: Math.ceil(total / LIMIT),
    })
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

export const signin = async (req, res) => {
  const { email, password } = req.body

  try {
    const existingUser = await CompanyModel.findOne({ email })
    if (!existingUser)
      return res.status(404).json({ message: "User doesn't exist" })

    const isPasswordCorrect = await bcrypt.compare(
      password,
      existingUser.password
    )
    if (!isPasswordCorrect)
      return res.status(404).json({ message: 'Invalid credentials' })

    const token = jwt.sign(
      { email: existingUser.email, id: existingUser._id },
      'test',
      { expiresIn: '5h' }
    )

    res.status(200).json({
      result: existingUser,
      token,
    })
  } catch (error) {
    res.status(500).json({ message: 'Something went wrong' })
  }
}

export const signup = async (req, res) => {
  const {
    companyName,
    description,
    contact,
    address,
    city,
    province,
    country,
    email,
    password,
    companyFields,
    confirmPassword,
  } = req.body

  try {
    const existingUser = await CompanyModel.findOne({ email })
    if (existingUser)
      return res.status(404).json({ message: 'User already exist' })

    if (password !== confirmPassword)
      return res.status(404).json({ message: "Passwords don't match" })

    const hashedPassword = await bcrypt.hash(password, 12)

    const result = await CompanyModel.create({
      companyName,
      description,
      contact,
      address,
      city,
      province,
      country,
      email,
      password: hashedPassword,
      companyFields,
    })

    const token = jwt.sign({ email: result.email, id: result._id }, 'test', {
      expiresIn: '5h',
    })

    res.status(200).json({
      result,
      token,
    })
  } catch (error) {
    res.status(500).json({ message: 'Something went wrong' })
  }
}

export const getCompanyByNameSearch = async (req, res) => {
  const { companyName } = req.query

  try {
    const company = await CompanyModel.find({ companyName })

    res.json({ data: company })
  } catch (error) {
    res.status(404).json({ message: error.message })
  }
}

export const getCompanyByQualificationSearch = async (req, res) => {
  const { searchQuery, companyFields } = req.query

  try {
    const title = new RegExp(searchQuery, 'i')

    const company = await CompanyModel.find({
      $or: [{ title }, { companyFields: { $in: companyFields.split(',') } }],
    })

    res.json({ data: company })
  } catch (error) {
    res.status(404).json({ message: error.message })
  }
}
