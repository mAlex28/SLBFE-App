import express from 'express'
import {
  getCompany,
  getAllCompanies,
  getCompanyBySearch,
  updateCompany,
  deleteCompany,
  signin,
  signup,
} from '../controllers/companyController.js'
import auth from '../middleware/auth.js'

const router = express.Router()

// http://localhost:5000/companies
router.get('/', getAllCompanies)
router.get('/search', getCompanyBySearch)
router.get('/:id', getCompany)

router.post('/signin', signin)
router.post('/signup', signup)

router.patch('/:id', updateCompany)
router.delete('/delete/:id', deleteCompany)

export default router
