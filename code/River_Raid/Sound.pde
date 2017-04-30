import controlP5.*;
import ddf.minim.*;

class Sound{
	private String crashSoundFile = "sound/crash.mp3";
	private String crossSectionSoundFile = "sound/cross.mp3";
	private String defeatEnemyFile = "sound/defeat.mp3";
	private String shootSoundFile = "sound/shoot.mp3";
	private String musicSoundFile = "sound/music.mp3";
  
  private AudioPlayer crashSound, sectionSound, defeatSound, shootSound; 	

	public Sound(){
		musicPlayer = minim.loadFile(musicSoundFile);

    crashSound = minim.loadFile(crashSoundFile);
    sectionSound = minim.loadFile(crossSectionSoundFile);
    defeatSound = minim.loadFile(defeatEnemyFile);
    shootSound = minim.loadFile(shootSoundFile);
	} 
  
	public void playSound(AudioPlayer sound){
		sound.rewind();
    sound.play();
	}

	public void playCrashSound(){
    if(isMusicOn)
		  this.playSound(crashSound);
	}

	public void playCrossSound(){
    if(isMusicOn)
		  this.playSound(sectionSound);
	}

	public void playDefeatSound(){
    if(isMusicOn)
		  this.playSound(defeatSound);
	}

	public void playShootSound(){
    if(isMusicOn)
		  this.playSound(shootSound);
	}

	public void toggleMusic(){
		if(isMusicOn == true){
			musicPlayer.pause();
			isMusicOn = false;
		}
		else{
			musicPlayer.loop();
			isMusicOn = true;
		}
	}

}