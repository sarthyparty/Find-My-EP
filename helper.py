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
    Room(name: "313 Math Resource Center (MRC)", startDist: 5.42, hall: 1, x: 86.51, y: 384.78),
    Room(name: "314", startDist: 9.66, hall: 0, x: 48.14, y: 390.21),
    Room(name: "315", startDist: 0.0, hall: 0, x: 38.48, y: 390.21),
    Room(name: "316", startDist: 0.0, hall: 0, x: 38.48, y: 390.21),
    Room(name: "317", startDist: 6.01, hall: 0, x: 44.49, y: 390.21),
    Room(name: "318", startDist: 9.66, hall: 0, x: 48.14, y: 390.21),
    Room(name: "319", startDist: 28.64, hall: 0, x: 67.13, y: 390.21),
    Room(name: "320", startDist: 33.04, hall: 0, x: 71.52, y: 390.21),
    Room(name: "320", startDist: 33.04, hall: 0, x: 71.52, y: 390.21),
    Room(name: "312", startDist: 6.04, hall: 10, x: 107.1, y: 376.19),
    Room(name: "323", startDist: 6.04, hall: 10, x: 107.1, y: 376.19),
    Room(name: "311", startDist: 21.12, hall: 10, x: 122.18, y: 376.19),
    Room(name: "324", startDist: 33.39, hall: 10, x: 134.45, y: 376.19),
    Room(name: "310", startDist: 16.82, hall: 11, x: 143.08, y: 358.91),
    Room(name: "306", startDist: 17.35, hall: 11, x: 143.08, y: 357.88),
    Room(name: "309", startDist: 35.73, hall: 11, x: 143.08, y: 340.156),
    Room(name: "307", startDist: 36.63, hall: 11, x: 143.08, y: 339.22),
    Room(name: "308", startDist: 39.4, hall: 11, x: 143.08, y: 336),
    Room(name: "322", startDist: 6.73, hall: 7, x: 101.06, y: 396.76),
    Room(name: "321", startDist: 17.28, hall: 8, x: 123.3, y: 411.59),
    Room(name: "305", startDist: 21.6, hall: 14, x: 167.94, y: 376.19),
    Room(name: "325", startDist: 2.62, hall: 25, x: 160.75, y: 379.346),
    Room(name: "326", startDist: 14.4, hall: 25, x: 160.75, y: 391.09),
    Room(name: "327", startDist: 26.26, hall: 25, x: 160.75, y: 402.49),
    Room(name: "328 World Language Dept", startDist: 14.2, hall: 14, x: 175.265, y: 376.19),
    Room(name: "304", startDist: 11.53, hall: 15, x: 195.7, y: 364.8),
    Room(name: "303", startDist: 22.53, hall: 15, x: 195.7, y: 353.74),
    Room(name: "302", startDist: 31.07, hall: 15, x: 195.7, y: 345.12),
    Room(name: "301", startDist: 31.07, hall: 15, x: 195.7, y: 345.12),
    Room(name: "300A", startDist: 15.54, hall: 32, x: 206.76, y: 330.06),
    Room(name: "300", startDist: 12.37, hall: 34, x: 206.76, y: 315.2),
    Room(name: "349", startDist: 3.33, hall: 33, x: 210.37, y: 327.85),
    Room(name: "348", startDist: 19.89, hall: 17, x: 226.66, y: 345.73),
    Room(name: "329", startDist: 10.71, hall: 17, x: 217.66, y: 345.73),
    Room(name: "347", startDist: 31.73, hall: 17, x: 238.19, y: 345.73),
    Room(name: "346", startDist: 4.65, hall: 18, x: 238.19, y: 350.56),
    Room(name: "330", startDist: 8.166, hall: 19, x: 238.19, y: 371.31),
    Room(name: "331", startDist: 10.59, hall: 19, x: 238.19, y: 373.74),
    Room(name: "332", startDist: 11.746, hall: 30, x: 238.19, y: 394.27),
    Room(name: "345", startDist: 11.75, hall: 24, x: 250.31, y: 362.88),
    Room(name: "333", startDist: 13.05, hall: 21, x: 251.4, y: 382.21),
    Room(name: "334", startDist: 13.05, hall: 21, x: 251.4, y: 382.21),
    Room(name: "344 Science Resource Center (SRC)", startDist: 14.028, hall: 21, x: 252.4, y: 382.21),
    Room(name: "335", startDist: 25.39, hall: 21, x: 263.86, y: 382.21),
    Room(name: "335A", startDist: 27.7, hall: 21, x: 266.17, y: 382.21),
    Room(name: "343", startDist: 11.96, hall: 26, x: 284.8, y: 370.38),
    Room(name: "342", startDist: 23.68, hall: 26, x: 296.635, y: 370.38),
    Room(name: "341", startDist: 26.01, hall: 26, x: 298.97, y: 370.38),
    Room(name: "336", startDist: 18.41, hall: 26, x: 291.15, y: 370.38),
    Room(name: "340", startDist: 0, hall: 28, x: 310.56, y: 368.41),
    Room(name: "339", startDist: 11.68, hall: 28, x: 322.24, y: 368.41),
    Room(name: "337", startDist: 9.793, hall: 28, x: 320.31, y: 368.41),
    Room(name: "338", startDist: 26.574, hall: 28, x: 337.507, y: 368.41),

    Intersection(halls: [], id: 0, x: 38.48, y: 390.21),
    Intersection(halls: [], id: 1, x: 86.51, y: 390.21),
    Intersection(halls: [], id: 2, x: 86.51, y: 384.78),
    Intersection(halls: [], id: 3, x: 96.51, y: 390.21),
    Intersection(halls: [], id: 4, x: 101.06, y: 390.21),
    Intersection(halls: [], id: 5, x: 101.06, y: 376.19),
    Intersection(halls: [], id: 6, x: 101.06, y: 357.05),
    Intersection(halls: [], id: 7, x: 105.48, y: 357.05),
    Intersection(halls: [], id: 8, x: 101.06, y: 411.59),
    Intersection(halls: [], id: 9, x: 135.51, y: 411.59),
    Intersection(halls: [], id: 10, x: 135.51, y: 405.83),
    Intersection(halls: [], id: 11, x: 143.08, y: 376.19),
    Intersection(halls: [], id: 12, x: 157.17, y: 376.19),
    Intersection(halls: [], id: 13, x: 160.75, y: 376.19),
    Intersection(halls: [], id: 14, x: 143.08, y: 336),
    Intersection(halls: [], id: 15, x: 134.48, y: 336),
    Intersection(halls: [], id: 16, x: 195.7, y: 376.19),
    Intersection(halls: [], id: 17, x: 160.75, y: 415.55),
    Intersection(halls: [], id: 18, x: 195.7, y: 345.73),
    Intersection(halls: [], id: 19, x: 206.76, y: 345.73),
    Intersection(halls: [], id: 20, x: 238.19, y: 345.73),
    Intersection(halls: [], id: 21, x: 238.19, y: 362.88),
    Intersection(halls: [], id: 22, x: 238.19, y: 382.21),
    Intersection(halls: [], id: 23, x: 238.19, y: 397.05),
    Intersection(halls: [], id: 24, x: 210.02, y: 397.05),
    Intersection(halls: [], id: 25, x: 210.02, y: 402.65),
    Intersection(halls: [], id: 26, x: 272.68, y: 362.88),
    Intersection(halls: [], id: 27, x: 272.68, y: 370.38),
    Intersection(halls: [], id: 28, x: 272.68, y: 381.9),
    Intersection(halls: [], id: 29, x: 307.76, y: 370.38),
    Intersection(halls: [], id: 30, x: 310.56, y: 368.41),
    Intersection(halls: [], id: 31, x: 337.507, y: 368.41),
    Intersection(halls: [], id: 32, x: 206.76, y: 327.85),
    Intersection(halls: [], id: 33, x: 210.37, y: 327.85),
    Intersection(halls: [], id: 34, x: 206.76, y: 315.2),
    Intersection(halls: [], id: 35, x: 260.25, y: 362.88),
    Intersection(halls: [], id: 36, x: 38.48, y: 378.47)

    Hall(start: 0, end: 1, length: 49.41, id: 0),
    Hall(start: 1, end: 2, length: 5.42, id: 1),
    Hall(start: 1, end: 3, length: 8.62, id: 2),
    Hall(start: 3, end: 4, length: 6.19, id: 3),
    Hall(start: 4, end: 5, length: 14.02, id: 4),
    Hall(start: 5, end: 6, length: 19.14, id: 5),
    Hall(start: 6, end: 7, length: 4.48, id: 6),
    Hall(start: 4, end: 8, length: 21.38, id: 7),
    Hall(start: 8, end: 9, length: 32.81, id: 8),
    Hall(start: 9, end: 10, length: 5.76, id: 9),
    Hall(start: 5, end: 11, length: 42.13, id: 10),
    Hall(start: 11, end: 14, length: 41.35, id: 11),
    Hall(start: 14, end: 15, length: 8.99, id: 12),
    Hall(start: 11, end: 12, length: 14.51, id: 13),
    Hall(start: 13, end: 16, length: 35.17, id: 14),
    Hall(start: 16, end: 18, length: 31.07, id: 15),
    Hall(start: 18, end: 19, length: 13.17, id: 16),
    Hall(start: 19, end: 20, length: 29.97, id: 17),
    Hall(start: 20, end: 21, length: 17.76, id: 18),
    Hall(start: 21, end: 22, length: 19.33, id: 19),
    Hall(start: 23, end: 24, length: 31.35, id: 20),
    Hall(start: 22, end: 28, length: 34.83, id: 21),
    Hall(start: 27, end: 28, length: 11.52, id: 22),
    Hall(start: 26, end: 27, length: 7.5, id: 23),
    Hall(start: 21, end: 35, length: 21.84, id: 24),
    Hall(start: 13, end: 17, length: 39.36, id: 25),
    Hall(start: 27, end: 29, length: 37.81, id: 26),
    Hall(start: 29, end: 30, length: 2.87, id: 27),
    Hall(start: 30, end: 31, length: 25.63, id: 28),
    Hall(start: 24, end: 25, length: 5.6, id: 29),
    Hall(start: 22, end: 23, length: 14.83, id: 30),
    Hall(start: 12, end: 13, length: 3.87, id: 31),
    Hall(start: 19, end: 32, length: 17.41, id: 32),
    Hall(start: 32, end: 33, length: 3.33, id: 33),
    Hall(start: 32, end: 34, length: 12.37, id: 34),
    Hall(start: 26, end: 35, length: 12.99, id: 35),
    Hall(start: 0, end: 36, length: 11.80, id: 36)


'''

halls = [
    Hall(start= 0, end= 1, length= 49.41, id= 0),
    Hall(start= 1, end= 2, length= 5.42, id= 1),
    Hall(start= 1, end= 3, length= 8.62, id= 2),
    Hall(start= 3, end= 4, length= 6.19, id= 3),
    Hall(start= 4, end= 5, length= 14.02, id= 4),
    Hall(start= 5, end= 6, length= 19.14, id= 5),
    Hall(start= 6, end= 7, length= 4.48, id= 6),
    Hall(start= 4, end= 8, length= 21.38, id= 7),
    Hall(start= 8, end= 9, length= 32.81, id= 8),
    Hall(start= 9, end= 10, length= 5.76, id= 9),
    Hall(start= 5, end= 11, length= 42.13, id= 10),
    Hall(start= 11, end= 14, length= 41.35, id= 11),
    Hall(start= 14, end= 15, length= 8.99, id= 12),
    Hall(start= 11, end= 12, length= 14.51, id= 13),
    Hall(start= 13, end= 16, length= 35.17, id= 14),
    Hall(start= 16, end= 18, length= 31.07, id= 15),
    Hall(start= 18, end= 19, length= 13.17, id= 16),
    Hall(start= 19, end= 20, length= 29.97, id= 17),
    Hall(start= 20, end= 21, length= 17.76, id= 18),
    Hall(start= 21, end= 22, length= 19.33, id= 19),
    Hall(start= 23, end= 24, length= 31.35, id= 20),
    Hall(start= 22, end= 28, length= 34.83, id= 21),
    Hall(start= 27, end= 28, length= 11.52, id= 22),
    Hall(start= 26, end= 27, length= 7.5, id= 23),
    Hall(start= 21, end= 35, length= 21.84, id= 24),
    Hall(start= 13, end= 17, length= 39.36, id= 25),
    Hall(start= 27, end= 29, length= 37.81, id= 26),
    Hall(start= 29, end= 30, length= 2.87, id= 27),
    Hall(start= 30, end= 31, length= 25.63, id= 28),
    Hall(start= 24, end= 25, length= 5.6, id= 29),
    Hall(start= 22, end= 23, length= 14.83, id= 30),
    Hall(start= 12, end= 13, length= 3.87, id= 31),
    Hall(start= 19, end= 32, length= 17.41, id= 32),
    Hall(start= 32, end= 33, length= 3.33, id= 33),
    Hall(start= 32, end= 34, length= 12.37, id= 34),
    Hall(start= 26, end= 35, length= 12.99, id= 35),
    Hall(start= 0, end= 36, length= 11.80, id= 36)
]

intersects = [
    Intersection(halls= [], id= 0, x= 38.48, y= 390.21),
    Intersection(halls= [], id= 1, x= 86.51, y= 390.21),
    Intersection(halls= [], id= 2, x= 86.51, y= 384.78),
    Intersection(halls= [], id= 3, x= 96.51, y= 390.21),
    Intersection(halls= [], id= 4, x= 101.06, y= 390.21),
    Intersection(halls= [], id= 5, x= 101.06, y= 376.19),
    Intersection(halls= [], id= 6, x= 101.06, y= 357.05),
    Intersection(halls= [], id= 7, x= 105.48, y= 357.05),
    Intersection(halls= [], id= 8, x= 101.06, y= 411.59),
    Intersection(halls= [], id= 9, x= 135.51, y= 411.59),
    Intersection(halls= [], id= 10, x= 135.51, y= 405.83),
    Intersection(halls= [], id= 11, x= 143.08, y= 376.19),
    Intersection(halls= [], id= 12, x= 157.17, y= 376.19),
    Intersection(halls= [], id= 13, x= 160.75, y= 376.19),
    Intersection(halls= [], id= 14, x= 143.08, y= 336),
    Intersection(halls= [], id= 15, x= 134.48, y= 336),
    Intersection(halls= [], id= 16, x= 195.7, y= 376.19),
    Intersection(halls= [], id= 17, x= 160.75, y= 415.55),
    Intersection(halls= [], id= 18, x= 195.7, y= 345.73),
    Intersection(halls= [], id= 19, x= 206.76, y= 345.73),
    Intersection(halls= [], id= 20, x= 238.19, y= 345.73),
    Intersection(halls= [], id= 21, x= 238.19, y= 362.88),
    Intersection(halls= [], id= 22, x= 238.19, y= 382.21),
    Intersection(halls= [], id= 23, x= 238.19, y= 397.05),
    Intersection(halls= [], id= 24, x= 210.02, y= 397.05),
    Intersection(halls= [], id= 25, x= 210.02, y= 402.65),
    Intersection(halls= [], id= 26, x= 272.68, y= 362.88),
    Intersection(halls= [], id= 27, x= 272.68, y= 370.38),
    Intersection(halls= [], id= 28, x= 272.68, y= 381.9),
    Intersection(halls= [], id= 29, x= 307.76, y= 370.38),
    Intersection(halls= [], id= 30, x= 310.56, y= 368.41),
    Intersection(halls= [], id= 31, x= 337.507, y= 368.41),
    Intersection(halls= [], id= 32, x= 206.76, y= 327.85),
    Intersection(halls= [], id= 33, x= 210.37, y= 327.85),
    Intersection(halls= [], id= 34, x= 206.76, y= 315.2),
    Intersection(halls= [], id= 35, x= 260.25, y= 362.88),
    Intersection(halls= [], id= 36, x= 38.48, y= 378.47)
]

rooms = [
    Room(name= "313 Math Resource Center (MRC)", startDist= 5.42, hall= 1, x= 86.51, y= 384.78),
    Room(name= "314", startDist= 9.66, hall= 0, x= 48.14, y= 390.21),
    Room(name= "315", startDist= 0.0, hall= 0, x= 38.48, y= 390.21),
    Room(name= "316", startDist= 0.0, hall= 0, x= 38.48, y= 390.21),
    Room(name= "317", startDist= 6.01, hall= 0, x= 44.49, y= 390.21),
    Room(name= "318", startDist= 9.66, hall= 0, x= 48.14, y= 390.21),
    Room(name= "319", startDist= 28.64, hall= 0, x= 67.13, y= 390.21),
    Room(name= "320", startDist= 33.04, hall= 0, x= 71.52, y= 390.21),
    Room(name= "320", startDist= 33.04, hall= 0, x= 71.52, y= 390.21),
    Room(name= "312", startDist= 6.04, hall= 10, x= 107.1, y= 376.19),
    Room(name= "323", startDist= 6.04, hall= 10, x= 107.1, y= 376.19),
    Room(name= "311", startDist= 21.12, hall= 10, x= 122.18, y= 376.19),
    Room(name= "324", startDist= 33.39, hall= 10, x= 134.45, y= 376.19),
    Room(name= "310", startDist= 16.82, hall= 11, x= 143.08, y= 358.91),
    Room(name= "306", startDist= 17.35, hall= 11, x= 143.08, y= 357.88),
    Room(name= "309", startDist= 35.73, hall= 11, x= 143.08, y= 340.156),
    Room(name= "307", startDist= 36.63, hall= 11, x= 143.08, y= 339.22),
    Room(name= "308", startDist= 39.4, hall= 11, x= 143.08, y= 336),
    Room(name= "322", startDist= 6.73, hall= 7, x= 101.06, y= 396.76),
    Room(name= "321", startDist= 17.28, hall= 8, x= 123.3, y= 411.59),
    Room(name= "305", startDist= 21.6, hall= 14, x= 167.94, y= 376.19),
    Room(name= "325", startDist= 2.62, hall= 25, x= 160.75, y= 379.346),
    Room(name= "326", startDist= 14.4, hall= 25, x= 160.75, y= 391.09),
    Room(name= "327", startDist= 26.26, hall= 25, x= 160.75, y= 402.49),
    Room(name= "328 World Language Dept", startDist= 14.2, hall= 14, x= 175.265, y= 376.19),
    Room(name= "304", startDist= 11.53, hall= 15, x= 195.7, y= 364.8),
    Room(name= "303", startDist= 22.53, hall= 15, x= 195.7, y= 353.74),
    Room(name= "302", startDist= 31.07, hall= 15, x= 195.7, y= 345.12),
    Room(name= "301", startDist= 31.07, hall= 15, x= 195.7, y= 345.12),
    Room(name= "300A", startDist= 15.54, hall= 32, x= 206.76, y= 330.06),
    Room(name= "300", startDist= 12.37, hall= 34, x= 206.76, y= 315.2),
    Room(name= "349", startDist= 3.33, hall= 33, x= 210.37, y= 327.85),
    Room(name= "348", startDist= 19.89, hall= 17, x= 226.66, y= 345.73),
    Room(name= "329", startDist= 10.71, hall= 17, x= 217.66, y= 345.73),
    Room(name= "347", startDist= 31.73, hall= 17, x= 238.19, y= 345.73),
    Room(name= "346", startDist= 4.65, hall= 18, x= 238.19, y= 350.56),
    Room(name= "330", startDist= 8.166, hall= 19, x= 238.19, y= 371.31),
    Room(name= "331", startDist= 10.59, hall= 19, x= 238.19, y= 373.74),
    Room(name= "332", startDist= 11.746, hall= 30, x= 238.19, y= 394.27),
    Room(name= "345", startDist= 11.75, hall= 24, x= 250.31, y= 362.88),
    Room(name= "333", startDist= 13.05, hall= 21, x= 251.4, y= 382.21),
    Room(name= "334", startDist= 13.05, hall= 21, x= 251.4, y= 382.21),
    Room(name= "344 Science Resource Center (SRC)", startDist= 14.028, hall= 21, x= 252.4, y= 382.21),
    Room(name= "335", startDist= 25.39, hall= 21, x= 263.86, y= 382.21),
    Room(name= "335A", startDist= 27.7, hall= 21, x= 266.17, y= 382.21),
    Room(name= "343", startDist= 11.96, hall= 26, x= 284.8, y= 370.38),
    Room(name= "342", startDist= 23.68, hall= 26, x= 296.635, y= 370.38),
    Room(name= "341", startDist= 26.01, hall= 26, x= 298.97, y= 370.38),
    Room(name= "336", startDist= 18.41, hall= 26, x= 291.15, y= 370.38),
    Room(name= "340", startDist= 0, hall= 28, x= 310.56, y= 368.41),
    Room(name= "339", startDist= 11.68, hall= 28, x= 322.24, y= 368.41),
    Room(name= "337", startDist= 9.793, hall= 28, x= 320.31, y= 368.41),
    Room(name= "338", startDist= 26.574, hall= 28, x= 337.507, y= 368.41),
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

# for i in intersects:
#   i.x = i.x # *1.197-42.64 + 71.68224299065426-68.94080901814404
#   i.y = i.y # *1.2-95.33+364.48598035770806-358.87 +390.18691588785066 - 389.5950146256208
#   print(f'Intersection(halls: [], id: {i.id}, x: {round(i.x,2)}, y: {round(i.y,2)}),')

for h in halls:
  s = intersects[h.start]
  e = intersects[h.end]
  h.length = round(dist(s.x,e.x,s.y,e.y),2)
  print(f'Hall(start: {h.start}, end: {h.end}, length: {h.length}, id: {h.id}),')


for i in rooms:
  i.x = i.x #*1.197-42.64 + 71.68224299065426-68.94080901814404
  i.y = i.y #*1.2-95.33+364.48598035770806-358.87+390.18691588785066 - 389.5950146256208
  s = intersects[halls[i.hall].start]
  i.startDist = round(dist(i.x, s.x, i.y, s.y),2)
  print(f'Room(name: "{i.name}", startDist: {i.startDist}, hall: {i.hall}, x: {round(i.x,2)}, y: {round(i.y,2)}),')

