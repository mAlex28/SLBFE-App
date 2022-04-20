import expres from 'express'
import {
  getCompany,
  getAllCompanies,
  updateCompany,
  deleteCompany,
  signin,
  signup,
} from '../controllers/companyController.js'

const router = expres.Router()

// http:localhost:5000/company
router.get('/', getAllCompanies)
router.post('/signin', signin)
router.post('/signup', signup)
router.get('/:id', getCompany)
router.patch('/:id', updateCompany)
router.delete('/:id', deleteCompany)

export default router
