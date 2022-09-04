import express from 'express'
import { updateUser } from '../controller/update_user'
import { RequestWithUser } from '../types/express'

const router = express.Router()
router.use(express.json())
router.use(express.urlencoded({ extended: true }))

router.get('/profile', async (req: RequestWithUser, res) => {
  res.json(req.user)
})

router.patch('/profile', async (req: RequestWithUser, res) => {
  const body = req.body
  console.log(body)
  const user = await updateUser(body, req.user.id)
  res.json(user)
})

export default router
