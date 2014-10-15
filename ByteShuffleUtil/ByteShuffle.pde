//- - - - - - - - - 
//BYTE SHUFFLE
//- - - - - - - - - 

class ByteShuffle {
	PImage canvasImage; 
	float glitchFactor; 
	byte[] b;

	//Constructor
	ByteShuffle(String inputImageLoc) {
		canvasImage = requestImage(inputImageLoc); //Why is this necessary? Only for multiple applications of the filter.
		b = loadBytes(inputImageLoc);
		glitchFactor = 3; 
	}

	void drawCollage() {
		image(canvasImage, 0, 0, canvasImage.width, canvasImage.height);
		loadPixels();
		for (int i = 0; i < pixels.length; i++){
			pixels[i] = grayScale(pixels[i]);
		}
		updatePixels();
		vig();
	}

	color grayScale(color c){
		float greyScaleVal = 0.2126*red(c) + 0.7152*green(c) + 0.0722*blue(c);
		c = color(int(greyScaleVal));
		return c;
	}

	void showHexAsPixels() {
		//Manipulate the pixels

		//There are 447783 values in b[] array 
		//println(b.length);

		loadPixels();
		for (int i = 0 ; i < pixels.length && i < b.length ; i++){
			// Bytes are from -128 to 127, this converts to 0 to 255 
			//int byteToInt = b[i] & 0xff; 
			//String  intToHex = hex(byteToInt,6);
			//pixels[i] = b[i] & 0xff; 
			pixels [i] = b [i];
		}
		updatePixels();
	}

	void glitchIt() {
		//shuffle the array b, but leave the first byte alone. 
		//Create an array the length of the array "b"
		ArrayList shuffleIndices = new ArrayList();
		for (int i = 1; i < b.length-1; i++){ //One index number for each place for 
			shuffleIndices.add(i); 
		}
		for (int i = 1; i < glitchFactor ; i++){
			int rando = int(random(1,shuffleIndices.size()));
			int indexToMoveToFront = rando; 
			byte jotItDown = b[rando/3];
			b[rando/3] = b[indexToMoveToFront];
			b[indexToMoveToFront] = jotItDown;
			shuffleIndices.remove(rando);
		}

		saveBytes("data/glitched.jpg", b);
		canvasImage = loadImage("data/glitched.jpg");
	}

	void reset(){
		b = loadBytes(inputImageLoc);
	}

	void run(){
		glitchIt();
		drawCollage();
	}

	void printHexValues() {
		//Iterate through the byte array
		for (int i = 0; i < 50 ; i++){
			if( (i%10) == 0){
				println();
		}
		// Bytes are from -128 to 127, this converts to 0 to 255 
		int a = b[i] & 0xff; 
		// Print out the value in 6 digit hex. 
		print(hex(a,6) + " "); 
		}
	}
}




