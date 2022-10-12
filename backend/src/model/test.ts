import mongoose, { Schema } from "mongoose";
import { ObjectId } from 'mongodb'

const testSchema = new Schema(
  {
    sectionType: {
      type: String,
      enum: ['7congruent-3incongruent', 'balance', '3congruent-7incongruent'],
      required: true
    },
    questions: {
      type: [ObjectId],
      required: true
    }
  },
  { timestamps: false },
)

type Question = {
  question: string,
  answer: string,
  time: number
}

export type TestType = {
  sectionType: '7congruent-3incongruent' | 'balance' | '3congruent-7incongruent',
  questions: Question[]
}

export type testDocument = mongoose.Document & TestType

export const Test = mongoose.model<testDocument>('Test', testSchema)