import { ObjectId } from 'mongoose'
import { Experimentee, ExperimenteeDocument } from 'src/model/experimentee'
import { randomUniformClass } from 'src/utils/uniform_random'
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
  feedbackOrder?: {
    afterQuestion: number,
    afterSection: number,
    afterAllSection: number
  }
}

export async function setExperimentee(
  experimenteeDTO: ExperimenteeDTO
): Promise<ExperimenteeDocument> {
  // counter balanced algorithm
  const feedbackOrderPattern = ["123", "132", "213", "231", "312", "321"]
  const experimenteesFeedbackOrder = await Experimentee.find().select({"feedbackOrder": 1})
  // convert feedbackOrder object to class pattern
  const experimenteesFeedbackOrderOldResultClass = experimenteesFeedbackOrder.map(row => `${row.feedbackOrder.afterQuestion}${row.feedbackOrder.afterSection}${row.feedbackOrder.afterAllSection}`)
  const newExperimenteeFeedbackOrder = randomUniformClass(experimenteesFeedbackOrderOldResultClass, feedbackOrderPattern).split("").map(element => parseInt(element))

  experimenteeDTO = {
    ...experimenteeDTO,
    feedbackOrder: {
      afterQuestion: newExperimenteeFeedbackOrder[0],
      afterSection:  newExperimenteeFeedbackOrder[1],
      afterAllSection:  newExperimenteeFeedbackOrder[2]
    }
  }
  const newExperimentee = new Experimentee(experimenteeDTO)
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