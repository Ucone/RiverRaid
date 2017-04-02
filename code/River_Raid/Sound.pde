import controlP5.*;
import ddf.minim.*;

class Sound{
	private String crashSoundFile = "sound/crash.mp3";
	private String crossSectionSoundFile = "sound/cross.mp3";
	private String defeatEnemyFile = "sound/defeat.mp3";
	private String musicSoundFile = "sound/music.mp3";
	private String shootSoundFile = "sound/shoot.mp3";
	  
	public Sound(){
		
	} 
  
	public void playSound(String fileName){
		soundPlayer = minim.loadFile(fileName);
		soundPlayer.rewind();
		soundPlayer.play();
	}

	public void playCrashSound(){
		this.playSound(crashSoundFile);
	}

	public void playCrossSound(){
		this.playSound(crossSectionSoundFile);
	}

	public void playDefeatSound(){
		this.playSound(defeatEnemyFile);
	}

	public void playShootSound(){
		this.playSound(shootSoundFile);
	}

	public void playMusicSound(){
		this.playSound(musicSoundFile);
	}


}