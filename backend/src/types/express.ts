import { Request } from 'express'
import { UserDocument } from '../model/user'

export type RequestWithUser = Request & {
  user: UserDocument
}
