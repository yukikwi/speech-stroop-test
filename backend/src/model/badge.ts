import mongoose from 'mongoose'
const Schema = mongoose.Schema

const badgeSchema = new Schema(
  {
    name: {
      type: String,
      required: true,
    },
    imgPath: {
      type: String,
      required: true,
    },
    type: {
      type: String,
      required: true,
    },
    condition: {
      type: Number,
      required: true,
    },
  },
  { timestamps: true },
)

export type BadgeDocument = mongoose.Document & {
  name: string
  imgPath: string
  type: string
  condition: Number
}

const Badge = mongoose.model<BadgeDocument>('Badge', badgeSchema)

export { Badge }
