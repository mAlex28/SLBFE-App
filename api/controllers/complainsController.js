import ComplainModel from '../models/complains.js'

export const getAllComplains = async (req, res) => {
  const { page } = req.query

  try {
    // paging the response
    const LIMIT = 8
    const startIndex = (Number(page) - 1) * LIMIT

    const total = await ComplainModel.countDocuments()
    const complains = await ComplainModel.find()
      .sort({ _id: -1 })
      .limit(LIMIT)
      .skip(startIndex)

    res.json({
      data: complains,
      currentPage: Number(page),
      numberOfPages: Math.ceil(total / LIMIT),
    })
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
