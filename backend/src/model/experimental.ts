import mongoose from 'mongoose'
const Schema = mongoose.Schema

const experimentalSchema = new Schema(
  {
    experimentee: {
      type: String,
      required: true,
    },
    test: {
      type: Array<{
        sectionType: {
          type: String,
          enum: ['7congruent-3incongruent','balance','3congruent-7incongruent'],
          required: true
        },
        questions: {
          type: Array<{
            question: { type: String, required: true },
            answer: { type: String, required: true },
            time: { type: Number, required: true },
          }>
        }
      }>
    },
    feedbackType: {
      type: String,
      enum: ['after-question', 'after-section', 'after-test'],
      required: true
    }
  },
  { timestamps: true },
)

type Question = {
  question: string,
  answer: string,
  time: number
}

type Test = {
  sectionType: '7congruent-3incongruent' | 'balance' | '3congruent-7incongruent',
  questions: Question[]
}

export type experimentalDocument = mongoose.Document & {
  experimentee: string,
  test: Test[],
  feedbackType: 'after-question' | 'after-section' | 'after-test'
}

const Experimental = mongoose.model<experimentalDocument>('Experimental', experimentalSchema)

export { Experimental }
