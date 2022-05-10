import express from 'express'
import {
  getAllComplains,
  getComplainsByUser,
  makeComplains,
} from "../controllers/complainsController.js"
import auth from "../middleware/auth.js"

const router = express.Router()

// http://localhost:5000/complains
router.get("/", getAllComplains)
router.get("/creator", getComplainsByUser)
router.post("/create", auth, makeComplains)

export default router