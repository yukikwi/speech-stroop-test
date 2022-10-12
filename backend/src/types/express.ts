import { Request } from 'express'
import { experimentalDocument } from 'src/model/experimental'
import { UserDocument } from '../model/user'

export type RequestWithUser = Request & {
  user: UserDocument
}

export type RequestWithExperimental = Request & {
  experimental: experimentalDocument
}