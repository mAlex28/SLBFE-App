import express from 'express'
import { signin, signup } from '../controllers/officerController.js'

const router = express.Router()

// http://localhost:5000/officers
router.post('/signin', signin)
router.post('/signup', signup)

export default router
