import express from 'express'
import { uploadStroopAudioFile } from '../controller/upload_audio'
import fileUpload, { UploadedFile } from 'express-fileupload'

const router = express.Router()
router.use(express.json())
router.use(fileUpload())
router.use(express.urlencoded({ extended: true }))

router.post('/stroop_audio', async (req, res) => {
  try {
    let audioFile = req.files.audioFile as UploadedFile
    audioFile.mv(`${process.cwd()}/uploads/` + audioFile.name);
    res.json({ result: "saved" })
  } catch (err) {
    console.log('err:\t', err)
    res.status(400).send(err)
  }
})

export default router
