import mongoose from 'mongoose'
import { ObjectId } from 'mongodb'
import { TestType } from './test'
const Schema = mongoose.Schema

const experimentalSchema = new Schema(
  {
    experimentee: {
      type: String,
      required: true,
    },
    test: {
      type: [ObjectId],
      required: true
    },
    feedbackType: {
      type: String,
      enum: ['after-question', 'after-section', 'after-test'],
      required: true
    }
  },
  { timestamps: true },
)

export type experimentalDocument = mongoose.Document & {
  experimentee: string,
  test: Array<TestType>,
  feedbackType: 'after-question' | 'after-section' | 'after-test'
}

export const Experimental = mongoose.model<experimentalDocument>('Experimental', experimentalSchema)