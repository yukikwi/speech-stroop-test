import mongoose, { Schema } from "mongoose";
import { ObjectId } from 'mongodb'
import { QuestionType } from "./question";

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

export type TestType = {
  sectionType: '7congruent-3incongruent' | 'balance' | '3congruent-7incongruent',
  questions: Array<QuestionType>
}

export type testDocument = mongoose.Document & TestType

export const Test = mongoose.model<testDocument>('Test', testSchema)