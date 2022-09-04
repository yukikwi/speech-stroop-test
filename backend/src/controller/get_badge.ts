import { Badge } from '../model/badge'

export async function getBadges() {
  const badges = await Badge.find()
  return badges
}
