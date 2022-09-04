import { ObjectId } from 'mongodb'
import mongoose from 'mongoose'
const Schema = mongoose.Schema

const userSchema = new Schema(
  {
    tel: {
      type: String,
      required: true,
    },
    password: {
      type: String,
      required: true,
    },
    username: {
      type: String,
      required: true,
    },
    name: {
      type: String,
      required: true,
    },
    surname: {
      type: String,
      required: true,
    },
    email: {
      type: String,
      required: true,
    },
    hnId: {
      type: String,
      required: false,
    },
    lastFourId: {
      type: String,
      required: true,
    },
    dateOfBirth: {
      type: Date,
      required: true,
    },
    gender: {
      type: String,
      required: true,
    },
    education: {
      type: String,
      required: true,
    },
    historyId: {
      type: [ObjectId],
      required: false,
    },
    badge: {
      type: [ObjectId],
      required: false,
    },
    precondition: {
      isColorBlind: { type: Boolean, required: true },
      colorVisibilityTest: {
        score: { type: Number, required: true },
        date: { type: Date, required: true },
      },
      readingAbilityTest: {
        score: { type: Number, required: true },
        date: { type: Date, required: true },
      },
      isPassAll: { type: Boolean, required: true },
    },
    healthScores: {
      stress: {
        type: Number,
        required: true,
      },
      sleep: {
        type: Number,
        required: true,
      },
    },
  },
  { timestamps: true },
)

export type UserDocument = mongoose.Document & {
  tel: string
  password: string
  username: string
  name: string
  surname: string
  email: string
  hnId: string
  lastFourId: string
  dateOfBirth: Date
  gender: string
  education: string
  historyId: [ObjectId]
  badge: [ObjectId]
  precondition: {
    isColorBlind: boolean
    colorVisibilityTest: {
      score: number
      date: Date
    }
    readingAbilityTest: {
      score: number
      date: Date
    }
    isPassAll: boolean
  }
  healthScores: {
    stress: number
    sleep: number
  }
  createdAt: Date
  updatedAt: Date
}

const User = mongoose.model<UserDocument>('User', userSchema)

export { User }
