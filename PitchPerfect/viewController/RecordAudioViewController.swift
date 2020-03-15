import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var startRecordButton: UIButton!
    
    var audioRecorder: AudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRecordingButtons(isRecording: false)
        audioRecorder = AudioRecorder()
    }
    

    @IBAction func recordAudio(_ sender: Any) {
        recordingLabel.text = "Recording in Progress"
        setRecordingButtons(isRecording: true)
        
        audioRecorder.startAudioRecord()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        recordingLabel.text = "Tap to Record"
        setRecordingButtons(isRecording: false)
        
        audioRecorder.stopAudioRecord(fileSaved: {
            savedFile, success in self.performSegue(withIdentifier: "stopRecording", sender: savedFile)
        })
    }
    
    private func setRecordingButtons(isRecording: Bool) {
        stopRecordingButton.isEnabled = isRecording
        startRecordButton.isEnabled = !isRecording
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let viewController = segue.destination as! PlaySoundsViewController
            viewController.recordedAudioUrl = (sender as! URL)
        }
    }
    
}

