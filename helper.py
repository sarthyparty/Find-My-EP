from distutils.command.install_egg_info import to_filename
from tokenize import String


def convert(inters):
  return inters.replace(":", "=")

class Intersection:
  def __init__(self, halls, id, x, y):
    self.id = id
    self.x = x
    self.y = y

class Room:
  def __init__(self, name, startDist, hall, x, y):
    self.name = name
    self.startDist = startDist
    self.hall = hall
    self.x = x
    self.y = y

class Hall:
  def __init__(self, start, end, length, id):
    self.start = start
    self.end = end
    self.length = length
    self.id = id

to_convert = '''
    Hall(start: 0, end: 1, length: 28.73, id: 0),
    Hall(start: 0, end: 75, length: 12.83, id: 1),
    Hall(start: 1, end: 2, length: 12.99, id: 2),
    Hall(start: 1, end: 3, length: 5.45, id: 3),
    Hall(start: 1, end: 4, length: 19.72, id: 4),
    Hall(start: 4, end: 7, length: 11.18, id: 5),
    Hall(start: 7, end: 5, length: 15.89, id: 6),
    Hall(start: 5, end: 6, length: 3.64, id: 7),
    Hall(start: 3, end: 8, length: 14.36, id: 8),
    Hall(start: 4, end: 9, length: 5.45, id: 9),
    Hall(start: 8, end: 9, length: 5.36, id: 10),
    Hall(start: 9, end: 76, length: 11.07, id: 11),
    Hall(start: 76, end: 10, length: 1.77, id: 12),
    Hall(start: 76, end: 77, length: 5.09, id: 13),
    Hall(start: 10, end: 11, length: 18.35, id: 14),
    Hall(start: 11, end: 12, length: 4.83, id: 15),
    Hall(start: 12, end: 81, length: 25.91, id: 16),
    Hall(start: 81, end: 82, length: 3.89, id: 17),
    Hall(start: 81, end: 13, length: 3.96, id: 18),
    Hall(start: 13, end: 80, length: 3.89, id: 19),
    Hall(start: 80, end: 82, length: 3.96, id: 20),
    Hall(start: 80, end: 14, length: 11.28, id: 21),
    Hall(start: 14, end: 15, length: 16.01, id: 22),
    Hall(start: 15, end: 17, length: 7.51, id: 23),
    Hall(start: 15, end: 16, length: 19.5, id: 24),
    Hall(start: 16, end: 78, length: 18.26, id: 25),
    Hall(start: 15, end: 78, length: 16.41, id: 26),
    Hall(start: 78, end: 79, length: 14.58, id: 27),
    Hall(start: 17, end: 18, length: 19.5, id: 28),
    Hall(start: 16, end: 18, length: 7.51, id: 29),
    Hall(start: 18, end: 19, length: 3.33, id: 30),
    Hall(start: 16, end: 84, length: 24.55, id: 31),
    Hall(start: 18, end: 85, length: 24.6, id: 32),
    Hall(start: 84, end: 85, length: 6.01, id: 33),
    Hall(start: 85, end: 20, length: 19.72, id: 34),
    Hall(start: 20, end: 22, length: 34.3, id: 35),
    Hall(start: 22, end: 23, length: 4.05, id: 36),
    Hall(start: 23, end: 24, length: 3.43, id: 37),
    Hall(start: 24, end: 86, length: 4.64, id: 38),
    Hall(start: 21, end: 22, length: 11.28, id: 39),
    Hall(start: 10, end: 64, length: 27.57, id: 40),
    Hall(start: 64, end: 65, length: 4.89, id: 41),
    Hall(start: 64, end: 29, length: 19.59, id: 42),
    Hall(start: 29, end: 30, length: 2.58, id: 43),
    Hall(start: 29, end: 28, length: 39.53, id: 44),
    Hall(start: 28, end: 32, length: 7.26, id: 45),
    Hall(start: 28, end: 21, length: 4.8, id: 46),
    Hall(start: 21, end: 25, length: 7.48, id: 47),
    Hall(start: 24, end: 25, length: 11.28, id: 48),
    Hall(start: 25, end: 26, length: 20.9, id: 49),
    Hall(start: 21, end: 27, length: 4.96, id: 50),
    Hall(start: 27, end: 52, length: 28.47, id: 51),
    Hall(start: 52, end: 33, length: 21.5, id: 52),
    Hall(start: 33, end: 31, length: 25.7, id: 53),
    Hall(start: 33, end: 83, length: 12.5, id: 54),
    Hall(start: 83, end: 87, length: 9.75, id: 55),
    Hall(start: 83, end: 34, length: 19.6, id: 56),
    Hall(start: 34, end: 35, length: 11.46, id: 57),
    Hall(start: 34, end: 36, length: 6.2, id: 58),
    Hall(start: 34, end: 37, length: 25.7, id: 59),
    Hall(start: 31, end: 37, length: 32.1, id: 60),
    Hall(start: 37, end: 38, length: 25.92, id: 61),
    Hall(start: 38, end: 40, length: 33.69, id: 62),
    Hall(start: 31, end: 39, length: 13.09, id: 63),
    Hall(start: 39, end: 40, length: 12.93, id: 64),
    Hall(start: 40, end: 41, length: 58.1, id: 65),
    Hall(start: 39, end: 42, length: 15.69, id: 66),
    Hall(start: 42, end: 43, length: 2.71, id: 67),
    Hall(start: 43, end: 44, length: 14.21, id: 68),
    Hall(start: 44, end: 45, length: 3.37, id: 69),
    Hall(start: 46, end: 44, length: 9.84, id: 70),
    Hall(start: 46, end: 45, length: 11.07, id: 71),
    Hall(start: 45, end: 47, length: 19.4, id: 72),
    Hall(start: 46, end: 48, length: 21.52, id: 73),
    Hall(start: 48, end: 49, length: 1.74, id: 74),
    Hall(start: 49, end: 50, length: 33.81, id: 75),
    Hall(start: 50, end: 52, length: 20.15, id: 76),
    Hall(start: 50, end: 53, length: 10.99, id: 77),
    Hall(start: 48, end: 73, length: 19.04, id: 78),
    Hall(start: 73, end: 51, length: 14.77, id: 79),
    Hall(start: 51, end: 53, length: 9.25, id: 80),
    Hall(start: 51, end: 54, length: 4.64, id: 81),
    Hall(start: 54, end: 53, length: 10.35, id: 82),
    Hall(start: 54, end: 88, length: 18.61, id: 83),
    Hall(start: 88, end: 55, length: 6.47, id: 84),
    Hall(start: 55, end: 56, length: 4.92, id: 85),
    Hall(start: 88, end: 56, length: 8.0, id: 86),
    Hall(start: 56, end: 58, length: 3.09, id: 87),
    Hall(start: 58, end: 57, length: 5.98, id: 88),
    Hall(start: 58, end: 59, length: 5.58, id: 89),
    Hall(start: 59, end: 56, length: 6.38, id: 90),
    Hall(start: 56, end: 74, length: 8.87, id: 91),
    Hall(start: 59, end: 60, length: 11.37, id: 92),
    Hall(start: 60, end: 61, length: 8.71, id: 93),
    Hall(start: 61, end: 62, length: 24.77, id: 94),
    Hall(start: 61, end: 63, length: 10.35, id: 95),
    Hall(start: 61, end: 67, length: 10.42, id: 96),
    Hall(start: 67, end: 66, length: 10.37, id: 97),
    Hall(start: 66, end: 68, length: 22.41, id: 98),
    Hall(start: 68, end: 69, length: 11.59, id: 99),
    Hall(start: 69, end: 70, length: 7.1, id: 100),
    Hall(start: 7, end: 71, length: 35.04, id: 101),
    Hall(start: 69, end: 71, length: 34.39, id: 102),
    Hall(start: 71, end: 72, length: 12.62, id: 103),
    Hall(start: 63, end: 67, length: 1.22, id: 105),
'''

halls = [
    Hall(start= 0, end= 1, length= 28.73, id= 0),
    Hall(start= 0, end= 75, length= 12.83, id= 1),
    Hall(start= 1, end= 2, length= 12.99, id= 2),
    Hall(start= 1, end= 3, length= 5.45, id= 3),
    Hall(start= 1, end= 4, length= 19.72, id= 4),
    Hall(start= 4, end= 7, length= 11.18, id= 5),
    Hall(start= 7, end= 5, length= 15.89, id= 6),
    Hall(start= 5, end= 6, length= 3.64, id= 7),
    Hall(start= 3, end= 8, length= 14.36, id= 8),
    Hall(start= 4, end= 9, length= 5.45, id= 9),
    Hall(start= 8, end= 9, length= 5.36, id= 10),
    Hall(start= 9, end= 76, length= 11.07, id= 11),
    Hall(start= 76, end= 10, length= 1.77, id= 12),
    Hall(start= 76, end= 77, length= 5.09, id= 13),
    Hall(start= 10, end= 11, length= 18.35, id= 14),
    Hall(start= 11, end= 12, length= 4.83, id= 15),
    Hall(start= 12, end= 81, length= 25.91, id= 16),
    Hall(start= 81, end= 82, length= 3.89, id= 17),
    Hall(start= 81, end= 13, length= 3.96, id= 18),
    Hall(start= 13, end= 80, length= 3.89, id= 19),
    Hall(start= 80, end= 82, length= 3.96, id= 20),
    Hall(start= 80, end= 14, length= 11.28, id= 21),
    Hall(start= 14, end= 15, length= 16.01, id= 22),
    Hall(start= 15, end= 17, length= 7.51, id= 23),
    Hall(start= 15, end= 16, length= 19.5, id= 24),
    Hall(start= 16, end= 78, length= 18.26, id= 25),
    Hall(start= 15, end= 78, length= 16.41, id= 26),
    Hall(start= 78, end= 79, length= 14.58, id= 27),
    Hall(start= 17, end= 18, length= 19.5, id= 28),
    Hall(start= 16, end= 18, length= 7.51, id= 29),
    Hall(start= 18, end= 19, length= 3.33, id= 30),
    Hall(start= 16, end= 84, length= 24.55, id= 31),
    Hall(start= 18, end= 85, length= 24.6, id= 32),
    Hall(start= 84, end= 85, length= 6.01, id= 33),
    Hall(start= 85, end= 20, length= 19.72, id= 34),
    Hall(start= 20, end= 22, length= 34.3, id= 35),
    Hall(start= 22, end= 23, length= 4.05, id= 36),
    Hall(start= 23, end= 24, length= 3.43, id= 37),
    Hall(start= 24, end= 86, length= 4.64, id= 38),
    Hall(start= 21, end= 22, length= 11.28, id= 39),
    Hall(start= 10, end= 64, length= 27.57, id= 40),
    Hall(start= 64, end= 65, length= 4.89, id= 41),
    Hall(start= 64, end= 29, length= 19.59, id= 42),
    Hall(start= 29, end= 30, length= 2.58, id= 43),
    Hall(start= 29, end= 28, length= 39.53, id= 44),
    Hall(start= 28, end= 32, length= 7.26, id= 45),
    Hall(start= 28, end= 21, length= 4.8, id= 46),
    Hall(start= 21, end= 25, length= 7.48, id= 47),
    Hall(start= 24, end= 25, length= 11.28, id= 48),
    Hall(start= 25, end= 26, length= 20.9, id= 49),
    Hall(start= 21, end= 27, length= 4.96, id= 50),
    Hall(start= 27, end= 52, length= 28.47, id= 51),
    Hall(start= 52, end= 33, length= 21.5, id= 52),
    Hall(start= 33, end= 31, length= 25.7, id= 53),
    Hall(start= 33, end= 83, length= 12.5, id= 54),
    Hall(start= 83, end= 87, length= 9.75, id= 55),
    Hall(start= 83, end= 34, length= 19.6, id= 56),
    Hall(start= 34, end= 35, length= 11.46, id= 57),
    Hall(start= 34, end= 36, length= 6.2, id= 58),
    Hall(start= 34, end= 37, length= 25.7, id= 59),
    Hall(start= 31, end= 37, length= 32.1, id= 60),
    Hall(start= 37, end= 38, length= 25.92, id= 61),
    Hall(start= 38, end= 40, length= 33.69, id= 62),
    Hall(start= 31, end= 39, length= 13.09, id= 63),
    Hall(start= 39, end= 40, length= 12.93, id= 64),
    Hall(start= 40, end= 41, length= 58.1, id= 65),
    Hall(start= 39, end= 42, length= 15.69, id= 66),
    Hall(start= 42, end= 43, length= 2.71, id= 67),
    Hall(start= 43, end= 44, length= 14.21, id= 68),
    Hall(start= 44, end= 45, length= 3.37, id= 69),
    Hall(start= 46, end= 44, length= 9.84, id= 70),
    Hall(start= 46, end= 45, length= 11.07, id= 71),
    Hall(start= 45, end= 47, length= 19.4, id= 72),
    Hall(start= 46, end= 48, length= 21.52, id= 73),
    Hall(start= 48, end= 49, length= 1.74, id= 74),
    Hall(start= 49, end= 50, length= 33.81, id= 75),
    Hall(start= 50, end= 52, length= 20.15, id= 76),
    Hall(start= 50, end= 53, length= 10.99, id= 77),
    Hall(start= 48, end= 73, length= 19.04, id= 78),
    Hall(start= 73, end= 51, length= 14.77, id= 79),
    Hall(start= 51, end= 53, length= 9.25, id= 80),
    Hall(start= 51, end= 54, length= 4.64, id= 81),
    Hall(start= 54, end= 53, length= 10.35, id= 82),
    Hall(start= 54, end= 88, length= 18.61, id= 83),
    Hall(start= 88, end= 55, length= 6.47, id= 84),
    Hall(start= 55, end= 56, length= 4.92, id= 85),
    Hall(start= 88, end= 56, length= 8.0, id= 86),
    Hall(start= 56, end= 58, length= 3.09, id= 87),
    Hall(start= 58, end= 57, length= 5.98, id= 88),
    Hall(start= 58, end= 59, length= 5.58, id= 89),
    Hall(start= 59, end= 56, length= 6.38, id= 90),
    Hall(start= 56, end= 74, length= 8.87, id= 91),
    Hall(start= 59, end= 60, length= 11.37, id= 92),
    Hall(start= 60, end= 61, length= 8.71, id= 93),
    Hall(start= 61, end= 62, length= 24.77, id= 94),
    Hall(start= 61, end= 63, length= 10.35, id= 95),
    Hall(start= 61, end= 67, length= 10.42, id= 96),
    Hall(start= 67, end= 66, length= 10.37, id= 97),
    Hall(start= 66, end= 68, length= 22.41, id= 98),
    Hall(start= 68, end= 69, length= 11.59, id= 99),
    Hall(start= 69, end= 70, length= 7.1, id= 100),
    Hall(start= 7, end= 71, length= 35.04, id= 101),
    Hall(start= 69, end= 71, length= 34.39, id= 102),
    Hall(start= 71, end= 72, length= 12.62, id= 103),
    Hall(start= 63, end= 67, length= 1.22, id= 105),
]

intersects = [
    Intersection(halls= [], id= 0, x= 70.65, y= 399.06),
    Intersection(halls= [], id= 1, x= 99.38, y= 399.06),
    Intersection(halls= [], id= 2, x= 99.38, y= 386.07),
    Intersection(halls= [], id= 3, x= 99.38, y= 404.51),
    Intersection(halls= [], id= 4, x= 119.10, y= 399.06),
    Intersection(halls= [], id= 5, x= 119.10, y= 371.99),
    Intersection(halls= [], id= 6, x= 122.74, y= 371.99),
    Intersection(halls= [], id= 7, x= 119.10, y= 387.88),
    Intersection(halls= [], id= 8, x= 113.74, y= 404.51),
    Intersection(halls= [], id= 9, x= 119.10, y= 404.51),
    Intersection(halls= [], id= 10, x= 119.10, y= 417.35),
    Intersection(halls= [], id= 11, x= 119.10, y= 435.70),
    Intersection(halls= [], id= 12, x= 115.64, y= 439.07),
    Intersection(halls= [], id= 13, x= 115.64, y= 468.94),
    Intersection(halls= [], id= 14, x= 130.81, y= 468.94),
    Intersection(halls= [], id= 15, x= 146.82, y= 468.94),
    Intersection(halls= [], id= 16, x= 166.32, y= 468.94),
    Intersection(halls= [], id= 17, x= 146.82, y= 461.43),
    Intersection(halls= [], id= 18, x= 166.32, y= 461.43),
    Intersection(halls= [], id= 19, x= 166.32, y= 458.10),
    Intersection(halls= [], id= 20, x= 210.59, y= 462.93),
    Intersection(halls= [], id= 21, x= 210.59, y= 417.35),
    Intersection(halls= [], id= 22, x= 210.59, y= 428.63),
    Intersection(halls= [], id= 23, x= 214.64, y= 428.63),
    Intersection(halls= [], id= 24, x= 218.07, y= 428.63),
    Intersection(halls= [], id= 25, x= 218.07, y= 417.35),
    Intersection(halls= [], id= 26, x= 238.97, y= 417.35),
    Intersection(halls= [], id= 27, x= 210.59, y= 412.39),
    Intersection(halls= [], id= 28, x= 205.79, y= 417.35),
    Intersection(halls= [], id= 29, x= 166.26, y= 417.35),
    Intersection(halls= [], id= 30, x= 166.26, y= 419.93),
    Intersection(halls= [], id= 31, x= 286.26, y= 412.39),
    Intersection(halls= [], id= 32, x= 205.79, y= 410.09),
    Intersection(halls= [], id= 33, x= 260.56, y= 412.39),
    Intersection(halls= [], id= 34, x= 260.56, y= 444.49),
    Intersection(halls= [], id= 35, x= 249.13, y= 443.73),
    Intersection(halls= [], id= 36, x= 260.56, y= 450.69),
    Intersection(halls= [], id= 37, x= 286.26, y= 444.49),
    Intersection(halls= [], id= 38, x= 312.18, y= 444.49),
    Intersection(halls= [], id= 39, x= 299.25, y= 410.80),
    Intersection(halls= [], id= 40, x= 312.18, y= 410.80),
    Intersection(halls= [], id= 41, x= 370.28, y= 410.80),
    Intersection(halls= [], id= 42, x= 299.25, y= 395.11),
    Intersection(halls= [], id= 43, x= 296.54, y= 395.11),
    Intersection(halls= [], id= 44, x= 296.54, y= 380.90),
    Intersection(halls= [], id= 45, x= 299.91, y= 380.90),
    Intersection(halls= [], id= 46, x= 294.39, y= 390.50),
    Intersection(halls= [], id= 47, x= 319.31, y= 380.90),
    Intersection(halls= [], id= 48, x= 272.87, y= 390.50),
    Intersection(halls= [], id= 49, x= 272.87, y= 392.24),
    Intersection(halls= [], id= 50, x= 239.06, y= 392.24),
    Intersection(halls= [], id= 51, x= 239.06, y= 390.50),
    Intersection(halls= [], id= 52, x= 239.06, y= 412.39),
    Intersection(halls= [], id= 53, x= 239.06, y= 381.25),
    Intersection(halls= [], id= 54, x= 234.42, y= 390.50),
    Intersection(halls= [], id= 55, x= 232.46, y= 365.55),
    Intersection(halls= [], id= 56, x= 227.54, y= 365.55),
    Intersection(halls= [], id= 57, x= 227.54, y= 356.48),
    Intersection(halls= [], id= 58, x= 227.54, y= 362.46),
    Intersection(halls= [], id= 59, x= 221.96, y= 362.46),
    Intersection(halls= [], id= 60, x= 210.59, y= 362.46),
    Intersection(halls= [], id= 61, x= 208.85, y= 353.93),
    Intersection(halls= [], id= 62, x= 208.85, y= 329.16),
    Intersection(halls= [], id= 63, x= 198.50, y= 353.93),
    Intersection(halls= [], id= 64, x= 146.67, y= 417.35),
    Intersection(halls= [], id= 65, x= 146.67, y= 412.46),
    Intersection(halls= [], id= 66, x= 188.13, y= 352.71),
    Intersection(halls= [], id= 67, x= 198.50, y= 352.71),
    Intersection(halls= [], id= 68, x= 165.73, y= 353.49),
    Intersection(halls= [], id= 69, x= 154.14, y= 353.49),
    Intersection(halls= [], id= 70, x= 147.04, y= 353.49),
    Intersection(halls= [], id= 71, x= 154.14, y= 387.88),
    Intersection(halls= [], id= 72, x= 166.76, y= 387.88),
    Intersection(halls= [], id= 73, x= 253.83, y= 390.50),
    Intersection(halls= [], id= 74, x= 220.90, y= 371.43),
    Intersection(halls= [], id= 75, x= 65.92, y= 387.13),
    Intersection(halls= [], id= 76, x= 119.10, y= 415.58),
    Intersection(halls= [], id= 77, x= 114.01, y= 415.58),
    Intersection(halls= [], id= 78, x= 154.92, y= 483.21),
    Intersection(halls= [], id= 79, x= 144.86, y= 493.77),
    Intersection(halls= [], id= 80, x= 119.53, y= 468.94),
    Intersection(halls= [], id= 81, x= 115.64, y= 464.98),
    Intersection(halls= [], id= 82, x= 119.53, y= 464.98),
    Intersection(halls= [], id= 83, x= 260.56, y= 424.89),
    Intersection(halls= [], id= 84, x= 190.87, y= 468.94),
    Intersection(halls= [], id= 85, x= 190.87, y= 462.93),
    Intersection(halls= [], id= 86, x= 218.07, y= 433.27),
    Intersection(halls= [], id= 87, x= 270.31, y= 424.89),
    Intersection(halls= [], id= 88, x= 232.24, y= 372.02),
]

rooms = [
    Room(name= "220 Classroom", startDist= 0, hall= 0, x= 70.65, y= 399.06),
    Room(name= "219 Science Lab", startDist= 0, hall= 0, x= 70.65, y= 399.06),
    Room(name= "218 Classroom", startDist= 3.06, hall= 0, x= 73.71, y= 399.06),
    Room(name= "221 Classroom", startDist= 3.06, hall= 0, x= 73.71, y= 399.06),
    Room(name= "217 Classroom", startDist= 19.38, hall= 0, x= 90.03, y= 399.06),
    Room(name= "222 Classroom", startDist= 19.38, hall= 0, x= 90.03, y= 399.06),
]



def dist(x1, x2, y1, y2):
  return abs((x2-x1)**2 + (y2-y1)**2)**0.5

# def get_hall(start, end, id):
#   d = dist(intersects[start].x, intersects[end].x, intersects[start].y, intersects[end].y)
#   s = f'Hall(start: {start}, end: {end}, length: {round(d,2)}, id: {id}),'
#   return s

# print(convert(to_convert))

# ans=input('Enter {start-end-id}, or end')
# strs = [

# ]
# while ans!='end':
#   stuff = ans.split('-')
#   start = int(stuff[0])
#   end = int(stuff[1])
#   id = int(stuff[2])
#   strs.append(get_hall(start,end,id))
#   ans = input('Enter {start-end-id}')

# print('[')
# for s in strs:
#   print(s)
# print(']')

for i in intersects:
  i.x = i.x*1.197-42.64
  i.y = i.y*1.2-95.33+364.48598035770806-358.87-1.5
  print(f'Intersection(halls: [], id: {i.id}, x: {round(i.x,2)}, y: {round(i.y,2)}),')

for h in halls:
  s = intersects[h.start]
  e = intersects[h.end]
  h.length = round(dist(s.x,e.x,s.y,e.y),2)
  print(f'Hall(start: {h.start}, end: {h.end}, length: {h.length}, id: {h.id}),')


for i in rooms:
  i.x = i.x*1.197-42.64
  i.y = i.y*1.2-95.33+364.48598035770806-358.87-1.5
  s = intersects[halls[i.hall].start]
  i.startDist = round(dist(i.x, s.x, i.y, s.y),2)
  print(f'Room(name: "{i.name}", startDist: {i.startDist}, hall: {i.hall}, x: {round(i.x,2)}, y: {round(i.y,2)}),')



