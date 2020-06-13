import matplotlib.image as mi
import matplotlib.pyplot as plt
debug = True
image = mi.imread("rgb.png")
if debug:
    print(f"Image type is {type(image)}")

print(type(image[0]))
#plt.imshow(image)
#plt.show()
