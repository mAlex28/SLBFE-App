import mongoose from 'mongoose'
import bcrypt from 'bcryptjs'
import jwt from 'jsonwebtoken'

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
    const existingUser = await CitizenModel.findOne({ email })
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
    const existingUser = await CitizenModel.findOne({ email })
    if (existingUser)
      return res.status(404).json({ message: 'User already exist' })

    if (password !== confirmPassword)
      return res.status(404).json({ message: "Passwords don't match" })

    const hashedPassword = await bcrypt.hash(password, 12)

    const result = await CitizenModel.create({
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
