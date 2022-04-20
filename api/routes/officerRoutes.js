import expres from 'express'
import { signin, signup } from '../controllers/officerController.js'

const router = expres.Router()

// http:localhost:5000/officer
router.post('/signin', signin)
router.post('/signup', signup)

export default router
