import expres from 'express'
import {
  getCompany,
  getAllCompanies,
  createCompany,
  updateCompany,
  deleteCompany,
} from '../controllers/companyController.js'

const router = expres.Router()

// http:localhost:5000/companies
router.get('/', getAllCompanies)
router.post('/', createCompany)
router.get('/:id', getCompany)
router.patch('/:id', updateCompany)
router.delete('/:id', deleteCompany)

export default router
