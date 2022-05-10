import express from 'express'
import {
  signin,
  signup,
  getCitizen,
  getAllCitizens,
  updateCitizen,
  deleteCitizen,
  getCitizensBySearch,
  getCitizensWithoutPagination,
  getCitizenByName,
  getCitizenByNIC,
} from "../controllers/citizenController.js"
import auth from "../middleware/auth.js"

const router = express.Router()

// http://localhost:5000/citizens
router.get("/", getAllCitizens)
router.get("/:id", getCitizen)
router.get("/search", getCitizensBySearch)
router.get('/pagination', getCitizensWithoutPagination)
router.get("/creator", getCitizenByName)
router.get("/nic", getCitizenByNIC)

router.post("/signin", signin)
router.post("/signup", signup)

router.patch("/:id", auth, updateCitizen)
router.delete("/:id", auth, deleteCitizen)

export default router
