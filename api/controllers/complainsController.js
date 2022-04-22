import ComplainModel from '../models/complains'

export const getAllComplains = async (req, res) => {
  try {
    const complains = await ComplainModel.find()

    res.status(200).json(complains)
  } catch (error) {
    res.status(404).json({ message: 'Something went wrong' })
  }
}

export const makeComplains = async (req, res) => {
  const { firstName, lastName, email, password, confirmPassword } = req.body

  try {
  } catch (error) {
    res.status(500).json({ message: 'Something went wrong' })
  }
}

export const getComplainsByUser = async (req, res) => {
  const { id } = req.params

  if (!mongoose.Types.ObjectId.isValid(id))
    return res.status(404).send('No user found')
  try {
  } catch (error) {
    res.status(500).json({ message: 'Something went wrong' })
  }
}