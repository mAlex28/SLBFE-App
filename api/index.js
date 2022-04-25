import express from 'express'
import bodyParser from 'body-parser'
import mongoose from 'mongoose'
import cors from 'cors'
import dotenv from 'dotenv'

import companyRoutes from './routes/companyRoutes.js'
import citizenRoutes from './routes/citizenRoutes.js'
import officerRoutes from './routes/officerRoutes.js'

const app = express()
dotenv.config()

app.use(bodyParser.json({ limit: '30mb', extended: true }))
app.use(bodyParser.urlencoded({ limit: '30mb', extended: true }))
app.use(cors({ credentials: true }))

// using routes
app.use('/company', companyRoutes)
app.use('/citizen', citizenRoutes)
app.use('/officer', officerRoutes)

const PORT = process.env.PORT || 5000

mongoose
  .connect(process.env.CONNECTION_URL, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() =>
    app.listen(PORT, () => console.log(`Server running on port ${PORT}`))
  )
  .catch((error) => console.log(error.message))
