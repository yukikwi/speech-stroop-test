import express from 'express'
import {
  deleteHistoryById,
  deleteHistoryByUserId,
} from '../controller/delete_history'
import { getHistoryByID } from '../controller/get_history'
import { setHistory } from '../controller/set_history'
import { HistoryDocument } from '../model/history'
import { RequestWithUser } from '../types/express'

const router = express.Router()
router.use(express.json())
router.use(express.urlencoded({ extended: true }))

router.get('', async (req: RequestWithUser, res) => {
  const history = await getHistoryByID(req.user._id)
  res.json(history)
})

router.post('', async (req: RequestWithUser, res) => {
  try {
    const body = req.body
    const history: HistoryDocument = await setHistory(body, req.user._id)
    res.json(history)
  } catch (err) {
    res.status(400).send(err)
  }
})

router.post('/delete/id/:id', async (req: RequestWithUser, res) => {
  try {
    const id = req.params['id']
    console.log(id)
    const r = await deleteHistoryById(id)
    res.json(r)
  } catch (err) {
    console.log(err)
    res.status(400).send(err)
  }
})

router.post('/delete', async (req: RequestWithUser, res) => {
  try {
    const r = await deleteHistoryByUserId(req.user._id)
    res.json(r)
  } catch (err) {
    res.status(400).send(err)
  }
})

export default router
