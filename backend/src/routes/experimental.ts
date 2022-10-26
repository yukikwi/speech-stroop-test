import express from 'express'
import { setExperimentee, setHistory } from 'src/controller/save_experimental'

const experimentalRouter = express.Router()
experimentalRouter.use(express.json())
experimentalRouter.use(express.urlencoded({ extended: true }))

experimentalRouter.post('/submit_experimentee', async (req, res) => {
  try {
    // drop _id from request body to avoid null
    if(req.body._id === null) {
      delete req.body._id;
    }
    const body = req.body
    console.log(body)
    const experimentee = await setExperimentee(body)
    res.json(experimentee)
  } catch (err) {
    res.status(400).send(err)
  }
})

experimentalRouter.post('/submit_result', async (req, res) => {
  try {
    const body = req.body
    const history = await setHistory(body)
    res.json(history)
  } catch (err) {
    res.status(400).send(err)
  }
})


export default experimentalRouter
