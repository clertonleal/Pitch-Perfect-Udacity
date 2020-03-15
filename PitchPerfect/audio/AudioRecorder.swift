import Foundation
import AVFoundation

class AudioRecorder: NSObject, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    var fileSaved: ((_: URL?, _: Bool) -> Void)?
    
    override init() {
        super.init()
        
        let filePath = getAudioFilePath()
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
    }
    
    func startAudioRecord() {
        startRecordAudioSession()
        
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func stopAudioRecord(fileSaved: @escaping (_: URL?, _: Bool) -> Void) {
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
        self.fileSaved = fileSaved
    }
    
    func getAudioFilePath() -> URL? {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice2.wav"
        let pathArray = [dirPath, recordingName]
        return URL(string: pathArray.joined(separator: "/"))
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        fileSaved?(getAudioFilePath(), flag)
    }
    
    private func startRecordAudioSession() {
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
    }
    
}
