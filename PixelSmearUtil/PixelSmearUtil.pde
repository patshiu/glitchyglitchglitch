//- - - - - - - - - 
// TEST UTILITY
//- - - - - - - - - 

String inputImage;

PImage vig;

PixelSmear pBomb;


void setup() {
	inputImage = "data/gold.jpg";
	vig = requestImage("data/vig.png");
	pBomb = new PixelSmear(inputImage);
	size(800, 641, P2D);
	//blendMode(OVERLAY);
}

void draw() {
	pBomb.warpSmear();
	pBomb.glitchFactor = constrain(map(mouseX, 40, width-40, 1, width), 1, width);
}

void vig(){
	image(vig, 0, 0, width, height);
}

