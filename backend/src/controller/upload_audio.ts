import { ObjectId } from 'mongoose'
import { uploadFile } from '../firebase/upload_storage'
import { removeAudioFiles } from '../utils/remove_audio_file'

export interface AudioDTO {
  directory: string
  dateTime: string
}

export async function uploadStroopAudioFile(
  audioFile: AudioDTO,
  userId: ObjectId,
): Promise<string[]> {
  let urls: string[] = []
  let toRemoveFilePaths: string[] = []

  for (let i = 0; i < 3; i++) {
    let fileName: string = `${audioFile.dateTime}_section-${i + 1}`

    let fileNameWAV: string = `${fileName}.wav`
    let fileNamePCM: string = `${fileName}.pcm`

    let filePathWAV: string = `${audioFile.directory}/${fileNameWAV}`
    let filePathPCM: string = `${audioFile.directory}/${fileNamePCM}`

    let url: string = await uploadFile(String(userId), filePathWAV)

    urls.push(url)

    toRemoveFilePaths.push(filePathWAV, filePathPCM)
  }

  await removeAudioFiles(toRemoveFilePaths)

  return urls
}
