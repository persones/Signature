# -*- coding: utf-8 -*-
"""
Created on Fri May 31 01:19:29 2013

@author: Person
"""

from PIL import Image, ImageFilter
im = Image.open("../lena.jpg")
im=im.convert('L') # convert image to monochrome - this works
#im = im.filter(ImageFilter.Kernel((3,3), [0, 0.3, 0, 0, 0.3, 0, 0, 0.3, 0], scale=None, offset=0))

threshold = 90
im = im.point(lambda p: p > threshold and 255) 
im = im.filter(ImageFilter.FIND_EDGES)
#im = im.filter(ImageFilter.MaxFilter(size=3))
im=im.convert('1') # convert image to black and white
im = im.point(lambda p: 255 - p)
im.show()