import { ObjectId } from 'mongodb'
import { User } from '../model/user'

export interface UpdateUserDTO {
  tel?: string
  username?: string
  name?: string
  surname?: string
  email?: string
  dateOfBirth?: Date
  gender?: string
  education?: string
  precondition?: {
    isColorBlind: boolean
    colorVisibilityTest: {
      score: number
      date: Date
    }
    readingAbilityTest: {
      score: number
      date: Date
    }
    isPassAll: boolean
  }
  updatedAt?: Date
}

export async function updateUser(
  updateUserDTO: UpdateUserDTO,
  userID: ObjectId,
): Promise<any> {
  await User.updateOne({ _id: userID }, updateUserDTO)
  console.log(updateUserDTO)
  return updateUserDTO
}
