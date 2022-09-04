import { Badge, BadgeDocument } from '../model/badge'

export interface BadgeDTO {
  name: string
  imgPath: string
  type: string
  condition: string
}

export async function setBadge(badgeDTO: BadgeDTO): Promise<BadgeDocument> {
  const newBadge = new Badge({
    name: badgeDTO.name,
    imgPath: badgeDTO.imgPath,
    type: badgeDTO.type,
    condition: badgeDTO.condition,
  })
  console.log(newBadge)

  await newBadge.save()
  return newBadge
}
