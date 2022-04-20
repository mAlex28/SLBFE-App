import mongoose from 'mongoose'
import bcrypt from 'bcryptjs'
import jwt from 'jsonwebtoken'

import CitizenModel from '../models/citizen.js'
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
    nic,
    profilePic,
    firstName,
    lastName,
    age,
    description,
    contact,
    address,
    postalCode,
    city,
    province,
    latitude,
    longitue,
    profession,
    email,
    qualifications,
    password,
    birthCertificate,
    cv,
    passport,
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
      nic,
      profilePic,
      name: `${firstName} ${lastName}`,
      age,
      description,
      contact,
      address,
      postalCode,
      city,
      province,
      latitude,
      longitue,
      profession,
      email,
      qualifications,
      password: hashedPassword,
      birthCertificate,
      cv,
      passport,
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

export const getAllCitizens = async (req, res) => {
  try {
    const citizens = await CitizenModel.find()
    res.status(200).json(citizens)
  } catch (error) {
    res.status(404).json({ message: error.message })
  }
}

export const getCitizen = async (req, res) => {
  const { id } = req.params

  if (!mongoose.Types.ObjectId.isValid(id))
    return res.status(404).send('No citizen found')
  try {
    const citizen = await CitizenModel.findById(id)
    res.status(200).json(citizen)
  } catch (error) {
    res.status(404).json({ message: error.message })
  }
}

export const updateCitizen = async (req, res) => {
  const { id: _id } = req.params
  const citizen = req.body

  // to make sure the id is valid
  if (!mongoose.Types.ObjectId.isValid(_id))
    return res.status(404).send('No citizen found')

  const updatedCitizen = await CitizenModel.findByIdAndUpdate(
    _id,
    { ...citizen, _id },
    {
      new: true,
    }
  )
  res.json(updatedCitizen)
}

export const deleteCitizen = async (req, res) => {
  const { id } = req.params

  // to make sure the id is valid
  if (!mongoose.Types.ObjectId.isValid(id))
    return res.status(404).send('No citizen found')

  await CitizenModel.findByIdAndRemove(id)
}
