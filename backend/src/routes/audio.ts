import express from 'express'
import { uploadStroopAudioFile } from '../controller/upload_audio'
import { RequestWithUser } from '../types/express'

const router = express.Router()
router.use(express.json())
router.use(express.urlencoded({ extended: true }))

router.post('/stroop_audio', async (req: RequestWithUser, res) => {
  try {
    const body = req.body
    const urls = await uploadStroopAudioFile(body, req.user._id)
    res.json({ urls })
  } catch (err) {
    console.log('err:\t', err)
    res.status(400).send(err)
  }
})

export default router
