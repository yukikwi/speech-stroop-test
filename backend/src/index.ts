import cors from 'cors'
import express from 'express'
import mongoose from 'mongoose'
import { MONGO_URI } from './config'
import { errorHandler } from './errors'
import uploadAudioRouter from './routes/audio'
import authRouter from './routes/auth'
import badgeRouter from './routes/badge'
import historyRouter from './routes/history'
import passportRouter from './routes/passport'
import userRouter from './routes/user'

const app = express()

app.use(cors())

app.get('/', (req, res) => {
  res.status(200).send('Hello, Stroop!')
})

app.use('/auth', authRouter)
app.use('/badge', badgeRouter)

app.use(passportRouter)

// use token to access
app.use('/user', userRouter)
app.use('/history', historyRouter)
app.use('/upload', uploadAudioRouter)

// Error handling
app.use(errorHandler)

console.log(`Connecting to MongoDB...`)
mongoose
  .connect(MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then((result) => {
    app.listen(process.env.PORT || 3000, () =>
      // console.log(`Connected! App running on port ${PORT}`),
      console.log(
        'Express server listening on port %d in %s mode',
        process.env.PORT,
        app.settings.env,
      ),
    )
  })
  .catch((err) => {
    console.log(err)
  })
