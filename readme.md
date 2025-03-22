# raspi-slideshow

Utility for preparing and running a slideshow on a raspberry pi. 

Supported file formats (so far): PNG, JPG, PDF

There are two utility scripts:

## prepare.sh

Prepare images for slideshow using ImageMagick. This means
- convert all images to PNG
- adjust size
- fill transparent backgrounds witha defined color
- add a border (with a defined color)

## run-slideshow.sh

Runs the slideshow (full-screen, infinite loop) with FEH ()

# Resources

[Image Magick Cheat Sheet](https://github.com/yangboz/imagemagick-cheatsheet)

[Photo Slideshows Using Raspberry Pi And feh](https://bhoey.com/blog/photo-slideshows-using-raspberry-pi/)
