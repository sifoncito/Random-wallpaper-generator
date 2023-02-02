from PIL import Image
import random
import boto3

s3 = boto3.cleint('s3')
bucket = 'mys3bucketforwallpapers'

def random_color():
    rgbl=[255,0,0]
    random.shuffle(rgbl)
    return tuple(rgbl)

def ChangePixel():
    pixels = im.load()
    for x in range(1920):
        for y in range(1080):
            pixels[x,y] = random_color()

def lambda_handler(event, context):	
	# delete old wallpaper
    s3.delete_object(Bucket=bucket, Key='wallpaper.jpg')
	# save new wallpaper
    with open('/tmp/wallpaper.jpg', 'rb') as data:
        s3.upload_fileobj(data, bucket, 'wallpaper.jpg')

im= Image.new("RGB", (1920, 1080), "#FF0000")
ChangePixel()
im.save("/tmp/wallpaper.jpg")