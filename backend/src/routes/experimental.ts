import express from 'express'
import { RequestWithExperimental } from 'src/types/express'

const experimentalRouter = express.Router()
experimentalRouter.use(express.json())
experimentalRouter.use(express.urlencoded({ extended: true }))

experimentalRouter.post('/submit', async (req: RequestWithExperimental, res) => {
  // req.body :   data that client submit in x-www-form-urlencoded format
  //              this using in form submittion
  res.json(req.body)
})

export default experimentalRouter
