from PIL import Image
import random

def random_color():
    rgbl=[255,0,0]
    random.shuffle(rgbl)
    return tuple(rgbl)

def ChangePixel():
    pixels = im.load()
    for x in range(1920):
        for y in range(1080):
            pixels[x,y] = random_color()



im= Image.new("RGB", (1920, 1080), "#FF0000")
ChangePixel()
im.show()