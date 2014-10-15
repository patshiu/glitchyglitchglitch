//- - - - - - - - - 
//PIXEL SMEAR
//- - - - - - - - - 

class PixelSmear {
	PImage canvasImage; 
	PImage motherImage;
	float glitchFactor; 

	//Constructor
	PixelSmear(String inputImageLoc){
		canvasImage = loadImage(inputImageLoc);
		motherImage = requestImage(inputImageLoc);
		glitchFactor = 2; //The smaller this factor, the greater the glitch effect 
	}

	//Load the pixels to create array
	//Run through the image, select random pixels (of a certain brightness?)
	//Displace by a random percentage of the image width (use noise)
	void warpSmear() {
		image(canvasImage, 0, 0, canvasImage.width, canvasImage.height);
		loadPixels();
		float seed = random(1);
		for (int yItr = 0; yItr < canvasImage.height; yItr++){ //Traverse Width of Image
			//Use noise to determine how much a line should be displaced
			int displacement = int(map(noise(seed), 0, 1, 0, canvasImage.width/glitchFactor));
			
			//Apply the displacement if it's bigger than zero
			if (displacement > 0 ){
				int rowsFirstPixel = yItr * canvasImage.width;
				color[] jotRowDown = new color[canvasImage.width];
				for (int xItr = 0; xItr < canvasImage.width; xItr++){
					jotRowDown[xItr] = pixels[rowsFirstPixel + xItr];
				}
				for (int i = 0; i < displacement; i++){
					pixels[rowsFirstPixel + i] = pixels[rowsFirstPixel];
				}
				for (int i = displacement; i < canvasImage.width; i++){
					pixels[rowsFirstPixel + i] = jotRowDown[i-displacement];
				}
				//By this point this row of pixels[] should have been displaced
			}
			seed++;
		}
		updatePixels();
		vig();
	}

	void display(){
		image(canvasImage, 0, 0, width, height);
	}

	void run(){
		warpSmear();
		display();

	}

	void reset(){
		canvasImage = motherImage;
	}
}