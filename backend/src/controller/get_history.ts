import { History } from '../model/history'

export async function getHistoryByID(id: string) {
  const history = await History.find({userId: id});
  return history;
}
