import expres from 'express'
import { signin, signup } from '../controllers/citizenController.js'

const router = expres.Router()

// http:localhost:5000/citizen
router.post('/signin', signin)
router.post('/signup', signup)

export default router
