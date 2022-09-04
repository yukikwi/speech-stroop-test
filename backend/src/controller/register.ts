import bcrypt from 'bcrypt'
import { ObjectId } from 'mongodb'
import { HttpError } from '../errors'
import { User, UserDocument } from '../model/user'

export interface RegisterDTO {
  tel: string
  password: string
  username: string
  name: string
  surname: string
  email: string
  hnId: string
  lastFourId: string
  dateOfBirth: Date
  gender: string
  education: string
  historyId: [ObjectId]
  badge: [ObjectId]
  precondition: {
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
  healthScores: {
    stress: number
    sleep: number
  }
  createdAt: Date
  updatedAt: Date
}

const saltRounds = 12

export async function register(
  registerDTO: RegisterDTO,
): Promise<UserDocument> {
  const user = await User.findOne({
    tel: registerDTO.tel,
  })

  // TODO: ไม่ควร check ในนี้ เพราะอันนี้จะ trigger ตอน sleep form
  if (user) {
    throw new HttpError(409, 'user with this phone number already exists')
  }

  // TODO: validate register request body

  const hashedPassword = bcrypt.hashSync(registerDTO.password, saltRounds)
  const newUser = new User({
    tel: registerDTO.tel,
    password: hashedPassword,
    username: registerDTO.username,
    name: registerDTO.name,
    surname: registerDTO.surname,
    email: registerDTO.email,
    hnId: registerDTO.hnId,
    lastFourId: registerDTO.lastFourId,
    dateOfBirth: registerDTO.dateOfBirth,
    gender: registerDTO.gender,
    education: registerDTO.education,
    historyId: registerDTO.historyId,
    badge: registerDTO.badge,
    precondition: {
      isColorBlind: registerDTO.precondition.isColorBlind,
      colorVisibilityTest: {
        score: registerDTO.precondition.colorVisibilityTest.score,
        date: registerDTO.precondition.colorVisibilityTest.date,
      },
      readingAbilityTest: {
        score: registerDTO.precondition.readingAbilityTest.score,
        date: registerDTO.precondition.readingAbilityTest.date,
      },
      isPassAll: registerDTO.precondition.isPassAll,
    },
    healthScores: {
      stress: registerDTO.healthScores.stress,
      sleep: registerDTO.healthScores.sleep,
    },
  })

  await newUser.save()
  newUser.set('password', undefined) //not return password
  return newUser
}
