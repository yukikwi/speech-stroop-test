import dotenv from 'dotenv'
dotenv.config()

export const MONGO_URI = process.env.MONGO_URI
export const PORT = process.env.PORT || 3000

export const JWT_SECRET = process.env.JWT_SECRET
export const GOOGLE_APPLICATION_CREDENTIALS =
  process.env.GOOGLE_APPLICATION_CREDENTIALS
