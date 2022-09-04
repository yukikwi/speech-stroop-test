import { ObjectId } from 'mongodb'
import mongoose from 'mongoose'
const Schema = mongoose.Schema

const historySchema = new Schema(
  {
    userId: {
      type: ObjectId,
      required: true,
    },
    totalScore: {
      type: Number,
      required: true,
    },
    sections: [
      {
        section: Number,
        score: {
          congruent: Number,
          incongruent: Number,
        },
        avgReactionTimeMs: Number,
        questions: [
          {
            questionNumber: Number,
            problem: {
              color: String,
              word: String,
            },
            condition: String,
            expectedAnswer: String,
            userAnswer: String,
            startAt: String,
            answerAt: String,
            reactionTimeMs: Number,
            isCorrect: Boolean,
          },
        ],
        audioUrl: String,
      },
    ],
    healthScores: {
      stress: {
        start: Number,
        break1: Number,
        break2: Number,
        end: Number,
      },
      arousel: {
        start: Number,
        break1: Number,
        break2: Number,
        end: Number,
      },
    },
    badge: {
      type: [ObjectId],
      required: false,
    },
  },
  { timestamps: true },
)

export type HistoryDocument = mongoose.Document & {
  userId: ObjectId
  totalScore: string
  section: [
    {
      section: number
      score: {
        congruent: number
        incongruent: number
      }
      avgReactionTimeMs: number
      questions: [
        {
          questionNumber: number
          problem: {
            color: string
            word: string
          }
          condition: string
          expectedAnswer: string
          userAnswer: string
          startAt: string
          answerAt: string
          reactionTimeMs: number
          isCorrect: boolean
        },
      ]
      audioUrl: string
    },
  ]
  healthScores: {
    stress: {
      start: number
      break: number
      end: number
    }
    arousel: {
      start: number
      break: number
      end: number
    }
  }
  badge: {
    type: [ObjectId]
    required: false
  }
}

const History = mongoose.model<HistoryDocument>('History', historySchema)

export { History }
