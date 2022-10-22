import { ObjectId } from 'mongodb'
import mongoose from 'mongoose'
const Schema = mongoose.Schema

const historySchema = new Schema(
  {
    experimentee: {
      type: ObjectId,
      ref: 'Experimentee',
      required: true,
    },
    totalScore: {
      type: Number,
      required: true,
    },
    sections: [
      {
        section: {
          type: Number,
          required: true
        },
        score: {
          type: {
            congruent: {
              type: Number,
              required: true
            },
            incongruent: {
              type: Number,
              required: true
            }
          },
          required: true
        },
        avgReactionTimeMs: {
          type: Number,
          required: true
        },
        question: [
          {
            questionNumber: {
              type: Number,
              required: true
            },
            problem: {
              type: {
                color:{
                  type: String,
                  required: true
                },
                word: {
                  type: String,
                  required: true
                }
              },
              required: true
            },
            condition: {
              type: String,
              required: true
            },
            expectedAnswer: {
              type: String,
              required: true
            },
            userAnswer: {
              type: String,
              required: true
            },
            startAt: {
              type: String,
              required: true
            },
            answerAt: {
              type: String,
              required: true
            },
            reactionTimeMs: {
              type: Number,
              required: true
            },
            isCorrect: {
              type: Boolean,
              required: true
            },
          }
        ],
        audioUrl: {
          type: String,
          required: true
        }
      }
    ],
    feedbackType: {
      type: String,
      required: true,
    }
  },
  { timestamps: true },
)

export type HistoryDocument = mongoose.Document & {
  experimentee: ObjectId
  totalScore: number
  sections: Array<{
    section: number,
    score: {
      congruent: number,
      incongruent: number
    },
    avgReactionTimeMs: number,
    questions: Array<{
      questionNumber: number,
      problem: {
        color: string,
        word: string
      },
      condition: string,
      expectedAnswer: string,
      userAnswer: string,
      startAt: string,
      answerAt: string,
      reactionTimeMs: number,
      isCorrect: boolean
    }>,
    audioUrl: string
  }>,
  feedbackType: string
}

const History = mongoose.model<HistoryDocument>('History', historySchema)

export { History }
