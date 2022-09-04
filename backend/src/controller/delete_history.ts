import { History } from '../model/history'

export async function deleteHistoryByUserId(userId: string) {
  const h = await History.deleteMany({ userId: userId })
  console.log(h)
  return h
}

export async function deleteHistoryById(id: string) {
  const h = await History.deleteOne({ _id: id })
  console.log(h)
  return h
}
