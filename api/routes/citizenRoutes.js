import expres from "express"
import {
  signin,
  signup,
  getCitizen,
  getAllCitizens,
  updateCitizen,
  deleteCitizen,
  getCitizenByNameSearch,
  getCitizenBySearch,
  getCitizenByNICSearch,
  getCitizensWithoutPagination,
} from "../controllers/citizenController.js"
import {
  getAllComplains,
  getComplainsByUser,
  makeComplains,
} from "../controllers/complainsController.js"
import auth from "../middleware/auth.js"

const router = expres.Router()

// http:localhost:5000/citizen
router.get("/", getAllCitizens)
router.get("/wpageination", getCitizensWithoutPagination)

router.get("/:id", getCitizen)
router.get("/citizenname", getCitizenByNameSearch)
router.get("/search", getCitizenBySearch)
router.get("/nic", getCitizenByNICSearch)

router.post("/signin", signin)
router.post("/signup", signup)
router.patch("/:id", auth, updateCitizen)
router.patch("/:id", auth, deleteCitizen)
router.get("/complains/", getAllComplains)
router.get("/complains/:id", getComplainsByUser)
router.post("/complains", auth, makeComplains)

export default router
