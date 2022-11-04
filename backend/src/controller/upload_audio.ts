import { UploadedFile } from 'express-fileupload';

export interface AudioDTO {
  directory: string
  dateTime: string
}

export function uploadStroopAudioFile(
  request:Express.Request,
): String {
  
  let audioFile = request.files.audioFile as UploadedFile
  try{
    audioFile.mv(`${process.cwd()}/uploads/` + audioFile.name);
    return "success"
  }
  catch(err){
    console.error(err)
    throw new Error('uploadStroopAudioFile: fail to saved file');
  }

  
}
