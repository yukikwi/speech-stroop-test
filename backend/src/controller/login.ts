import bcrypt from 'bcrypt'
import { HttpError } from '../errors'
import { User } from '../model/user'
import { signJWT } from '../utils/auth/jwt'

export interface LoginDTO {
  tel: string
  password: string
}

export interface LoginResponse {
  token: string
  _id: string
}

export async function login({
  tel,
  password,
}: LoginDTO): Promise<LoginResponse> {
  const user = await User.findOne({
    tel: tel,
  }).select('password')
  if (!user) {
    throw new HttpError(404, "This phone number havn't registered yet.")
  }

  if (!bcrypt.compareSync(password, user.password)) {
    throw new HttpError(401, 'Invalid password')
  }

  return {
    token: signJWT({ _id: user._id }),
    _id: user._id,
  }
}
