import { User } from '../model/user'

export interface TelDTO {
  tel: string
}

export interface TelResponse {
  token: string
  _id: string
}

export async function getUserByID(id: string) {
  const user = await User.findById(id)
  return user
}

export async function getUserByTel(telDTO: TelDTO) {
  const user = await User.findOne({ tel: telDTO.tel })
  return user
}
