import express, { Request, Response } from 'express'
import { getUserByTel, TelDTO } from '../controller/get_user'
import { login, LoginDTO } from '../controller/login'
import { register, RegisterDTO } from '../controller/register'

const router = express.Router()
router.use(express.json())
router.use(express.urlencoded({ extended: true }))

router.post('/login', async (req: Request<{}, {}, LoginDTO>, res: Response) => {
  const body = req.body
  if (!body.tel || !body.password) {
    return res.status(400).json({
      error: 'email and/or password is missing',
    })
  }
  const response = await login({ tel: body.tel, password: body.password })
  res.json(response)
})

router.post('/logout', function (req, res) {
  req.logOut()
  res.redirect('/')
})

router.get('/profile_tel', async function (req: Request<{}, {}, TelDTO>, res) {
  const queryParams = req.query
  const tel = queryParams.tel as string
  const body = {
    tel: tel,
  }
  const response = await getUserByTel(body)
  res.json(response)
})

router.post(
  '/register',
  async (req: Request<{}, {}, RegisterDTO>, res: Response) => {
    const body = req.body
    const user = await register(body)
    const response = await login({
      tel: user.tel,
      password: body.password,
    })
    res.json(response)
  },
)

export default router
