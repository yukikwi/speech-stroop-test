import mongoose from 'mongoose'
const Schema = mongoose.Schema

const experimenteeSchema = new Schema(
  {
    runingNumber: {
      type: String,
      required: true,
    },
    feedbackOrder: {
      type: {
        afterQuestion: {
          type: Number,
          required: true
        },
        afterSection: {
          type: Number,
          required: true
        },
        afterAllSection: {
          type: Number,
          required: true
        },
      }
    }
  }
)

export type ExperimenteeDocument = mongoose.Document & {
  runingNumber: string,
  feedbackOrder: {
    afterQuestion: number,
    afterSection: number,
    afterAllSection: number
  }
}

const Experimentee = mongoose.model<ExperimenteeDocument>('Experimentee', experimenteeSchema)

export { Experimentee }