import ComplainModel from '../models/complains.js'

export const getAllComplains = async (req, res) => {
  try {
    const complains = await ComplainModel.find()

    res.status(200).json(complains)
  } catch (error) {
    res.status(404).json({ message: 'Something went wrong' })
  }
}

export const makeComplains = async (req, res) => {
  const complain = req.body

  const newComplains = new ComplainModel({
    ...complain,
    creator: req.userId,
    createdAt: new Date().toISOString(),
  })

  try {
    await newComplains.save()
    res.status(201).json(newComplains)
  } catch (error) {
    res.status(500).json({ message: 'Something went wrong' })
  }
}

export const getComplainsByUser = async (req, res) => {
  const { email } = req.query

  try {
    const complains = await ComplainModel.find({ email })

    res.json(complains)
  } catch (error) {
    res.status(500).json({ message: 'Something went wrong' })
  }
}
