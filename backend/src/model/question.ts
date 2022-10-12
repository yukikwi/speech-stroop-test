import mongoose, { Schema } from "mongoose";
import { ObjectId } from 'mongodb'

const questionSchema = new Schema(
  {
    question: {
      type: String,
      required: true
    },
    answer: {
      type: String,
      required: true
    },
    time: {
      type: Number,
      required: true
    },
  },
  { timestamps: false },
)

export type QuestionType = {
  question: string,
  answer: string,
  time: number
}
export type questionDocument = mongoose.Document & QuestionType

export const Question = mongoose.model<questionDocument>('Question', questionSchema)