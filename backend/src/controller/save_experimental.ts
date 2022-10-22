import { ObjectId } from 'mongoose'
import { Experimentee, ExperimenteeDocument } from 'src/model/experimentee'
import { History, HistoryDocument } from '../model/history'


export interface HistoryDTO {
  experimentee: ObjectId,
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
  ],
  feedbackType: string
}

export interface ExperimenteeDTO {
  runingNumber: string,
  feedbackOrder: {
    afterQuestion: number,
    afterSection: number,
    afterAllSection: number
  }
}

export async function setExperimentee(
  experimenteeDTO: ExperimenteeDTO
): Promise<ExperimenteeDocument> {
  const newExperimentee = new Experimentee(experimenteeDTO)
  console.log(newExperimentee)
  await newExperimentee.save()
  return newExperimentee
}

export async function setHistory(
  historyDTO: HistoryDTO
): Promise<HistoryDocument> {
  const newHistory = new History(historyDTO)
  console.log(newHistory)
  await newHistory.save()
  return newHistory
}