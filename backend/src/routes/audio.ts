import express from 'express'
import { uploadStroopAudioFile } from '../controller/upload_audio'
import fileUpload, { UploadedFile } from 'express-fileupload'

const router = express.Router()
router.use(express.json())
router.use(fileUpload())
router.use(express.urlencoded({ extended: true }))

router.post('/stroop_audio', async (req, res) => {
  try {
    const result = uploadStroopAudioFile(req)
    res.json({ result: result })
  } catch (err) {
    console.log('err:\t', err)
    res.status(400).send(err)
  }
})

export default router
