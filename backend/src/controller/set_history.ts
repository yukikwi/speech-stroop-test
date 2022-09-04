import { ObjectId } from 'mongodb'
import { History, HistoryDocument } from '../model/history'

export interface HistoryDTO {
  totalScore: number
  sections: [
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

export async function setHistory(
  historyDTO: HistoryDTO,
  userId: ObjectId,
): Promise<HistoryDocument> {
  const newHistory = new History({
    userId: userId,
    totalScore: historyDTO.totalScore,
    sections: historyDTO.sections,
    healthScores: historyDTO.healthScores,
    badge: historyDTO.badge,
  })
  console.log(newHistory)
  await newHistory.save()
  return newHistory
}
