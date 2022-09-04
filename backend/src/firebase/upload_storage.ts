import { Storage } from '@google-cloud/storage'
import fs from 'fs'
import { GOOGLE_APPLICATION_CREDENTIALS } from '../config'

const storage = new Storage({
  keyFilename: GOOGLE_APPLICATION_CREDENTIALS,
})

let bucketName = 'speech-stroop.appspot.com'
const audioFolder = 'audio'

// Uploads a local file to the bucket
export const uploadFile = async (userId: string, filePath: string) => {
  const fileName = filePath.split('/').pop()
  const dstPath = `${audioFolder}/${userId}/${fileName}`
  console.log({
    filePath: filePath,
    fileName: fileName,
    dstPath: dstPath,
  })
  try {
    if (fs.existsSync(filePath)) {
      console.log('fs.exists')
    }
  } catch (err) {
    console.log('not fs.exists')
    console.log(err)
  }
  await storage.bucket(bucketName).upload(filePath, {
    gzip: true,
    metadata: {
      cacheControl: 'public, max-age=31536000',
    },
    destination: dstPath,
  })

  console.log(`${filePath} was uploaded successfully.`)

  const fileUrl = await getFileUrl(dstPath)
  return fileUrl
}

const getFileUrl = async (filePath: string) => {
  const today = new Date()
  const thisYear = today.getFullYear()
  const urls = await storage
    .bucket(bucketName)
    .file(filePath)
    .getSignedUrl({ action: 'read', expires: today.setFullYear(thisYear + 5) })
  const signedUrl = urls[0]
  return signedUrl
}
