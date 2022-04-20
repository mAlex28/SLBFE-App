import expres from 'express'
import {
  signin,
  signup,
  getCitizen,
  getAllCitizens,
  updateCitizen,
  deleteCitizen,
} from '../controllers/citizenController.js'

const router = expres.Router()

// http:localhost:5000/citizen
router.get('/', getAllCitizens)
router.get('/:id', getCitizen)
router.post('/signin', signin)
router.post('/signup', signup)
router.patch('/:id', updateCitizen)
router.patch('/:id', deleteCitizen)

export default router
