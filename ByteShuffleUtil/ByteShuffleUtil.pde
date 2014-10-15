

ByteShuffle cBomb; 
String inputImage; 
PImage vig;

void setup() {
	
	inputImage = "data/gold.jpg";
	vig = requestImage("data/vig.png");
	cBomb = new ByteShuffle(inputImage);
	size(800, 641, P2D);
	blendMode(OVERLAY);
}

void draw() {
	cBomb.run();
	noLoop();	
}

void mousePressed(){
	redraw();
}

void vig(){
	image(vig, 0, 0, width, height);
}