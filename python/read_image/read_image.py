import matplotlib.image as mi
import matplotlib.pyplot as plt

#Comment - Akshay
#comment - Abhijeet
image = mi.imread("rgb.png")
print(f"Image type is {type(image)}")
print(image) #extra
plt.imshow(image)
plt.show()
